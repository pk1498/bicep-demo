
// Parameters
@description('Provide subscription name')
param subscriptionName string

@description('Provide environment name')
param envName string

// Variables
var storageAccName = '${subscriptionName}${envName}sa04'
var storageContainerName = '${storageAccName}-container1'
var storageSkuName = 'Standard_LRS'
var storageKind = 'StorageV2'

// Storage Module
module storageAccountModule './modules/storage.bicep' = {
  name: 'storageDeploy'
  params: {
    storageAccName: storageAccName
    storageKind: storageKind
    storageContainerName: storageContainerName
    storageSkuName: storageSkuName
  }
}



