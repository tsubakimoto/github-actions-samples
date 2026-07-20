@description('Azure region, must match the App Service Plan region')
param location string

@description('Web app suffix, used as the custom domain subdomain, e.g. dotnet8')
param appSuffix string

@description('Custom domain name, e.g. example.com')
param customDomainName string

@description('Resource ID of the existing DNS zone for customDomainName')
param dnsZoneId string

@description('Name of the existing Key Vault holding the TLS certificate')
param keyVaultName string

@description('Name of the certificate in the Key Vault Certificates blade to use for the custom domain')
param keyVaultCertificateName string

@description('Name of the target Web App')
param webAppName string

@description('Resource ID of the App Service Plan backing the certificate')
param serverFarmId string

@description('Domain verification ID of the target Web App')
param customDomainVerificationId string

var fqdn = '${appSuffix}.${customDomainName}'

var dnsZoneIdSegments = split(dnsZoneId, '/')
var dnsZoneSubscriptionId = dnsZoneIdSegments[2]
var dnsZoneResourceGroupName = dnsZoneIdSegments[4]
var dnsZoneName = last(dnsZoneIdSegments)

resource keyVault 'Microsoft.KeyVault/vaults@2024-11-01' existing = {
  name: keyVaultName
}

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

resource certificate 'Microsoft.Web/certificates@2024-11-01' = {
  name: '${appSuffix}-cert'
  location: location
  properties: {
    keyVaultId: keyVault.id
    // A Key Vault certificate's underlying secret always shares the certificate's name.
    keyVaultSecretName: keyVaultCertificateName
    serverFarmId: serverFarmId
  }
  dependsOn: [
    dnsRecords
  ]
}

resource hostNameBinding 'Microsoft.Web/sites/hostNameBindings@2024-11-01' = {
  parent: webApp
  name: fqdn
  properties: {
    sslState: 'SniEnabled'
    thumbprint: certificate.properties.thumbprint
    hostNameType: 'Verified'
  }
  dependsOn: [
    dnsRecords
  ]
}
