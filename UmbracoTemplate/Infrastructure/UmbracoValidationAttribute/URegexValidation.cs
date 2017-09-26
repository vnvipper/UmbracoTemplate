using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{
    public class URegularExpression : RegularExpressionAttribute, IClientValidatable
    {
        private readonly string _errorMessageDictionaryKey;


        public URegularExpression(string errorMessageDictionaryKey,string pattern): base(pattern)
        {
            _errorMessageDictionaryKey = errorMessageDictionaryKey;
        }


        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            ErrorMessage = Helpers.GetDictionaryItem(_errorMessageDictionaryKey);

            var error           = FormatErrorMessage(metadata.DisplayName);
            var rule            = new ModelClientValidationRule();
            rule.ErrorMessage   = error;
            rule.ValidationType = "regex";

            rule.ValidationParameters.Add("pattern", this.Pattern);

            yield return rule;
        }
    }
}