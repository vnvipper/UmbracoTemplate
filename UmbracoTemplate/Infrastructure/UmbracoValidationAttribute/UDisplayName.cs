using System;
using System.ComponentModel;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{
    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false)]
    public sealed class UDisplayName : DisplayNameAttribute
    {
        private readonly string _dictionaryKey;

        // This is a positional argument
        public UDisplayName(string dictionaryKey)
        {
            _dictionaryKey = dictionaryKey;
        }

        public override string DisplayName
        {
            get
            {
                return Helpers.UmbracoHelper.GetDictionaryValue(_dictionaryKey);
            }
        }
    }
}
