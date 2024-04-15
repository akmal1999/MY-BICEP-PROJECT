// Required parameters for the VM Bicep module

param location string // Azure region where the VM will be deployed
param vmName string // Name of the virtual machine
param adminUsername string // Administrator username for the VM
param vmSize string = 'Standard_DS1_v2' // Size of the VM, with a default value if not specified
param networkInterfaceId string // ID of the network interface to attach to the VM
param keyVaultName string // Name of the Key Vault to retrieve secrets
param adminPasswordSecretName string // Name of the secret within the Key Vault that contains the VM's admin password

// Reference to the Key Vault to get the secret URI dynamically
resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: keyVaultName
}

var adminPasswordSecretUri = 'https://${keyVault.name}.vault.azure.net/secrets/${adminPasswordSecretName}'

// Virtual Machine
resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: '@Microsoft.KeyVault(SecretUri=${adminPasswordSecretUri})'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaceId
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}
