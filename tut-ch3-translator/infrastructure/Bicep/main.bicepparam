using 'main.bicep'

param projectName = 'tut-ch3-translator'
param storageAccountPrefix = 'tutch3'
param location = 'uksouth'
param tags = {
  project: 'Building Intelligent Apps with .NET and Azure AI Services'
  tutorial: 'chapter3'
  deployedViaIaC: 'yes'
  version: '1'
}
