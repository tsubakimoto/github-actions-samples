# github-actions-samples
GitHub Actionsを色々試すリポジトリ

## .NET

### ASP.NET Core

#### アプリケーション設定
不要

#### 全般設定
- スタートアップコマンド：不要

## Python

### Django

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

### FastAPI

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

### Express

#### アプリケーション設定
不要

#### 全般設定
- スタートアップコマンド：不要

## PHP

### フレームワーク無し

#### アプリケーション設定
不要

#### 全般設定
- スタートアップコマンド：不要

## Azure

### App Service
https://github.com/marketplace/actions/azure-app-service-settings

- アプリケーション設定
  - `[{"name":"key1","value":"value1","slotSetting":false}]`
- 全般設定
  - `{"linuxFxVersion":"DOTNETCORE|5.0", "appCommandLine":"this-is-startup-command"}`
