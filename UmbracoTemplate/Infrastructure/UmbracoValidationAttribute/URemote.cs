using System.Collections.Generic;
using System.Web.Mvc;

namespace UmbracoTemplate.Infrastructure.UmbracoValidationAttribute
{

    public class URemote : RemoteAttribute, IClientValidatable
    {
        /// <summary>
        /// 
        /// </summary>
        public string ErrorMessageDictionaryKey { get; set; }

        /// <inheritdoc />
        /// <summary>
        /// </summary>
        public URemote()
        {
        }

        /// <inheritdoc />
        /// <summary>
        /// </summary>
        /// <param name="routeName"></param>
        public URemote(string routeName): base(routeName)
        {
        }

        /// <inheritdoc />
        /// <summary>
        /// </summary>
        /// <param name="action"></param>
        /// <param name="controller"></param>
        public URemote(string action, string controller):base(action, controller)
        {
        }

        /// <inheritdoc />
        /// <summary>
        /// </summary>
        /// <param name="action"></param>
        /// <param name="controller"></param>
        /// <param name="areaName"></param>
        public URemote(string action, string controller, string areaName): base(action, controller, areaName)
        {
        }

        /// <inheritdoc />
        /// <summary>
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public override string FormatErrorMessage(string name)
        {
            //Get dictionary value for thge required error message
            //WB: UNSURE if this will double check our UmbContext exists or not
            ErrorMessage = Helpers.FormatErrorMessage(name, ErrorMessageDictionaryKey);

            return base.FormatErrorMessage(name);
        }

        /// <inheritdoc />
        /// <summary>
        /// </summary>
        /// <param name="metadata"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public new IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            var error   = FormatErrorMessage(metadata.DisplayName);
            var rule    = new ModelClientValidationRemoteRule(error, GetUrl(context), HttpMethod, FormatAdditionalFieldsForClientValidation(metadata.PropertyName));

            yield return rule;
        }
    
    
    }
}