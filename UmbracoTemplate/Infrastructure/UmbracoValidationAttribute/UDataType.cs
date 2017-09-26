using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false)]
    public class UDataType : DataTypeAttribute, IClientValidatable
    {
        private readonly string _errorMessageDictionaryKey;


        public UDataType(DataType type, string errorMessageDictionaryKey = null)
            : base(type)
        {
            _errorMessageDictionaryKey = errorMessageDictionaryKey??"DataType Message";
        }


        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(System.Web.Mvc.ModelMetadata metadata, ControllerContext context)
        {
            ErrorMessage = Helpers.GetDictionaryItem(_errorMessageDictionaryKey);

            // Kodus to "Chad" http://stackoverflow.com/a/9914117
            yield return new ModelClientValidationRule
            {
                ErrorMessage = FormatErrorMessage(metadata.DisplayName),
                ValidationType = this.DataType.ToString().ToLower()
            };
        }
    }
}