# GitHub Actions から Azure に OIDC 接続する設定

GitHub Actions の OIDC token を Microsoft Entra ID で検証し、Azure にログインする設定手順です。Client secret を発行・保存せずに、`azure/login` から Azure CLI などを実行できます。

この手順では、Entra ID のアプリ登録（Service Principal）に GitHub Environment 用の federated identity credential を追加します。例では Environment 名を `Production` とします。Workflow の `environment` と federated credential の subject は完全に一致させてください。

## 前提条件

- Azure CLI (`az`) と GitHub CLI (`gh`) がインストール済みで、それぞれ対象の Azure tenant / GitHub repository にサインインできること。
- Entra ID でアプリ登録と federated credential を作成できること（アプリ登録の作成権限、およびアプリの所有者または必要な Entra ロール）。
- GitHub repository で Environment と Environment secrets を管理できること。
- Azure リソースへデプロイする場合、Service Principal に対象リソースへ必要な Azure RBAC ロールを割り当てられること。ロール割り当てには対象スコープでの `roleAssignments/write` 権限が必要。

## 1. Azure と GitHub の接続を確認する

以下は PowerShell 7 の例です。`<...>` を対象の値に置き換えてください。

```powershell
$ErrorActionPreference = 'Stop'

$appName = '<Entra app display name>'
$repo = '<OWNER/REPOSITORY>'
$environment = 'Production'

az account show
gh auth status

$subscriptionId = az account show --query id -o tsv
$tenantId = az account show --query tenantId -o tsv
$repositoryInfo = gh api "repos/$repo" | ConvertFrom-Json
$owner = $repositoryInfo.owner.login
$repositoryName = $repositoryInfo.name
```

使用する subscription が現在選択されていることを確認します。必要であれば、先に `az account set --subscription <subscription-id>` を実行してください。`gh api` で取得した owner / repository の表記を後続の subject に使います。

## 2. Entra アプリと Service Principal を作成する

```powershell
$app = az ad app create --display-name $appName | ConvertFrom-Json
$clientId = $app.appId
$appObjectId = $app.id

$servicePrincipal = az ad sp create --id $clientId | ConvertFrom-Json
$servicePrincipalObjectId = $servicePrincipal.id
```

`clientId` は Workflow の `AZURE_CLIENT_ID`、`appObjectId` は federated credential の作成に使います。Azure RBAC の割り当て対象には Service Principal の object ID (`servicePrincipalObjectId`) を使います。これらの ID は秘密情報ではありませんが、Workflow で使いやすいように後述の Environment secrets に登録します。

## 3. GitHub Environment 用の federated credential を作成する

以下の値で信頼関係を作ります。

| 項目 | 値 |
|---|---|
| Issuer | `https://token.actions.githubusercontent.com` |
| Subject | `repo:<OWNER>/<REPOSITORY>:environment:<ENVIRONMENT>` |
| Audience | `api://AzureADTokenExchange` |

PowerShell で credential JSON を作成し、Azure CLI に渡します。

```powershell
$subject = "repo:${owner}/${repositoryName}:environment:${environment}"
$credentialName = "github-actions-$($environment.ToLowerInvariant() -replace '[^a-z0-9-]', '-')"
$credentialPath = Join-Path $env:TEMP "$credentialName.json"

$credential = [ordered]@{
    name = $credentialName
    issuer = 'https://token.actions.githubusercontent.com'
    subject = $subject
    description = "GitHub Actions for $repo ($environment)"
    audiences = @('api://AzureADTokenExchange')
}

try {
    $credential | ConvertTo-Json | Set-Content -Path $credentialPath -Encoding utf8
    az ad app federated-credential create --id $appObjectId --parameters $credentialPath
} finally {
    Remove-Item -Path $credentialPath -Force -ErrorAction SilentlyContinue
}
```

GitHub の標準 subject は `repo:<OWNER>/<REPOSITORY>:environment:<ENVIRONMENT>` です。owner / repository の数値 ID を含めないでください。Entra の federated credential は Workflow が提示する OIDC token の issuer、subject、audience と照合されます。組織で OIDC subject claim のカスタマイズを有効にしている場合は、実行ログに表示される subject に合わせます。名前の大文字・小文字も含めて一致させてください。

## 4. 必要な Azure RBAC ロールを割り当てる

Azure CLI で対象リソースに操作する場合、その操作に必要なロールを Service Principal に割り当てます。たとえば特定の Resource Group 内で広い操作が必要な場合は、次のように Resource Group スコープへ `Contributor` を割り当てられます。

```powershell
$resourceGroup = '<resource-group-name>'
$scope = az group show --name $resourceGroup --query id -o tsv

az role assignment create `
    --role Contributor `
    --assignee-object-id $servicePrincipalObjectId `
    --assignee-principal-type ServicePrincipal `
    --scope $scope
```

これは例です。実際には必要な操作に限定したロールを選び、可能な限り狭いスコープ（リソース単位または Resource Group）を指定します。Subscription 全体への `Contributor` 割り当ては、要件上必要な場合以外は避けてください。既存の権限を利用する場合、この手順は不要です。

## 5. GitHub Environment と secrets を設定する

GitHub CLI で Environment を作成し、3つの値を Environment secrets として登録します。Environment がすでに存在していても同じ API 呼び出しを利用できます。

```powershell
gh api "repos/$repo/environments/$environment" --method PUT

gh secret set AZURE_CLIENT_ID --body $clientId --repo $repo --env $environment
gh secret set AZURE_TENANT_ID --body $tenantId --repo $repo --env $environment
gh secret set AZURE_SUBSCRIPTION_ID --body $subscriptionId --repo $repo --env $environment
```

`AZURE_CLIENT_ID`、`AZURE_TENANT_ID`、`AZURE_SUBSCRIPTION_ID` は識別子であり、Client secret ではありません。Environment secrets にすることで、対象 Environment を使う Workflow に値を限定できます。必要に応じて GitHub の Environment protection rules（承認者、デプロイ可能なブランチなど）も設定してください。

## 6. Workflow から Azure にログインする

Workflow または対象 Job に `id-token: write` を設定し、`azure/login@v2` に3つの値を渡します。`id-token: write` は OIDC token を要求する権限であり、Azure リソースへの書き込み権限ではありません。

```yaml
permissions:
  id-token: write
  contents: read

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: Production
    steps:
      - name: Azure Login
        uses: azure/login@v2
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

このリポジトリの [Azure CLI ログイン（OIDC）Workflow](.github/workflows/azure-az-login-using-oidc.yml) は、`Production` Environment を使って Azure CLI コマンドを実行する例です。

## 動作確認とトラブルシューティング

1. GitHub Actions で対象 Workflow を実行し、`azure/login` が成功することを確認します。
2. 必要に応じて、後続の Azure CLI step で `az account show` を実行し、想定した subscription にログインできていることを確認します。
3. `AADSTS700213` などの federated identity credential 不一致が出た場合は、Workflow の Environment 名、credential の subject、owner / repository の大文字・小文字、issuer、audience を照合します。`azure/login` のログに表示される OIDC token の `subject claim` と federated credential の subject が一致する必要があります。
4. `id-token` を取得できない場合は `permissions` が Workflow / Job に設定されているか、Environment secrets が参照できない場合は `environment:` の値と secret の登録先が一致しているかを確認します。
5. ログインは成功するが Azure の操作が拒否される場合は、Service Principal に割り当てたロールと scope を確認します。Entra の federated credential を作成する権限と、Azure リソースを操作する RBAC 権限は別です。

## 参考資料

- [Microsoft Learn: GitHub Actions から Azure へ接続する](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure)
- [Microsoft Learn: Federated identity credential の作成](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation-create-trust)
- [GitHub Docs: Azure で OpenID Connect を設定する](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-azure)
- [Azure Login Action](https://github.com/Azure/login)
- [参考: github-entra-federated-credentials skill](https://github.com/tsubakimoto/skills/tree/main/github-entra-federated-credentials)
