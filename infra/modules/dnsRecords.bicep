@description('Name of the existing DNS zone')
param dnsZoneName string

@description('Web app suffix, used as the custom domain subdomain, e.g. dotnet8')
param appSuffix string

@description('CNAME target, e.g. the Web App default hostname')
param cname string

@description('Domain verification ID of the target Web App')
param customDomainVerificationId string

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' existing = {
  name: dnsZoneName
}

resource cnameRecord 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  parent: dnsZone
  name: appSuffix
  properties: {
    TTL: 3600
    CNAMERecord: {
      cname: cname
    }
  }
}

resource txtRecord 'Microsoft.Network/dnsZones/TXT@2018-05-01' = {
  parent: dnsZone
  name: 'asuid.${appSuffix}'
  properties: {
    TTL: 3600
    TXTRecords: [
      {
        value: [
          customDomainVerificationId
        ]
      }
    ]
  }
}
