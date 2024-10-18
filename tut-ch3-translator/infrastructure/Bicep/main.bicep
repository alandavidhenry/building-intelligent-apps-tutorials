// Create a subscription-level deployment
targetScope = 'subscription'

// Import parameters
@description('Path to the parameters file')
#disable-next-line no-unused-params
param parameterFile string = 'parameters.bicep'

// Reference parameters
param projectName string
param storageAccountPrefix string
param location string
param tags object

// Create unique suffix
param deploymentId string = utcNow()
var uniqueSuffix = uniqueString(subscription().id, deploymentId)

// Name resources
var resourceGroupName = 'rg-${projectName}'
var translatorName = 'trsl-${projectName}-${uniqueSuffix}'
var logAnalyticsName ='log-${projectName}-${uniqueSuffix}'
var appInsightsName = 'appi-${projectName}-${uniqueSuffix}'
var storageAccountName = '${storageAccountPrefix}st${uniqueSuffix}'
var appServicePlanName = 'asp-${projectName}-${uniqueSuffix}'
var functionAppName = 'func-${projectName}-${uniqueSuffix}'

// Create resource group
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Import resources and pass through parameters
module resources 'resources.bicep' = {
  name: 'resourcesDeployment'
  scope: rg
  params: {
    location: location
    tags: tags
    translatorName: translatorName
    logAnalyticsName: logAnalyticsName
    appInsightsName: appInsightsName
    storageAccountName: storageAccountName
    appServicePlanName: appServicePlanName
    functionAppName: functionAppName
  }
}
