
// Parameters
param storageAccName string
param storageKind string
param storageContainerName string
param storageSkuName string


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

// Blob services
resource blobservicesResource 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  name: 'default'
  parent: storageAccount
}

// Deploy container
resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: storageContainerName
  parent: blobservicesResource
}

output storageAccResourceId string = storageAccount.id
