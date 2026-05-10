@description('コンテナー Web App 名。')
param appName string

@description('共有 App Service Plan のリソース ID。')
param appServicePlanId string

@description('配置リージョン。')
param location string

@description('コンテナーイメージ。例: ghcr.io/owner/repo:tag')
param containerImage string

@description('追加のアプリ設定。')
param appSettings object = {}

@description('リソースタグ。')
param tags object = {}

module webApp '../web-app.bicep' = {
  name: 'deploy-${replace(appName, '_', '-')}'
  params: {
    name: appName
    location: location
    appServicePlanId: appServicePlanId
    kind: 'app,linux,container'
    linuxFxVersion: 'DOCKER|${containerImage}'
    appSettings: union({
      WEBSITES_PORT: '80'
    }, appSettings)
    tags: tags
  }
}

output webAppName string = webApp.outputs.name
