@description('GitHub Actions の AZURE_WEBAPP_NAME で使っているベース名。')
param webAppNamePrefix string

@description('共有 App Service Plan のリソース ID。')
param appServicePlanId string

@description('配置リージョン。')
param location string

@description('リソースタグ。')
param tags object = {}

var apps = [
  {
    suffix: 'express'
    appCommandLine: ''
    appSettings: {}
  }
  {
    suffix: 'nuxtjs'
    appCommandLine: 'node /home/site/wwwroot/node_modules/nuxt/bin/nuxt.js start'
    appSettings: {
      HOST: '0.0.0.0'
      NODE_ENV: 'production'
    }
  }
]

module webApps '../web-app.bicep' = [for app in apps: {
  name: 'deploy-${app.suffix}'
  params: {
    name: '${webAppNamePrefix}-${app.suffix}'
    location: location
    appServicePlanId: appServicePlanId
    linuxFxVersion: 'NODE|16-lts'
    appCommandLine: app.appCommandLine
    appSettings: app.appSettings
    tags: tags
  }
}]

output webAppNames array = [for app in apps: '${webAppNamePrefix}-${app.suffix}']
