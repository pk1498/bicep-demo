
// Parameters
@description('Provide subscription name')
param subscriptionName string

@description('Provide environment name')
param envName string

@description('Define whether to deploy app service or not')
param webAppDeploy bool


param location string = resourceGroup().location

// Variables
var storageAccName = '${subscriptionName}${envName}bicepdemosa005'
var webAppPlanName = '${subscriptionName}-${envName}-bicepdemo-webappplan'
var webAppName = '${subscriptionName}-${envName}-bicepdemo-webappp'
var webAppSkuTier = envName == 'dev' ? 'Basic' : 'Standard'
var webAppSkuName = envName == 'dev' ? 'B1' : 'S1'
var webAppSkuFamily = envName == 'dev' ? 'B' : 'S'

// Get existing Storage Module
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: storageAccName
  scope: resourceGroup('Bicep_Demo')
}

// App Service Module
module appServiceModule './modules/appservice.bicep' = if (webAppDeploy) {
  name: 'webAppDeploy'
  params: {
    webAppPlanName: webAppPlanName
    webAppName: webAppName
    webAppSkuTier: webAppSkuTier
    webAppSkuName: webAppSkuName
    webAppSkuFamily: webAppSkuFamily
    location: location
    storageAccResourceId : storageAccount.id  
  }
}



