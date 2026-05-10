# Azure App Service 基盤のデプロイ

このディレクトリでは、複数のランタイムスタック（.NET、Python、Node.js、PHP）に対応した Azure App Service を Bicep でデプロイします。

## 概要

- **共有 Linux App Service Plan**: 複数の Web App で共有する基盤
- **スタック別 Web App**: ランタイムごとにモジュール化した Web App 定義
  - .NET: .NET 6, 7, 8, 9
  - Python: Django, FastAPI
  - Node.js: Express, NuxtJS
  - PHP: Laravel, Simple, CakePHP
  - Container: コンテナー版 CakePHP（オプション）

## ファイル構成

```
infra/
├── main.bicep                         # エントリーポイント（共有プランと各スタックをモジュール化）
├── main.bicepparam                    # 標準デプロイ用パラメーター
├── main.container.bicepparam          # コンテナー版含むデプロイ用パラメーター
├── modules/
│   ├── app-service-plan-linux.bicep   # 共有 Linux App Service Plan
│   ├── web-app.bicep                  # 共通 Web App リソース定義
│   └── stacks/
│       ├── dotnet.bicep               # .NET スタック（6/7/8/9）
│       ├── python.bicep               # Python スタック（Django/FastAPI）
│       ├── node.bicep                 # Node.js スタック（Express/NuxtJS）
│       ├── php.bicep                  # PHP スタック（Laravel/Simple/CakePHP）
│       └── container.bicep            # コンテナー版 Web App
└── README.md                          # このファイル
```

## 前提条件

- Azure CLI (`az` コマンド)
- Azure サブスクリプションおよび適切な権限
- Bicep CLI（`az bicep` コマンドで統合済み）

## デプロイ手順

### 1. Azure へのログイン

```bash
az login
```

対話型ブラウザーが開きます。必要に応じてテナント/サブスクリプションを切り替えてください。

```bash
# テナント指定
az login --tenant <tenant-id-or-name>

# サブスクリプション指定
az account set --subscription <subscription-id-or-name>
```

### 2. リソースグループの確認/作成

デプロイ先のリソースグループを確認またはプロビジョニングします。

```bash
# リソースグループの確認
az group show --name rg-github-actions-samples

# 存在しなければ作成
az group create \
  --name rg-github-actions-samples \
  --location japaneast
```

### 3. 標準デプロイ（Web App のみ）

`main.bicepparam` を使用します。

```bash
az deployment group create \
  --name deploy-webapps \
  --resource-group rg-github-actions-samples \
  --template-file infra/main.bicep \
  --parameters infra/main.bicepparam
```

これにより以下が作成されます：
- App Service Plan: `asp-linux-gha-samples` (Basic B1)
- .NET Web Apps: `gha-samples-dotnet6`, `gha-samples-dotnet7`, `gha-samples-dotnet8`, `gha-samples-dotnet9`
- Python Web Apps: `gha-samples-django`, `gha-samples-fastapi`
- Node.js Web Apps: `gha-samples-express`, `gha-samples-nuxtjs`
- PHP Web Apps: `gha-samples`, `gha-samples-php`, `gha-samples-cakephp`

### 4. コンテナー版を含むデプロイ

`main.container.bicepparam` を使用します。

```bash
az deployment group create \
  --name deploy-webapps-with-container \
  --resource-group rg-github-actions-samples \
  --template-file infra/main.bicep \
  --parameters infra/main.container.bicepparam
```

これにより、上記に加えて以下が作成されます：
- Container Web App: `github-actions-samples-cakephp5-container` (CakePHP 5)

### 5. デプロイ結果の確認

```bash
# リソースグループ内の Web App 一覧
az webapp list \
  --resource-group rg-github-actions-samples \
  --query "[].{name:name, appServicePlanId:appServicePlanId, state:state}" \
  -o table

# 特定の Web App の詳細
az webapp show \
  --name gha-samples-dotnet6 \
  --resource-group rg-github-actions-samples
```

## パラメーターのカスタマイズ

### Web App 名の変更

`main.bicepparam` (または `main.container.bicepparam`) の `webAppNamePrefix` を編集します。

```bicep
param webAppNamePrefix = 'your-custom-prefix'
```

すると Web App 名が以下のようになります（例：`your-custom-prefix-dotnet6`）。

### App Service Plan SKU の変更

必要に応じて SKU を変更できます：

```bicep
param appServicePlanSku = {
  name: 'S1'          # Standard S1
  tier: 'Standard'
  capacity: 2         # スケールアウト
}
```

利用可能な SKU については [Azure App Service の価格](https://azure.microsoft.com/ja-jp/pricing/details/app-service/) を参照してください。

### Laravel の APP_KEY 設定

`laravelAppSettings` に APP_KEY を追加します：

```bicep
param laravelAppSettings = {
  APP_DEBUG: 'false'
  APP_KEY: 'base64:your-app-key-here'
}
```

`APP_KEY` の生成方法については [Laravel ドキュメント](https://laravel.com/docs/) を参照してください。

### コンテナーイメージの変更

`main.container.bicepparam` の `containerImage` を編集します：

```bicep
param containerImage = 'your-registry.azurecr.io/your-image:your-tag'
```

### タグの追加

全リソースに付与されるタグをカスタマイズできます：

```bicep
param tags = {
  'managed-by': 'bicep'
  'source-repo': 'github-actions-samples'
  environment: 'production'
  'cost-center': 'engineering'
}
```

## トラブルシューティング

### デプロイの検証（ドライラン）

実際にリソースを作成する前に、テンプレートが有効かを確認します：

```bash
az deployment group validate \
  --resource-group rg-github-actions-samples \
  --template-file infra/main.bicep \
  --parameters infra/main.bicepparam
```

### デプロイログの確認

失敗時はデプロイログで詳細を確認します：

```bash
# 最新デプロイの詳細
az deployment group show \
  --name deploy-webapps \
  --resource-group rg-github-actions-samples \
  --query properties.outputs \
  -o json
```

### リソースの削除

全リソースを削除する場合（リソースグループごと）：

```bash
az group delete \
  --name rg-github-actions-samples \
  --yes --no-wait
```

## 出力値

デプロイ完了後、以下の出力が得られます：

- `appServicePlanId`: 共有 App Service Plan のリソース ID
- `dotnetWebApps`: .NET Web App 名の配列
- `pythonWebApps`: Python Web App 名の配列
- `nodeWebApps`: Node.js Web App 名の配列
- `phpWebApps`: PHP Web App 名の配列
- `containerWebApps`: コンテナー Web App 名の配列（コンテナーデプロイ時）

## GitHub Actions での自動デプロイ

このテンプレートは GitHub Actions ワークフローから呼び出せます。例：

```yaml
- name: Deploy to Azure
  run: |
    az deployment group create \
      --name deploy-from-gha-${{ github.run_id }} \
      --resource-group rg-github-actions-samples \
      --template-file infra/main.bicep \
      --parameters infra/main.bicepparam
```

詳細は `.github/workflows/` の既存ワークフローを参照してください。

## 参考リンク

- [Bicep ドキュメント](https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/bicep/)
- [Azure App Service ドキュメント](https://learn.microsoft.com/ja-jp/azure/app-service/)
- [Azure CLI リファレンス](https://learn.microsoft.com/ja-jp/cli/azure/)
