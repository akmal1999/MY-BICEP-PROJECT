param storageAccountName string
param location string
param sku string = 'Standard_LRS' // Change SKU as necessary
param kind string = 'StorageV2' // Adjust the kind as needed for your use case

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: sku
  }
  kind: kind
  properties: {
    accessTier: 'Hot' // Adjust according to your access pattern; options are 'Hot' and 'Cool'
  }
}
