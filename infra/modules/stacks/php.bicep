@description('GitHub Actions の AZURE_WEBAPP_NAME で使っているベース名。Laravel はこの名前をそのまま使う。')
param webAppNamePrefix string

@description('共有 App Service Plan のリソース ID。')
param appServicePlanId string

@description('配置リージョン。')
param location string

@description('Laravel 用の追加アプリ設定。APP_KEY などのシークレットはここから渡す。')
param laravelAppSettings object = {}

@description('リソースタグ。')
param tags object = {}

var apps = [
  {
    name: webAppNamePrefix
    linuxFxVersion: 'PHP|7.4'
    appCommandLine: ''
    appSettings: laravelAppSettings
  }
  {
    name: '${webAppNamePrefix}-php'
    linuxFxVersion: 'PHP|8.2'
    appCommandLine: ''
    appSettings: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: 'true'
    }
  }
  {
    name: '${webAppNamePrefix}-cakephp'
    linuxFxVersion: 'PHP|8.2'
    appCommandLine: ''
    appSettings: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: 'true'
    }
  }
]

module webApps '../web-app.bicep' = [for app in apps: {
  name: 'deploy-${replace(app.name, '_', '-')}'
  params: {
    name: app.name
    location: location
    appServicePlanId: appServicePlanId
    linuxFxVersion: app.linuxFxVersion
    appCommandLine: app.appCommandLine
    appSettings: app.appSettings
    tags: tags
  }
}]

output webAppNames array = [for app in apps: app.name]
