@description('共有 Linux App Service Plan 名。')
param name string

@description('配置リージョン。')
param location string

@description('App Service Plan SKU。')
param sku object = {
  name: 'B1'
  tier: 'Basic'
  capacity: 1
}

@description('リソースタグ。')
param tags object = {}

resource plan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: name
  location: location
  kind: 'linux'
  sku: {
    name: sku.name
    tier: sku.tier
    size: sku.name
    capacity: sku.capacity
  }
  properties: {
    reserved: true
  }
  tags: tags
}

output id string = plan.id
output name string = plan.name
