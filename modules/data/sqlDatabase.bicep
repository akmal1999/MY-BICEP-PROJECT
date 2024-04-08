param sqlServerName string
param location string
param sqlDatabaseName string = 'myDatabase'
param administratorLogin string
param administratorLoginPassword string

// Create Azure SQL Server
resource sqlServer 'Microsoft.Sql/servers@2020-02-02-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    version: '12.0'
  }
}

// Create Azure SQL Database within the SQL Server
resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-02-02-preview' = {
  name: '${sqlServer.name}/${sqlDatabaseName}'
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: '2147483648' // Adjust as needed
    sku: {
      name: 'S0' // Adjust SKU based on your performance and pricing requirements
    }
    zoneRedundant: false // Adjust based on your availability and redundancy requirements
  }
  dependsOn: [
    sqlServer
  ]
}
