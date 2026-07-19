@description('App Service Plan name')
param name string

@description('Azure region')
param location string

@description('App Service Plan SKU name (e.g. B1)')
param skuName string = 'B1'

@description('App Service Plan SKU tier (e.g. Basic)')
param skuTier string = 'Basic'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: name
  location: location
  sku: {
    name: skuName
    tier: skuTier
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output id string = appServicePlan.id
output name string = appServicePlan.name
