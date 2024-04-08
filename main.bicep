param location string = 'eastus'
param projectPrefix string = 'dev-webApp'

// Azure Key Vault parameters
param keyVaultName string = '${projectPrefix}-kv'
param adminPasswordSecretName string = 'vmAdminPassword'

// Resource Group
var resourceGroupName = '${projectPrefix}-rg'
module resourceGroup 'modules/core/resourceGroup.bicep' = {
  name: '${projectPrefix}-rg-deployment'
  params: {
    name: resourceGroupName
    location: location
  }
}

// Virtual Network
var vnetName = '${projectPrefix}-vnet'
module network 'modules/network/vnet.bicep' = {
  name: '${projectPrefix}-vnet-deployment'
  params: {
    vnetName: vnetName
    location: location
  }
  dependsOn: [
    resourceGroup
  ]
}

// Network Security Group
var nsgName = '${projectPrefix}-nsg'
module nsg 'modules/network/nsg.bicep' = {
  name: '${projectPrefix}-nsg-deployment'
  params: {
    nsgName: nsgName
    location: location
  }
  dependsOn: [
    resourceGroup
  ]
}

// Virtual Machine
var vmName = '${projectPrefix}-vm'
module vm 'modules/compute/vm.bicep' = {
  name: '${projectPrefix}-vm-deployment'
  params: {
    vmName: vmName
    adminUsername: 'adminUser'
    vmSize: 'Standard_DS1_v2'
    location: location
    keyVaultName: keyVaultName
    adminPasswordSecretName: adminPasswordSecretName
    networkInterfaceId: network.outputs.networkInterfaceId // Assuming this output from the network module
  }
  dependsOn: [
    network,
    nsg
  ]
}

// SQL Database
var sqlServerName = '${projectPrefix}-sql'
module sqlDatabase 'modules/data/sqlDatabase.bicep' = {
  name: '${projectPrefix}-sql-deployment'
  params: {
    sqlServerName: sqlServerName
    location: location
  }
  dependsOn: [
    resourceGroup
  ]
}

// Storage Account
var storageAccountName = '${projectPrefix}storage'
module storageAccount 'modules/data/storageAccount.bicep' = {
  name: '${projectPrefix}-storage-deployment'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
  dependsOn: [
    resourceGroup
  ]
}
