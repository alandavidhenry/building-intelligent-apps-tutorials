using 'main.bicep'

param projectName = 'tut-ch2-doc-classifier'
param storageAccountPrefix = 'tutch2'
param location = 'uksouth'
param tags = {
  project: 'Building Intelligent Apps with .NET and Azure AI Services'
  tutorial: 'chapter2'
  deployedViaIaC: 'yes'
  version: '1'
}
param parameterFile = 'parameters.bicep'
