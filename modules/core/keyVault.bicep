//Azure keyvault to keep the secrets and not reveal them within CICD deployment.

param keyVaultName string
param location string

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: '<azure-tenant-id>'
    accessPolicies: []
  }
}
