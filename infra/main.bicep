targetScope = 'subscription'

@description('Azure region for all resources')
param location string = 'japaneast'

@description('Base name used to construct resource names')
param baseName string = 'yuta-gha-samples'

@description('Resource group name')
param resourceGroupName string = 'rg-${baseName}'

@description('App Service Plan SKU name')
param appServicePlanSkuName string = 'B1'

@description('App Service Plan SKU tier')
param appServicePlanSkuTier string = 'Basic'

var apps = [
  { suffix: 'dotnet6', linuxFxVersion: 'DOTNETCORE|6.0' }
  { suffix: 'dotnet7', linuxFxVersion: 'DOTNETCORE|7.0' }
  { suffix: 'dotnet8', linuxFxVersion: 'DOTNETCORE|8.0' }
  { suffix: 'dotnet9', linuxFxVersion: 'DOTNETCORE|9.0' }
  { suffix: 'dotnet10', linuxFxVersion: 'DOTNETCORE|10.0' }
  { suffix: 'express', linuxFxVersion: 'NODE|20-lts' }
  { suffix: 'nuxtjs', linuxFxVersion: 'NODE|20-lts' }
  { suffix: 'php', linuxFxVersion: 'PHP|8.2' }
  { suffix: 'cakephp', linuxFxVersion: 'PHP|8.2' }
  { suffix: 'laravel', linuxFxVersion: 'PHP|8.2' }
  { suffix: 'django', linuxFxVersion: 'PYTHON|3.12' }
  { suffix: 'fastapi', linuxFxVersion: 'PYTHON|3.12' }
]

module rg 'modules/resourceGroup.bicep' = {
  name: 'resourceGroup'
  params: {
    name: resourceGroupName
    location: location
  }
}

module appServicePlan 'modules/appServicePlan.bicep' = {
  name: 'appServicePlan'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: 'plan-${baseName}'
    location: location
    skuName: appServicePlanSkuName
    skuTier: appServicePlanSkuTier
  }
  dependsOn: [
    rg
  ]
}

module webApps 'modules/webApp.bicep' = [for app in apps: {
  name: 'webApp-${app.suffix}'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: 'app-${baseName}-${app.suffix}'
    location: location
    serverFarmId: appServicePlan.outputs.id
    linuxFxVersion: app.linuxFxVersion
  }
}]
