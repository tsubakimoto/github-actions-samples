@description('Web app suffix, used as the custom domain subdomain, e.g. dotnet8')
param appSuffix string

@description('Custom domain name, e.g. example.com')
param customDomainName string

@description('Resource ID of the existing DNS zone for customDomainName')
param dnsZoneId string

@description('Name of the target Web App')
param webAppName string

@description('Thumbprint of the shared custom domain certificate, already imported into the App Service Plan')
param certificateThumbprint string

@description('Domain verification ID of the target Web App')
param customDomainVerificationId string

var fqdn = '${appSuffix}.${customDomainName}'

var dnsZoneIdSegments = split(dnsZoneId, '/')
var dnsZoneSubscriptionId = dnsZoneIdSegments[2]
var dnsZoneResourceGroupName = dnsZoneIdSegments[4]
var dnsZoneName = last(dnsZoneIdSegments)

resource webApp 'Microsoft.Web/sites@2024-11-01' existing = {
  name: webAppName
}

module dnsRecords 'dnsRecords.bicep' = {
  name: 'dnsRecords-${appSuffix}'
  scope: resourceGroup(dnsZoneSubscriptionId, dnsZoneResourceGroupName)
  params: {
    dnsZoneName: dnsZoneName
    appSuffix: appSuffix
    cname: '${webAppName}.azurewebsites.net'
    customDomainVerificationId: customDomainVerificationId
  }
}

resource hostNameBinding 'Microsoft.Web/sites/hostNameBindings@2024-11-01' = {
  parent: webApp
  name: fqdn
  properties: {
    sslState: 'SniEnabled'
    thumbprint: certificateThumbprint
    hostNameType: 'Verified'
  }
  dependsOn: [
    dnsRecords
  ]
}
