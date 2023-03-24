//Deploy Storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'bicepdemosa001'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess:false
  }
}


