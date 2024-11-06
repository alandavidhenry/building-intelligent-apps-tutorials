param location string
param tags object
param names object


module textAnalytics 'modules/textAnalytics.bicep' = {
  name: 'textAnalyticsDeployment'
  params: {
    name: names.textAnalytics
    location: location
    tags: tags
  }
}

module monitoring 'modules/monitoring.bicep' = {
  name: 'monitoringDeployment'
  params: {
    names: {
      logAnalytics: names.logAnalytics
      appInsights: names.appInsights
    }
    location: location
    tags: tags
  }
}

module storage 'modules/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    name: names.storageAccount
    location: location
    tags: tags
  }
}

module functionInfra 'modules/functionApp.bicep' = {
  name: 'functionInfraDeployment'
  params: {
    names: {
      appServicePlan: names.appServicePlan
      functionApp: names.functionApp
    }
    location: location
    tags: tags
    storageAccountName: names.storageAccount
    appInsightsConnectionString: monitoring.outputs.appInsightsConnectionString
    textAnalyticsName: textAnalytics.outputs.name
  }
  dependsOn: [
    storage
    monitoring
    textAnalytics
  ]
}
