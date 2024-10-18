using System.Net;
using Azure.Core;
using Chapter3LanguageTranslator.Business;
using Chapter3LanguageTranslator.Model;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Chapter3LanguageTranslator
{
    public class Translator
    {
        private readonly ILogger<Translator> _logger;
        private readonly ITranslatorBusiness _translatorBusiness;
        public Translator(ILogger<Translator> logger, ITranslatorBusiness translatorBusiness)
        {
            _logger = logger;
            _translatorBusiness = translatorBusiness;
        }
        [Function("Translator")]
        public async Task<HttpResponseData> RunAsync([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequestData req)
        {
            try
            {
                string requestBody = await new StreamReader(req.Body).
                ReadToEndAsync();

                var payload = JsonConvert.DeserializeObject<Payload>(requestBody);

                _logger.LogInformation("C# HTTP trigger function processed a request.");

                var result = await _translatorBusiness.TranslateMessageAsync(payload.Message, payload.TargetLanguage);

                _logger.LogInformation($"Translation: {result}");

                var response = req.CreateResponse(HttpStatusCode.OK);

                await response.WriteStringAsync(result);

                return response;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"An error occurred - {ex.Message}");
                var response = req.CreateResponse(HttpStatusCode.BadRequest);
                await response.WriteStringAsync(ex.Message);
                return response;
            }
        }
    }
}