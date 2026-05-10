@description('Web App 名。')
param name string

@description('配置リージョン。')
param location string

@description('共有 App Service Plan のリソース ID。')
param appServicePlanId string

@description('Linux ランタイム文字列。例: NODE|16-lts')
param linuxFxVersion string

@description('kind。コンテナー以外は app,linux を使う。')
param kind string = 'app,linux'

@description('必要な場合だけ指定するスタートアップコマンド。')
param appCommandLine string = ''

@description('App Service のアプリ設定。')
param appSettings object = {}

@description('Basic 以上のプランで有効化する Always On。')
param alwaysOn bool = false

@description('リソースタグ。')
param tags object = {}

resource site 'Microsoft.Web/sites@2024-11-01' = {
  name: name
  location: location
  kind: kind
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: union({
      linuxFxVersion: linuxFxVersion
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
    }, empty(appCommandLine) ? {} : {
      appCommandLine: appCommandLine
    }, alwaysOn ? {
      alwaysOn: true
    } : {})
  }
  tags: tags
}

resource siteAppSettings 'Microsoft.Web/sites/config@2024-11-01' = if (!empty(appSettings)) {
  name: 'appsettings'
  parent: site
  properties: appSettings
}

output id string = site.id
output name string = site.name
