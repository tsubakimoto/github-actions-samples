@description('Certificate resource name')
param name string

@description('Azure region, must match the App Service Plan region')
param location string

@description('Resource ID of the existing Key Vault holding the TLS certificate')
param keyVaultId string

@description('Name of the certificate in the Key Vault Certificates blade to import')
param keyVaultCertificateName string

@description('Resource ID of the App Service Plan backing the certificate')
param serverFarmId string

resource certificate 'Microsoft.Web/certificates@2024-11-01' = {
  name: name
  location: location
  properties: {
    keyVaultId: keyVaultId
    // A Key Vault certificate's underlying secret always shares the certificate's name.
    keyVaultSecretName: keyVaultCertificateName
    serverFarmId: serverFarmId
  }
}

output thumbprint string = certificate.properties.thumbprint
