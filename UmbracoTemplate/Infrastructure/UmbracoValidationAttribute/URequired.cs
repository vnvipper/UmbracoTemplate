using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false)]
    public class URequired : RequiredAttribute, IClientValidatable
    {
        private readonly string _dictionaryKey;
        public URequired()
        {
            _dictionaryKey = "RequiredMessage";
        }

        public URequired(string dictionaryKey)
        {
            _dictionaryKey = dictionaryKey;
        }
        /// <inheritdoc />
        /// <summary>
        /// </summary>
        /// <param name="metadata"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            ErrorMessage = Helpers.GetDictionaryItem(_dictionaryKey);

            var error = FormatErrorMessage(metadata.DisplayName);
            var rule = new ModelClientValidationRequiredRule(error);

            yield return rule;
        }
    }
}