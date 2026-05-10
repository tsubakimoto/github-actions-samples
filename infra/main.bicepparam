using './main.bicep'

param webAppNamePrefix = 'gha-samples'

param appServicePlanName = 'asp-linux-gha-samples'

param appServicePlanSku = {
  name: 'B1'
  tier: 'Basic'
  capacity: 1
}

param laravelAppSettings = {
  APP_DEBUG: 'false'
}

param tags = {
  'managed-by': 'bicep'
  'source-repo': 'github-actions-samples'
  environment: 'production'
}
