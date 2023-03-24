
// Parameters
@description('Provide subscription name')
param subscriptionName string

@description('Provide environment name')
param envName string

// Variables
var storageAccName = '${subscriptionName}${envName}bicepdemosa003'
var storageContainerName = '${storageAccName}-container1'
var storageSkuName = 'Standard_LRS'
var storageKind = 'StorageV2'

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
