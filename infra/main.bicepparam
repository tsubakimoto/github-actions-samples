using 'main.bicep'

param location = 'southeastasia'
param baseName = 'yuta-gha-samples'
param resourceGroupName = 'rg-${baseName}'
param appServicePlanSkuName = 'B1'
param appServicePlanSkuTier = 'Basic'
