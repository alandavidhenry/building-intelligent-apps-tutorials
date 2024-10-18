public interface ITranslatorBusiness
{
    Task<string> TranslateMessageAsync(string message, string targetLanguage);
}