using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Microsoft.AspNet.Identity;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;
using UmbracoIdentity;
using UmbracoTemplate.Models.UmbracoIdentity;
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
            var page = GetPage<T>(filter);
            TagBuilder a = new TagBuilder("a");
            a.Attributes.Add("href", page.Url);
            a.InnerHtml = innerText;
            a.MergeAttributes(new RouteValueDictionary(htmlAttributes));

            return MvcHtmlString.Create(a.ToString());
        }

        public static IHtmlString UrlFor<T>(this HtmlHelper helper, object htmlAttributes = null, Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var page = GetPage<T>(filter);
            TagBuilder a = new TagBuilder("a");
            a.Attributes.Add("href", page.Url);
            a.InnerHtml = page.Name;
            a.MergeAttributes(new RouteValueDictionary(htmlAttributes));

            return MvcHtmlString.Create(a.ToString());
        }

        public static IHtmlString MultiSiteUrlFor<T>(this HtmlHelper helper, string innerText, object htmlAttributes = null, Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var page = GetPageByCurrentCulture<T>(filter);
            TagBuilder a = new TagBuilder("a");
            a.Attributes.Add("href", page.Url);
            a.InnerHtml = innerText;
            a.MergeAttributes(new RouteValueDictionary(htmlAttributes));

            return MvcHtmlString.Create(a.ToString());
        }

        public static IHtmlString MultiSiteUrlFor<T>(this HtmlHelper helper, object htmlAttributes = null, Func<T, bool> filter = null) where T : PublishedContentModel
        {
            var page = GetPageByCurrentCulture<T>(filter);
            TagBuilder a = new TagBuilder("a");
            a.Attributes.Add("href", page.Url);
            a.InnerHtml = page.Name;
            a.MergeAttributes(new RouteValueDictionary(htmlAttributes));

            return MvcHtmlString.Create(a.ToString());
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
                throw new Exception(string.Format("The dictionary key '{0}' for the required error message is empty or does not exist", errorMessageDictionaryKey));
            }

            // String replacment the token wiht our localised propertyname
            // The {{Field}} field is required
            error = error.Replace("{{Field}}", name);

            //Return the value
            return error;
        }
    }
}