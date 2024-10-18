param translatorName string
param location string
param tags object

resource translator 'Microsoft.CognitiveServices/accounts@2024-06-01-preview' = {
  name: translatorName
  location: location
  tags: tags
  sku: {
    name: 'F0'
  }
  kind: 'TextTranslation'
  identity: {
    type: 'None'
  }
  properties: {
    customSubDomainName: translatorName
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

