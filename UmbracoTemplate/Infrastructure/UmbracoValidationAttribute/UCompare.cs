using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CompareAttribute = System.ComponentModel.DataAnnotations.CompareAttribute;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{
    public class UCompare : CompareAttribute, IClientValidatable
    {
        private readonly string _otherProperty;
        private readonly string _errorMessageDictionaryKey;


        public UCompare(string otherProperty, string errorMessageDictionaryKey = null )
            : base(otherProperty)
        {
            _otherProperty = otherProperty;
            _errorMessageDictionaryKey = errorMessageDictionaryKey??"Compare Message";
        }


        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            ErrorMessage = Helpers.GetDictionaryItem(_errorMessageDictionaryKey);

            var error = FormatErrorMessage(metadata.DisplayName);
            var rule = new ModelClientValidationEqualToRule(error, _otherProperty);

            yield return rule;
        }
    }
}