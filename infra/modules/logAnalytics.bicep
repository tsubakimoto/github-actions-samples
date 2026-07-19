@description('Log Analytics workspace name')
param name string

@description('Azure region')
param location string

@description('Daily ingestion cap in GB')
param dailyQuotaGb int = 1

@description('Data retention in days')
param retentionInDays int = 30

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: name
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: retentionInDays
    workspaceCapping: {
      dailyQuotaGb: dailyQuotaGb
    }
  }
}

output id string = logAnalytics.id
output name string = logAnalytics.name
