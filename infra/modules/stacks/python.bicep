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
    suffix: 'django'
    appCommandLine: ''
    appSettings: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: '1'
    }
  }
  {
    suffix: 'fastapi'
    appCommandLine: 'python -m uvicorn main:app --host 0.0.0.0'
    appSettings: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: '1'
    }
  }
]

module webApps '../web-app.bicep' = [for app in apps: {
  name: 'deploy-${app.suffix}'
  params: {
    name: '${webAppNamePrefix}-${app.suffix}'
    location: location
    appServicePlanId: appServicePlanId
    linuxFxVersion: 'PYTHON|3.12'
    appCommandLine: app.appCommandLine
    appSettings: app.appSettings
    tags: tags
  }
}]

output webAppNames array = [for app in apps: '${webAppNamePrefix}-${app.suffix}']
