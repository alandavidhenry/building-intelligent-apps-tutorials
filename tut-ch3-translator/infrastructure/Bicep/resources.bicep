param location string
param tags object
param names object

module translator 'modules/translator.bicep' = {
  name: 'translatorDeployment'
  params: {
    name: names.translator
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

module functionInfra 'modules/function-infrastructure.bicep' = {
  name: 'functionInfraDeployment'
  params: {
    names: {
      appServicePlan: names.appServicePlan
      functionApp: names.functionApp
    }
    location: location
    tags: tags
    storageAccountName: storage.outputs.name
    appInsightsConnectionString: monitoring.outputs.appInsightsConnectionString
    translatorName: translator.outputs.name
  }
  dependsOn: [
    translator
  ]
}
