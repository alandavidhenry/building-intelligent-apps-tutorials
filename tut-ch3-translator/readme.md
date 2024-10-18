<div align="center">
  <h1 align="center">Chapter 3: Multi-language Text Translator</h1>
</div>

<!-- ABOUT THE PROJECT -->

## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->

Function App code and IaC from Ch.3 of the book: Building Intelligent Apps with .NET and Azure AI Services.

The project creates a multi-language text translator that used the Azure AI Translator resource that provides an endpoint that can be tested by sending a payload via Postman.

This project demonstrates the deployment of an Azure Function App using .NET, with the infrastructure defined using both Azure Bicep and Terraform. It serves as a reference for implementing Infrastructure as Code (IaC) in Azure environments and showcases serverless application development with Azure Functions.

### Built With

- [.NET](https://dotnet.microsoft.com/en-us/)
- [Azure](https://azure.microsoft.com/en-gb)
- [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Terraform](https://www.terraform.io/)
- [Pulumi](https://www.pulumi.com/)

#### Definitions

_.NET_: The development framework used for writing the Function App code.

_Microsoft Azure_: A cloud computing provider.

_Azure Function App_: A serverless compute service that allows you to run event-triggered code without managing infrastructure.

_Bicep_: A domain-specific language (DSL) for deploying Azure resources declaratively.

_Terraform_: An open-source IaC tool that supports multiple cloud providers, including Azure.

_Pulumi_: Pulumi is an infrastructure-as-code platform that can use a general-purpose programming language for their cloud resources(such as JavaScript or Python)

#### Project Structure

```
+---infrastructure
|   +---ARM
|   |       parameters.json
|   |       template.json
|   |
|   +---Bicep
|   |   |   main.bicep
|   |   |   main.bicepparam
|   |   |   resources.bicep
|   |   |
|   |   \---modules
|   |           appInsights.bicep
|   |           appServicePlan.bicep
|   |           cognitiveServices.bicep
|   |           functionApp.bicep
|   |           storageAccount.bicep
|   |
|   \---Terraform
\---src
    \---Chapter2DocumentClassifier
            .gitignore
            Chapter2DocumentClassifier.csproj
            Chapter2DocumentClassifier.csproj.user
            Chapter2DocumentClassifier.sln
            DocumentClassifier.cs
            host.json
            local.settings.json
            Program.cs

```

- The `ARM` directory contains the ARM files exported from Azure.
- The `Bicep` directory contains the Bicep IaC files.
  - Each resource is defined in a module.
  - The modules are referenced in the `resources.bicep` file.
  - The `resources.bicep` file is referenced in the `main.bicep` file.
  - The `main.bicepparam` file contains parameters.
- The `Terraform` directory contains the Terraform IaC files.
- The `src` directory contains Azure Function files. These can be deployed to Azure using the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) or the [Azure Extensions for VSCode](https://code.visualstudio.com/docs/azure/extensions). If you are using Visual Studio, then the Function can be deployed directly from there.

<!-- GETTING STARTED -->

## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

- Visual Studio or VSCode with the [Azure Extensions for VSCode](https://code.visualstudio.com/docs/azure/extensions)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Azure Functions Core Tools](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=windows%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-csharp)
- An Azure account and subscription

### Installation

Clone the repo

```sh
git clone https://github.com/alandavidhenry/building-intelligent-apps-tutorials.git
```

### Deployment using Bicep

There a several ways to deploy the Bicep IaC:

- Using the Bicep extension with VSCode. [Follow this guide](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-vscode).
- Using the Azure CLI. [Follow this guide](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-vscode).
- Using the PowerShell. [Follow this guide](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-powershell).
  
#### Deploying the Bicep IaC using the Azure CLI

1. Navigate to the 'tut-ch3-translator\infrastructure\Bicep' directory: `cd tut-ch3-translator\infrastructure\Bicep`
   
2. To test the deployment, set `<location>` to the required deployment location and use the `--what-if` parameter:

```powershell
az deployment sub create -l <location> -f main.bicep -p main.bicepparam --what-if 
```

3. To deploy to Azure, set `<location>` to the required deployment location and omit the `--what-if` parameter:

```powershell
az deployment sub create -l <location> -f main.bicep -p main.bicepparam
```

### Deployment using Terraform

Navigate to the 'infrastructure\Terraform' directory `cd infrastructure\Terraform`

In progress...

### Deployment using Pulumi

Navigate to the 'infrastructure\Pulumi' directory `cd infrastructure\Pulumi`

In progress...

### Deploying the function code to the function app

1. Navigate to the 'tut-ch3-translator\src\Chapter3LanguageTranslator\Chapter3LanguageTranslator' directory: `cd tut-ch3-translator\src\Chapter3LanguageTranslator`

2. Build the project:
   ```powershell
   clear
    ```

3. Deploy the function
   ```powershell
   func azure functionapp publish <function_app_name>
    ```

<!-- USAGE EXAMPLES -->

## Usage

1. Get the Function App URL from the Azure portal.
2. Paste the Function App URL followed by `/api/Translator` into Postman and set the request to POST. (e.g. `https://your-function-app.azurewebsites.net/api/Translator`)
3. In the 'Headers' tab, add (the app key can be found on the App Keys blade of the Function App):
   1. Key: `Content-Type`, Value: `application/json`
   2. Key: `x-functions-key`, Value: `your-app-key`
4. In the 'Body' tab, select 'raw' and choose 'JSON' from the dropdown.
5. Enter the following JSON for the request payload:
   ```json
    {
      "Message": "Hello, world!",
      "TargetLanguage": "French"
    }
    ```
6. Send the request and the response will be shown.

<!-- ROADMAP -->

## Roadmap

- [x] Add Bicep IaC
- [ ] Add Terraform IaC
- [ ] Add [Pulumi](https://www.pulumi.com) IaC
- [ ] Look into using [SST](https://sst.dev) IaC

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<!-- CONTACT -->

## Contact

Alan Henry - [LinkedIn](https://www.linkedin.com/in/alandavidhenry)

Project Link: [github.com/alandavidhenry/building-intelligent-apps-tutorials/tree/main/tut-ch3-translator](https://github.com/alandavidhenry/building-intelligent-apps-tutorials/tree/main/tut-ch3-translator)

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments

- [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
- [Building Intelligent Apps with .NET and Azure AI Services](https://link.springer.com/book/10.1007/979-8-8688-0435-9)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[product-screenshot]: images/screenshot.png
