// Reference parameters
param location string
param tags object
param translatorName string
param logAnalyticsName string
param appInsightsName string
param storageAccountName string
param appServicePlanName string
param functionAppName string

module translator 'modules/translator.bicep' = {
  name: 'translatorDeployment'
  params: {
    translatorName: translatorName
    location: location
    tags: tags
  }
}

module appInsights 'modules/appInsights.bicep' = {
  name: 'appInsightsDeployment'
  params: {
    logAnalyticsName: logAnalyticsName
    appInsightsName: appInsightsName
    location: location
    tags: tags
  }
}

module storageAccount 'modules/storageAccount.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    storageAccountName: storageAccountName
    location: location
    tags: tags
  }
}

module appServicePlan 'modules/appServicePlan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    appServicePlanName: appServicePlanName
    location: location
    tags: tags
  }
}

module functionApp 'modules/functionApp.bicep' = {
  name: 'functionAppDeployment'
  params: {
    functionAppName: functionAppName
    location: location
    tags: tags
    appServicePlanId: appServicePlan.outputs.id
    storageAccountName: storageAccount.outputs.name
    appInsightsConnectionString: appInsights.outputs.connectionString
  }
}
