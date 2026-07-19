@description('Web App name')
param name string

@description('Azure region')
param location string

@description('Resource ID of the App Service Plan hosting this app')
param serverFarmId string

@description('Linux runtime stack, e.g. DOTNETCORE|8.0, NODE|20-lts, PHP|8.2, PYTHON|3.12')
param linuxFxVersion string

resource webApp 'Microsoft.Web/sites@2024-11-01' = {
  name: name
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: serverFarmId
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: true
    }
  }
}

output id string = webApp.id
output name string = webApp.name
output defaultHostName string = webApp.properties.defaultHostName
