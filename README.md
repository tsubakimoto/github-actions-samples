# github-actions-samples
GitHub Actionsを色々試すリポジトリ

## .NET

### ASP.NET Core

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
