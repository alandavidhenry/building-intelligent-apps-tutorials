using Azure;
using Azure.AI.Translation.Text;
using Chapter3LanguageTranslator.Business;
using Microsoft.Extensions.Azure;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var host = new HostBuilder()
    .ConfigureFunctionsWebApplication()
    .ConfigureServices(services =>
    {
        services.AddAzureClients(builder =>
        {
            builder.AddTextTranslationClient(new AzureKeyCredential(Environment.GetEnvironmentVariable("TranslatorKey")),
                Environment.GetEnvironmentVariable("TranslatorRegion"));
        });
        services.AddSingleton<ITranslatorBusiness, TranslatorBusiness>();
    })
    .Build();
host.Run();
