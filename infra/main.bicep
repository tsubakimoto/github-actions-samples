targetScope = 'resourceGroup'

@description('GitHub Actions の AZURE_WEBAPP_NAME で使っているベース名。Laravel はこの名前をそのまま使い、他のアプリはサフィックスを付与する。')
param webAppNamePrefix string

@description('共有する Linux App Service Plan 名。')
param appServicePlanName string = 'asp-linux-github-actions-samples'

@description('Azure リソースの配置リージョン。')
param location string = resourceGroup().location

@description('共有 Linux App Service Plan の SKU。')
param appServicePlanSku object = {
	name: 'B1'
	tier: 'Basic'
	capacity: 1
}

@description('コンテナー版 CakePHP Web App 名。空文字の場合はコンテナー Web App を作成しない。')
param containerWebAppName string = ''

@description('コンテナー版 CakePHP Web App で使うイメージ。')
param containerImage string = 'ghcr.io/tsubakimoto/github-actions-samples-cakephp5:latest'

@description('Laravel 用の追加アプリ設定。APP_KEY などのシークレットはここから渡す。')
param laravelAppSettings object = {}

@description('全リソースに付与するタグ。')
param tags object = {
	'managed-by': 'bicep'
	'source-repo': 'github-actions-samples'
}

module appServicePlan 'modules/app-service-plan-linux.bicep' = {
	name: 'shared-linux-app-service-plan'
	params: {
		name: appServicePlanName
		location: location
		sku: appServicePlanSku
		tags: tags
	}
}

module dotnet 'modules/stacks/dotnet.bicep' = {
	name: 'dotnet-webapps'
	params: {
		webAppNamePrefix: webAppNamePrefix
		appServicePlanId: appServicePlan.outputs.id
		location: location
		tags: tags
	}
}

module python 'modules/stacks/python.bicep' = {
	name: 'python-webapps'
	params: {
		webAppNamePrefix: webAppNamePrefix
		appServicePlanId: appServicePlan.outputs.id
		location: location
		tags: tags
	}
}

module node 'modules/stacks/node.bicep' = {
	name: 'node-webapps'
	params: {
		webAppNamePrefix: webAppNamePrefix
		appServicePlanId: appServicePlan.outputs.id
		location: location
		tags: tags
	}
}

module php 'modules/stacks/php.bicep' = {
	name: 'php-webapps'
	params: {
		webAppNamePrefix: webAppNamePrefix
		appServicePlanId: appServicePlan.outputs.id
		location: location
		laravelAppSettings: laravelAppSettings
		tags: tags
	}
}

module container 'modules/stacks/container.bicep' = if (!empty(containerWebAppName)) {
	name: 'container-webapps'
	params: {
		appName: containerWebAppName
		appServicePlanId: appServicePlan.outputs.id
		location: location
		containerImage: containerImage
		tags: tags
	}
}

output appServicePlanId string = appServicePlan.outputs.id
output dotnetWebApps array = dotnet.outputs.webAppNames
output pythonWebApps array = python.outputs.webAppNames
output nodeWebApps array = node.outputs.webAppNames
output phpWebApps array = php.outputs.webAppNames
output containerWebApps array = empty(containerWebAppName) ? [] : [container!.outputs.webAppName]
