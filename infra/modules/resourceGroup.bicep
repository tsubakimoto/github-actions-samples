targetScope = 'subscription'

@description('Resource group name')
param name string

@description('Azure region')
param location string

resource rg 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: name
  location: location
}

output name string = rg.name
