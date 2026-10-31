# github-actions-samples
GitHub Actionsを色々試すリポジトリ

[![GitHub Super-Linter](https://github.com/tsubakimoto/github-actions-samples/actions/workflows/linter.yml/badge.svg)](https://github.com/marketplace/actions/super-linter)

## GitHub Actions ワークフロー

`.github/workflows/` にあるワークフローのサンプルです。

### 基本機能・実行環境
- [Hello world](.github/workflows/hello-world.yml)：ワークフローからシェルコマンドを実行する基本例
- [手動実行と入力](.github/workflows/manual.yml)：実行時の入力値と GitHub-hosted runner の選択例
- [Dockerコンテナーアクション](.github/workflows/hello-world-docker-action.yml)：入力値を Docker コンテナーアクションに渡して実行
- [Dockerコンテナーアクション（複数ジョブ）](.github/workflows/hello-world-docker-action-2.yml)：依存関係のある複数ジョブから Docker コンテナーアクションを実行
- [GitHub Actions Context](.github/workflows/github-actions-context-dump.yml)：GitHub Actions のコンテキスト情報を出力
- [環境・入力値](.github/workflows/github-actions-environments-inputs.yml)：コンテキスト情報と環境変数を確認
- [ジョブサマリー](.github/workflows/github-actions-job-summaries.yml)：Markdown を使ってジョブサマリーを作成
- [イベントトリガー](.github/workflows/various-triggers.yml)：Issue、Discussion、コメントの各イベントで実行
- [親ワークフロー](.github/workflows/workflow-trigger-parent.yml)：子ワークフローの起点となるワークフロー
- [子ワークフロー](.github/workflows/workflow-trigger-child.yml)：親ワークフローの完了後、成功・失敗に応じて実行
- [再利用可能なワークフローの呼び出し](.github/workflows/resusable-workflow.yml)：別のワークフローを呼び出し、入力値と Secret を渡す
- [Runner 情報](.github/workflows/runner-display.yml)：複数 OS の runner 情報を表示
- [Windows runner](.github/workflows/windows-runner.yml)：Windows runner の OS 情報を表示
- [ブランチ情報](.github/workflows/github-branch-dump.yml)：ブランチ情報を出力
- [Artifact Attestations](.github/workflows/github-artifact-attestations.yml)：.NET アプリを発行し、Artifact Attestation を作成
- [Super-Linter](.github/workflows/linter.yml)：Super-Linter でリポジトリのコードを検査
- [Docker実行環境](.github/workflows/docker-run-in-workflow.yml)：runner 上の Docker 実行環境を確認

### GitHub・リポジトリ操作
- [複数リポジトリのチェックアウト](.github/workflows/checkout-repositories.yml)：自分や他の所有者の公開・非公開リポジトリをチェックアウト
- [別ホスティングサービスのリポジトリのチェックアウト](.github/workflows/checkout-another-repositories.yml)：GitLab の公開リポジトリをシェルからチェックアウト
- [Git タグの作成](.github/workflows/git-tag-creation.yml)：入力された名前でタグを作成し、リモートへ push
- [GitHub CLI でリポジトリ一覧を取得](.github/workflows/github-cli-list-repos.yml)：GitHub CLI でリポジトリ一覧を表示
- [GitHub CLI で Issue を作成](.github/workflows/github-issue-creatation-using-gh.yml)：GitHub CLI を使って Issue を作成
- [Marketplace Action で Issue を作成](.github/workflows/github-issue-creatation-using-marketplace.yml)：Marketplace の Action を使って Issue を作成
- [定期的に Issue を作成](.github/workflows/github-issue-daily-creatation-using-marketplace.yml)：Marketplace の Action で日次の Issue 作成を実行
- [Pull Request の作成](.github/workflows/github-pull-request-creation.yml)：ワークフローから Pull Request を作成
- [GitHub Release の作成](.github/workflows/github-release-creation.yml)：Action を使って GitHub Release を作成
- [タグ作成後に Release を作成](.github/workflows/github-release-creation-on-tag-push.yml)：タグ作成後のワークフロー実行を受けて Release を作成
- [GitHub Pages への公開](.github/workflows/github-pages-html.yml)：Artifact を GitHub Pages にデプロイ
- [リポジトリへのコミット](.github/workflows/github-repository-commit.yml)：ワークフローからファイルを変更し、ブランチへコミット
- [Dependabot PR の自動承認](.github/workflows/dependabot-auto-approve.yml)：Dependabot の Pull Request を条件付きで承認
- [Dependabot メタデータの取得](.github/workflows/dependabot-fetch-metadata.yml)：Dependabot の Pull Request 情報を取得
- [.NET SDK の更新](.github/workflows/update-dotnet-sdk.yml)：定期または手動で `dotnet/global.json` の SDK 更新を実行

### AI
- [AI Inference Action](.github/workflows/ai-inference.yml)：入力したプロンプトを AI Inference Action に渡し、応答をジョブサマリーに出力
- [GitHub Models](.github/workflows/gh-models.yml)：GitHub Models の推論 API にプロンプトを送り、応答を出力
- [GitHub Copilot CLI](.github/workflows/github-copilot-cli.yml)：GitHub Copilot CLI をセットアップして実行

### .NET
- [ASP.NET Core 6](.github/workflows/net60-aspnetcore.yml)：ASP.NET Core 6 アプリをビルドし、Azure App Service にデプロイ
- [ASP.NET Core 6（NuGet キャッシュ）](.github/workflows/net60-aspnetcore-cached.yml)：NuGet パッケージをキャッシュして ASP.NET Core 6 アプリをビルド・発行
- [ASP.NET Core 7](.github/workflows/net70-aspnetcore.yml)：ASP.NET Core 7 アプリをビルドし、Azure App Service にデプロイ
- [ASP.NET Core 8](.github/workflows/net80-aspnetcore.yml)：ASP.NET Core 8 アプリをビルドし、Azure App Service にデプロイ
- [ASP.NET Core 9](.github/workflows/net90-aspnetcore.yml)：ASP.NET Core 9 アプリをビルドし、Azure App Service にデプロイ
- [ASP.NET Core 10](.github/workflows/net100-aspnetcore.yml)：ASP.NET Core 10 アプリをビルドし、Azure App Service にデプロイ
- [.NET 8 の dotnet-format](.github/workflows/net80-dotnet-format.yml)：`dotnet format` を実行し、変更をコミット
- [.NET 8 のフォーマット Action](.github/workflows/net80-dotnet-format-action.yml)：`tsubakimoto/action-dotnet-format` を使ってコードをフォーマット
- [eShop のビルド](.github/workflows/net80-eshop.yml)：eShop の依存関係を復元してビルド
- [.NET 10 C# スクリプト](.github/workflows/net100-scripting.yml)：`.NET 10` で C# スクリプトを実行
- [.NET 10 C# スクリプト（shebang）](.github/workflows/net100-scripting-shebang.yml)：shebang を使って C# スクリプトを実行
- [.NET Standard 2.0 パッケージ](.github/workflows/netstandard20-package.yml)：NuGet パッケージを作成・発行し、GitHub Release を作成

### Azure
- [Azure CLI ログイン（OIDC）](.github/workflows/azure-az-login-using-oidc.yml)：OIDC で Azure CLI にログインしてコマンドを実行
- [Azure CLI ログイン（サービスプリンシパル）](.github/workflows/azure-az-login-using-service-principal.yml)：サービスプリンシパルで Azure CLI にログインしてコマンドを実行
- [Azure Bicep](.github/workflows/azure-bicep.yml)：Bicep テンプレートをデプロイし、設定に応じてリソースグループを削除
- [Azure App Service 設定](.github/workflows/azure-app-service-settings.yml)：App Service のアプリケーション設定と全般設定を更新
- [Azure App Service スロットの入れ替え](.github/workflows/azure-app-service-swap.yml)：App Service のデプロイスロットを入れ替え
- [Azure SQL 接続文字列](.github/workflows/azure-sql-using-conn-string.yml)：接続文字列を使って Azure SQL に接続し、SQL スクリプトを実行

### コンテナー
- [Nginx イメージのビルド](.github/workflows/docker-build-nginx.yml)：Nginx の Docker イメージをビルド
- [Express イメージを GHCR に公開](.github/workflows/docker-publish-to-ghcr-express.yml)：Express の Docker イメージを GitHub Container Registry に公開して署名
- [Nginx イメージを GHCR に公開](.github/workflows/docker-publish-to-ghcr-nginx.yml)：Nginx の Docker イメージを GitHub Container Registry に公開して署名

### Node.js
- [Express](.github/workflows/node-express.yml)：Express アプリをビルドし、Artifact 経由で Azure App Service にデプロイ
- [Express（ZIP）](.github/workflows/node-express-with-zip.yml)：Express アプリを ZIP 化して Azure App Service にデプロイ
- [Express（Artifact なし）](.github/workflows/node-express-without-artifact.yml)：Artifact を使わずに Express アプリを Azure App Service にデプロイ
- [Nuxt.js on Azure App Service](.github/workflows/node-nuxtjs-on-azure-app-service.yml)：Nuxt.js アプリをビルドし、Azure App Service にデプロイ
- [Nuxt.js on Azure App Service（ZIP）](.github/workflows/node-nuxtjs-on-azure-app-service-with-zip.yml)：Nuxt.js アプリを ZIP 化して Azure App Service にデプロイ
- [Nuxt.js on Azure Static Web Apps](.github/workflows/node-nuxtjs.yml)：Nuxt.js アプリを Azure Static Web Apps に公開し、Pull Request のクローズ時に環境をクリーンアップ

### PHP
- [CakePHP 5](.github/workflows/php-cakephp5.yml)：CakePHP 5 アプリをビルドし、Azure App Service にデプロイ
- [CakePHP 5 コンテナー](.github/workflows/php-cakephp5-container.yml)：CakePHP 5 のコンテナーイメージを GHCR に公開し、Azure App Service にデプロイ
- [Laravel](.github/workflows/php-laravel.yml)：Laravel アプリをビルドし、Azure App Service にデプロイ
- [PHP（フレームワークなし）](.github/workflows/php-simple.yml)：PHP アプリをパッケージ化し、Azure App Service にデプロイ

### Python
- [Django](.github/workflows/python-django.yml)：Django アプリをビルドし、Azure App Service にデプロイ
- [FastAPI](.github/workflows/python-fastapi.yml)：FastAPI アプリをビルドし、Azure App Service にデプロイ

### テスト
- [Playwright](.github/workflows/playwright.yml)：Playwright のブラウザーテストを実行し、テストレポートを保存
- [Postman CLI](.github/workflows/postman-collection.yml)：Postman CLI で API テストを実行

### 外部サービス連携
- [REST API の呼び出し](.github/workflows/call-rest-api.yml)：`curl` で REST API を呼び出し、JSON を表示
- [Microsoft Teams 通知](.github/workflows/notify-to-teams.yml)：Microsoft Teams に通知を送信

## .NET

### [ASP.NET Core 6](dotnet/net6.0/razorpageapp)

#### アプリケーション設定
不要

#### 全般設定
- スタートアップコマンド：不要

### [ASP.NET Core 7](dotnet/net7.0/razorpageapp)

#### アプリケーション設定
不要

#### 全般設定
- スタートアップコマンド：不要

### [ASP.NET Core 8](dotnet/net8.0/razorpageapp)

#### アプリケーション設定
不要

#### 全般設定
- スタートアップコマンド：不要

## Python

### [Django](python/django/)

#### アプリケーション設定
```json
{
  "name": "SCM_DO_BUILD_DURING_DEPLOYMENT",
  "value": "1",
  "slotSetting": false
}
```

#### 全般設定
- スタートアップコマンド：不要

### [FastAPI](python/fastapi/)

#### アプリケーション設定
```json
{
  "name": "SCM_DO_BUILD_DURING_DEPLOYMENT",
  "value": "1",
  "slotSetting": false
}
```

#### 全般設定
- スタートアップコマンド：`python -m uvicorn main:app --host 0.0.0.0`

## Node

### [Express](nodejs/express/)

#### アプリケーション設定
不要

#### 全般設定
- スタートアップコマンド：不要

### [NuxtJS](nodejs/nuxtjs/)

#### Azure App Service

##### アプリケーション設定
```json
[
  {
    "name": "HOST",
    "value": "0.0.0.0",
    "slotSetting": false
  },
  {
    "name": "NODE_ENV",
    "value": "production",
    "slotSetting": false
  }
]
```

##### 全般設定
- スタートアップコマンド：`node /home/site/wwwroot/node_modules/nuxt/bin/nuxt.js start`

#### Azure Static Web Apps
[Tutorial: Deploy server-rendered Nuxt.js websites on Azure Static Web Apps | Microsoft Docs](https://docs.microsoft.com/en-us/azure/static-web-apps/deploy-nuxtjs?WT.mc_id=AZ-MVP-5002209)

## PHP

### [フレームワーク無し](php/simple/)

#### アプリケーション設定
不要

#### 全般設定
- スタートアップコマンド：不要

### [Laravel](php/laravel)

#### アプリケーション設定
- `APP_KEY` : `php artisan key:generate --show` で生成されたキー
  - https://docs.microsoft.com/ja-jp/azure/app-service/tutorial-php-mysql-app?pivots=platform-linux#configure-laravel-environment-variables
- `APP_DEBUG` : `true` or `false`

#### 全般設定
- マイナーバージョン : PHP 7.4
- スタートアップコマンド：不要

## Azure

### App Service
https://github.com/marketplace/actions/azure-app-service-settings

- アプリケーション設定
  - `[{"name":"key1","value":"value1","slotSetting":false}]`
- 全般設定
  - `{"linuxFxVersion":"DOTNETCORE|5.0", "appCommandLine":"this-is-startup-command"}`

## コンテナー

### ビルド・発行
- [Dockerイメージの公開 - GitHub Docs](https://docs.github.com/ja/actions/publishing-packages/publishing-docker-images)

## GitHub

- トークンでの認証
  - [Automatic token authentication - GitHub Docs](https://docs.github.com/en/actions/security-guides/automatic-token-authentication)
  - [\[GitHub\]secrets.GITHUB_TOKENで実行できる権限について簡単ながらマッピングしてみた | DevelopersIO](https://dev.classmethod.jp/articles/mapping-secrets-github-token/)
- Issue作成
  - [Create an issue · Actions · GitHub Marketplace](https://github.com/marketplace/actions/create-an-issue)

### トリガー
- [Triggering a workflow - GitHub Docs](https://docs.github.com/ja/actions/using-workflows/triggering-a-workflow)
- [ワークフローをトリガーするイベント - GitHub Docs](https://docs.github.com/ja/actions/using-workflows/events-that-trigger-workflows#issues)

### Teamsへの通知
[Notify Teams · Actions · GitHub Marketplace](https://github.com/marketplace/actions/notify-teams)
