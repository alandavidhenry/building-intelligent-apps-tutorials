// Create a subscription-level deployment
targetScope = 'subscription'

// Import parameters
@description('Path to the parameters file')
#disable-next-line no-unused-params
param parameterFile string = 'parameters.bicep'

// Reference parameters
param projectName string
param location string
param tags object

// Create unique suffix
param deploymentId string = utcNow()
var uniqueSuffix = uniqueString(subscription().id, deploymentId)

// Name resources
var resourceGroupName = 'rg-${projectName}'
var speechName = 'trsl-${projectName}-${uniqueSuffix}'

// Create resource group
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Import speech module
module speech 'modules/speech.bicep' = {
  name: 'speechDeployment'
  scope: rg
  params: {
    translatorName: speechName
    location: location
    tags: tags
  }
}
