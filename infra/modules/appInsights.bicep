@description('Application Insights name')
param name string

@description('Azure region')
param location string

@description('Resource ID of the Log Analytics workspace backing this Application Insights instance')
param workspaceId string

resource appInsights 'microsoft.insights/components@2020-02-02' = {
  name: name
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspaceId
    IngestionMode: 'LogAnalytics'
  }
}

output id string = appInsights.id
output name string = appInsights.name
output connectionString string = appInsights.properties.ConnectionString
