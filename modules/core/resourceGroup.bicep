@description('The location for the resource group.')
param location string

@description('The name of the resource group.')
param resourceGroupName string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}
