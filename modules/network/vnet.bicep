param location string
param vnetName string
param vnetAddressPrefix string = '10.1.0.0/16'
param webSubnetPrefix string = '10.1.1.0/24'
param dbSubnetPrefix string = '10.1.2.0/24'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: 'webSubnet'
        properties: {
          addressPrefix: webSubnetPrefix
        }
      },
      {
        name: 'dbSubnet'
        properties: {
          addressPrefix: dbSubnetPrefix
        }
      }
    ]
  }
}
