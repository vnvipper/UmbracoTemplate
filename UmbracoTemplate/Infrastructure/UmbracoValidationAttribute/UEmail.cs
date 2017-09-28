using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;
using System.Web.Mvc;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{
    public class UEmail : ValidationAttribute, IClientValidatable
    {
        //Taken from default .NET [EmailAddress] attribute
        private static Regex _regex = new Regex(@"^(?("")("".+?(?<!\\)""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" +
                                                @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-\w]*[0-9a-z]*\.)+[a-z0-9][\-a-z0-9]{0,22}[a-z0-9]))$", 
            RegexOptions.IgnoreCase | RegexOptions.ExplicitCapture | RegexOptions.Compiled);

        private readonly string _errorMessageDictionaryKey;
        public UEmail()
        {
            _errorMessageDictionaryKey = "EmailValidationMessage";
        }

        public UEmail(string errorMessageDictionaryKey)
        {
            _errorMessageDictionaryKey = errorMessageDictionaryKey;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var email = Convert.ToString(value);
            if (!string.IsNullOrEmpty(email))
            {
                //Test the regex
                var result = _regex.Match(email).Length > 0;

                //If no matches then email NOT valid
                if (!result)
                {
                    //Get the error message to return
                    var error = Helpers.FormatErrorMessage(validationContext.DisplayName, _errorMessageDictionaryKey);

                    //Return error
                    return new ValidationResult(error);
                }
            }

            //All good :)
            return ValidationResult.Success;
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            ErrorMessage = Helpers.GetDictionaryItem(_errorMessageDictionaryKey);
            var error   = FormatErrorMessage(metadata.DisplayName);
            var rule    = new ModelClientValidationRule
            {
                ErrorMessage    = error,
                ValidationType  = "email"
            };

            yield return rule;

        }
    }
}
