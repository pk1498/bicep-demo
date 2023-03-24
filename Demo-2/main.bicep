
@description('Provide storage account name')
param storageAccName string

@description('Provide storage account sku name')
param storageSkuName string

@description('Provide storage account kind')
param storageKind string


//Deploy Storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccName
  location: 'eastus'
  sku: {
    name: storageSkuName
  }
  kind: storageKind
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess:false
  }
}
