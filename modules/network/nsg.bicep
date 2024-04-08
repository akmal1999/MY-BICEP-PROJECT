// Module to create a Network Security Group with basic rules
param location string

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: 'dev-webAppNSG'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowSSH'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
        }
      }
    ]
  }
}
