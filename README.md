# github-actions-samples
GitHub Actionsを色々試すリポジトリ

## .NET

### [ASP.NET Core](dotnet/aspnetcore/)

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


Sun Jul 23 04:18:14 UTC 2023
