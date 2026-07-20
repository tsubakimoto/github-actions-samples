@description('Resource ID of the existing Key Vault')
param keyVaultId string

@description('Object ID of the principal to grant Key Vault Secrets User access to')
param principalId string

var keyVaultName = last(split(keyVaultId, '/'))

resource keyVault 'Microsoft.KeyVault/vaults@2024-11-01' existing = {
  name: keyVaultName
}

// Key Vault Secrets User: lets App Service read the certificate's underlying secret for import.
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVaultId, principalId, 'KeyVaultSecretsUser')
  scope: keyVault
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6')
    principalId: principalId
    principalType: 'ServicePrincipal'
  }
}
