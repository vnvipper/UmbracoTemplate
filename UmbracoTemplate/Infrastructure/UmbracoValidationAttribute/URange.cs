using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{

    public class URange : RangeAttribute, IClientValidatable
    {
        /// <summary>
        /// 
        /// </summary>
        public string ErrorMessageDictionaryKey { get; set; } = "Range Message";

        public URange(Type type, string minimum, string maximum)
            : base(type, minimum, maximum)
        {

        }

        public URange(double minimum, double maximum): base(minimum, maximum)
        {

        }

        public URange(int minimum, int maximum)
            : base(minimum, maximum)
        {
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            ErrorMessage = Helpers.GetDictionaryItem(ErrorMessageDictionaryKey);

            var error   = FormatErrorMessage(metadata.DisplayName);
            var rule    = new ModelClientValidationRangeRule(error, Minimum, Maximum);

            yield return rule;
        }
    }
}
