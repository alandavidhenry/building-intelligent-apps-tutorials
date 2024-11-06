// Create a subscription-level deployment
targetScope = 'subscription'

@description('Path to the parameters file')
#disable-next-line no-unused-params
param parameterFile string

@description('Project name used for resource naming')
param projectName string

@description('Prefix for storage account name')
param storageAccountPrefix string

@description('Azure region for resource deployment')
param location string

@description('Tags to be applied to all resources')
param tags object

var uniqueSuffix = uniqueString(subscription().id, deployment().name)

var names = {
  resourceGroup: 'rg-${projectName}'
  textAnalytics: 'lang-${projectName}-${uniqueSuffix}'
  logAnalytics: 'log-${projectName}-${uniqueSuffix}'
  appInsights: 'appi-${projectName}-${uniqueSuffix}'
  storageAccount: 'st${storageAccountPrefix}${uniqueSuffix}'
  appServicePlan: 'asp-${projectName}-${uniqueSuffix}'
  functionApp: 'func-${projectName}-${uniqueSuffix}'
}

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: names.resourceGroup
  location: location
  tags: tags
}

module resources 'resources.bicep' = {
  name: 'resourcesDeployment'
  scope: rg
  params: {
    location: location
    tags: tags
    names: names
  }
}
