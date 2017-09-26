using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{
    public class UStringLength : StringLengthAttribute, IClientValidatable
    {
        private readonly string _errorMessageDictionaryKey;


        public UStringLength(int maximumLength, string errorMessageDictionaryKey = null) : base(maximumLength)
        {
            _errorMessageDictionaryKey = errorMessageDictionaryKey ?? "String Length Message";
        }


        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            ErrorMessage = Helpers.GetDictionaryItem(_errorMessageDictionaryKey);

            var error   = FormatErrorMessage(metadata.DisplayName);
            var rule    = new ModelClientValidationStringLengthRule(error, MinimumLength, MaximumLength);

            yield return rule;
        }
    }
}
