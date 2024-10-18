using System.Net;
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
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _translatorBusiness = translatorBusiness ?? throw new ArgumentNullException(nameof(translatorBusiness));
        }

        [Function("Translator")]
        public async Task<HttpResponseData> RunAsync([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequestData req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            try
            {
                string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
                if (string.IsNullOrEmpty(requestBody))
                {
                    return await CreateErrorResponse(req, HttpStatusCode.BadRequest, "Request body is empty.");
                }

                var payload = JsonConvert.DeserializeObject<Payload>(requestBody);
                if (payload == null || string.IsNullOrEmpty(payload.Message) || string.IsNullOrEmpty(payload.TargetLanguage))
                {
                    return await CreateErrorResponse(req, HttpStatusCode.BadRequest, "Invalid payload. Both Message and TargetLanguage are required.");
                }

                var result = await _translatorBusiness.TranslateMessageAsync(payload.Message, payload.TargetLanguage);

                _logger.LogInformation($"Translation: {result}");

                var response = req.CreateResponse(HttpStatusCode.OK);
                await response.WriteStringAsync(result);
                return response;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred during translation.");
                return await CreateErrorResponse(req, HttpStatusCode.InternalServerError, "An error occurred during translation.");
            }
        }

        private async Task<HttpResponseData> CreateErrorResponse(HttpRequestData req, HttpStatusCode statusCode, string message)
        {
            var response = req.CreateResponse(statusCode);
            await response.WriteStringAsync(message);
            return response;
        }
    }
}