param webAppPlanName string
param webAppName string
param webAppSkuTier string
param webAppSkuName string
param webAppSkuFamily string
param location string
param storageAccResourceId string

// Create WebApp plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: webAppPlanName
  location: location
  sku: {
    name: webAppSkuName
    tier: webAppSkuTier
    size: webAppSkuName
    family: webAppSkuFamily
    capacity: 1
  }
  kind: 'app'
  properties: {
    reserved: false
  }
}

// Create WebApp
resource appServiceResource 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  kind: 'app'
  properties: {
    enabled: true
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

// Create WebApp Settings
resource webAppConfigResource 'Microsoft.Web/sites/config@2022-03-01' = {
  name: 'appsettings'
  kind: 'app'
  parent: appServiceResource
  properties: {
    Stoage_Resource_ID: storageAccResourceId
  }
}
