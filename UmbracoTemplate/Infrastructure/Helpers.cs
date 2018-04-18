using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Ninject.Activation;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;
using UmbracoTemplate.Models.Entities;
using UmbracoTemplate.Services.Abstracts;

namespace UmbracoTemplate.Infrastructure
{
    public static class Helpers
    {
        public static UmbracoHelper UmbracoHelper { get; set; }
        static Helpers()
        {
            //Ensure we have a context
            if (UmbracoContext.Current == null)
            {
                throw new Exception("We have no Umbraco context, are you sure you are running this in Umbraco?");
            }

            //Setup Umbraco Helper for our inheriting classes to use as needed
            UmbracoHelper = new UmbracoHelper(UmbracoContext.Current);
        }
        public static IHtmlString UrlFor<T>(this HtmlHelper helper, string innerText, object htmlAttributes = null, Func<T, bool> filter = null) where T: PublishedContentModel
        {
            var page = GetPage(filter);
            if (page != null)
            {
                TagBuilder a = new TagBuilder("a");
                a.Attributes.Add("href", page.Url);
                a.InnerHtml = innerText;
                a.MergeAttributes(new RouteValueDictionary(htmlAttributes));

                return MvcHtmlString.Create(a.ToString());
            }
            return MvcHtmlString.Create("");
        }

        public static IHtmlString UrlFor<T>(this HtmlHelper helper, object htmlAttributes = null, Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var page = GetPage(filter);
            if (page != null)
            {
                TagBuilder a = new TagBuilder("a");
                a.Attributes.Add("href", page.Url);
                a.InnerHtml = page.Name;
                a.MergeAttributes(new RouteValueDictionary(htmlAttributes));
                return MvcHtmlString.Create(a.ToString());
            }
            return MvcHtmlString.Create("");
        }

        public static IHtmlString MultiSiteUrlFor<T>(this HtmlHelper helper, string innerText, object htmlAttributes = null, Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var page = GetPageByCurrentCulture(filter);
            if (page != null)
            {
                TagBuilder a = new TagBuilder("a");
                a.Attributes.Add("href", page.Url);
                a.InnerHtml = innerText;
                a.MergeAttributes(new RouteValueDictionary(htmlAttributes));
                return MvcHtmlString.Create(a.ToString());
            }
            return MvcHtmlString.Create("");
        }

        public static IHtmlString MultiSiteUrlFor<T>(this HtmlHelper helper, object htmlAttributes = null, Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var page = GetPageByCurrentCulture(filter);
            if (page != null)
            {
                TagBuilder a = new TagBuilder("a");
                a.Attributes.Add("href", page.Url);
                a.InnerHtml = page.Name;
                a.MergeAttributes(new RouteValueDictionary(htmlAttributes));
                return MvcHtmlString.Create(a.ToString());
            }
            return MvcHtmlString.Create("");
        }

        public static IEnumerable<T> GetPages<T>(Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var dataService = DependencyResolver.Current.GetService<IDataService<T>>();
            return dataService.GetAll(filter);
        }

        public static T GetPage<T>(Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var dataService = DependencyResolver.Current.GetService<IDataService<T>>();
            return dataService.Get(filter);
        }

        public static IEnumerable<T> GetPagesByCurrentCulture<T>(Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var dataService = DependencyResolver.Current.GetService<IDataService<T>>();
            return dataService.GetAllByCurrentCulture(filter);
        }

        public static T GetPageByCurrentCulture<T>(Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var dataService = DependencyResolver.Current.GetService<IDataService<T>>();
            return dataService.GetByCurrentCulture(filter);
        }

        public static string GetDictionaryItem(string errorMessageDictionaryKey)
        {
            //Get dictionary value for thge required error message
            var error = UmbracoHelper.GetDictionaryValue(errorMessageDictionaryKey);

            //Sanity checking it's not empty
            if (string.IsNullOrEmpty(error))
            {
                throw new Exception(
                    $"The dictionary key '{errorMessageDictionaryKey}' for the required error message is empty or does not exist");
            }
            return error;
        }

        public static string FormatErrorMessage(string name, string errorMessageDictionaryKey)
        {
            //Get dictionary value for thge required error message
            var error = UmbracoHelper.GetDictionaryValue(errorMessageDictionaryKey);

            //Sanity checking it's not empty
            if (string.IsNullOrEmpty(error))
            {
                throw new Exception(
                    $"The dictionary key '{errorMessageDictionaryKey}' for the required error message is empty or does not exist");
            }

            // String replacment the token wiht our localised propertyname
            // The {{Field}} field is required
            error = error.Replace("{0}", name);

            //Return the value
            return error;
        }

        public static bool IsValidRecaptcha(string recaptcha)
        {
            if (string.IsNullOrEmpty(recaptcha))
            {
                return false;
            }
            var secretKey = GetPage<Models.Settings>().RecaptchaSecretKey;
            string remoteIp = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            string myParameters = $"secret={secretKey}&response={recaptcha}&remoteip={remoteIp}";
            using (var wc = new WebClient())
            {
                wc.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";
                var json = wc.UploadString("https://www.google.com/recaptcha/api/siteverify", myParameters);
                var js = new DataContractJsonSerializer(typeof(RecaptchaResult));
                var ms = new MemoryStream(Encoding.ASCII.GetBytes(json));
                var captchaResult = js.ReadObject(ms) as RecaptchaResult;
                if (captchaResult != null && captchaResult.Success)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }


        /// <summary>
        /// make nice string
        /// </summary>
        /// <param name="source"></param>
        /// <returns></returns>
        public static string ToNiceString(this string source)
        {
            if (string.IsNullOrEmpty(source)) return string.Empty;
            source = Regex.Replace(source, @"[^a-zA-Z0-9\s-,]", "");
            return !string.IsNullOrEmpty(source) ? source.ToLower().Replace(" ", "-").Replace("--", "-") : string.Empty;
        }

        public static string ToCultureDateString(this DateTime source)
        {
            return source.ToString(GetDictionaryItem(DictionaryConstants.DATETIMEFORMAT));
        }

        public static string ToCultureLongDateString(this DateTime source)
        {
            return source.ToString(GetDictionaryItem(DictionaryConstants.LONGDATEFORMAT));
        }
    }
}