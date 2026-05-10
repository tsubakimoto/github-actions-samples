using './main.bicep'

param webAppNamePrefix = 'github-actions-samples'

param appServicePlanName = 'asp-linux-github-actions-samples'

param appServicePlanSku = {
  name: 'B1'
  tier: 'Basic'
  capacity: 1
}

param containerWebAppName = 'github-actions-samples-cakephp5-container'

param containerImage = 'ghcr.io/tsubakimoto/github-actions-samples-cakephp5:latest'

param laravelAppSettings = {
  APP_DEBUG: 'false'
}

param tags = {
  'managed-by': 'bicep'
  'source-repo': 'github-actions-samples'
  environment: 'production'
}
