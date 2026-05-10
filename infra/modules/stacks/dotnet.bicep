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
    suffix: 'dotnet6'
    linuxFxVersion: 'DOTNETCORE|6.0'
  }
  {
    suffix: 'dotnet7'
    linuxFxVersion: 'DOTNETCORE|7.0'
  }
  {
    suffix: 'dotnet8'
    linuxFxVersion: 'DOTNETCORE|8.0'
  }
  {
    suffix: 'dotnet9'
    linuxFxVersion: 'DOTNETCORE|9.0'
  }
]

module webApps '../web-app.bicep' = [for app in apps: {
  name: 'deploy-${app.suffix}'
  params: {
    name: '${webAppNamePrefix}-${app.suffix}'
    location: location
    appServicePlanId: appServicePlanId
    linuxFxVersion: app.linuxFxVersion
    tags: tags
  }
}]

output webAppNames array = [for app in apps: '${webAppNamePrefix}-${app.suffix}']
