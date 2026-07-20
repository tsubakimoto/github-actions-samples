targetScope = 'subscription'

@description('Azure region for all resources')
param location string = 'japaneast'

@description('Base name used to construct resource names')
param baseName string = 'yuta-gha-samples'

@description('App Service Plan SKU name')
param appServicePlanSkuName string = 'B1'

@description('App Service Plan SKU tier')
param appServicePlanSkuTier string = 'Basic'

@description('Log Analytics workspace daily ingestion cap in GB')
param logAnalyticsDailyQuotaGb int = 1

@description('Name of the existing DNS zone for custom domains. Leave empty to skip custom domain configuration.')
param customDomainZoneName string = ''

@description('Custom domain name; each app becomes {suffix}.{customDomainName}')
param customDomainName string = ''

@description('Name of the existing Key Vault holding the TLS certificate for the custom domains')
param keyVaultName string = ''

@description('Name of the certificate in the Key Vault Certificates blade to use for the custom domains')
param keyVaultCertificateName string = ''

var abbrs = loadJsonContent('abbreviations.json')
var uniqueSuffix = substring(uniqueString(subscription().subscriptionId, baseName), 0, 4)

var resourceGroupName = '${abbrs.resourcesResourceGroups}${baseName}-${uniqueSuffix}'
var appServicePlanName = '${abbrs.webServerFarms}${baseName}-${uniqueSuffix}'
var logAnalyticsName = '${abbrs.operationalInsightsWorkspaces}${baseName}-${uniqueSuffix}'
var appInsightsName = '${abbrs.insightsComponents}${baseName}-${uniqueSuffix}'

var useCustomDomain = !empty(customDomainZoneName) && !empty(customDomainName) && !empty(keyVaultName) && !empty(keyVaultCertificateName)

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
    name: appServicePlanName
    location: location
    skuName: appServicePlanSkuName
    skuTier: appServicePlanSkuTier
  }
  dependsOn: [
    rg
  ]
}

module logAnalytics 'modules/logAnalytics.bicep' = {
  name: 'logAnalytics'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: logAnalyticsName
    location: location
    dailyQuotaGb: logAnalyticsDailyQuotaGb
  }
  dependsOn: [
    rg
  ]
}

module appInsights 'modules/appInsights.bicep' = {
  name: 'appInsights'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: appInsightsName
    location: location
    workspaceId: logAnalytics.outputs.id
  }
}

module webApps 'modules/webApp.bicep' = [for app in apps: {
  name: 'webApp-${app.suffix}'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: '${abbrs.webSitesAppService}${baseName}-${app.suffix}-${uniqueSuffix}'
    location: location
    serverFarmId: appServicePlan.outputs.id
    linuxFxVersion: app.linuxFxVersion
    appInsightsConnectionString: appInsights.outputs.connectionString
  }
}]

module customDomains 'modules/customDomain.bicep' = [for (app, i) in apps: if (useCustomDomain) {
  name: 'customDomain-${app.suffix}'
  scope: resourceGroup(resourceGroupName)
  params: {
    location: location
    appSuffix: app.suffix
    customDomainName: customDomainName
    dnsZoneName: customDomainZoneName
    keyVaultName: keyVaultName
    keyVaultCertificateName: keyVaultCertificateName
    webAppName: webApps[i].outputs.name
    serverFarmId: appServicePlan.outputs.id
    customDomainVerificationId: webApps[i].outputs.customDomainVerificationId
  }
}]
