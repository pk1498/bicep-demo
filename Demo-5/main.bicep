
// Parameters
@description('Provide subscription name')
param subscriptionName string

@description('Provide environment name')
param envName string

param location string = resourceGroup().location

// Variables
var storageAccName = '${subscriptionName}${envName}sa05'
var storageContainerName = '${subscriptionName}${envName}bicepdemosacontainer'
var storageSkuName = 'Standard_LRS'
var storageKind = 'StorageV2'

var webAppPlanName = '${subscriptionName}-${envName}-webappplan'
var webAppName = '${subscriptionName}-${envName}-webappp'
var webAppSkuTier = envName == 'dev' ? 'Basic' : 'Standard'
var webAppSkuName = envName == 'dev' ? 'B1' : 'S1'
var webAppSkuFamily = envName == 'dev' ? 'B' : 'S'

// Storage Module
module storageAccountModule './modules/storage.bicep' = {
  name: 'storageDeploy'
  params: {
    storageAccName: storageAccName
    storageContainerName: storageContainerName
    storageSkuName: storageSkuName
    storageKind: storageKind
  }
}

// App Service Module
module appServiceModule './modules/appservice.bicep' = {
  name: 'webAppDeploy'
  params: {
    webAppPlanName: webAppPlanName
    webAppName: webAppName
    webAppSkuTier: webAppSkuTier
    webAppSkuName: webAppSkuName
    webAppSkuFamily: webAppSkuFamily
    storageAccResourceId : storageAccountModule.outputs.storageAccResourceId
    location: location
  }
  dependsOn:[
    storageAccountModule
  ]
}



