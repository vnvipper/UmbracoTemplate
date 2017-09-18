using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Microsoft.AspNet.Identity;
using Umbraco.Core.Models.PublishedContent;
using UmbracoIdentity;
using UmbracoTemplate.Models.UmbracoIdentity;
using UmbracoTemplate.Services.Abstracts;

namespace UmbracoTemplate.Infrastructure
{
    public static class Helpers
    {
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

        public static bool SendEmailConfirm(this UmbracoMembersUserManager<UmbracoApplicationMember> userManager, int userId,
            string subject, string body)
        {
            var emailSender = DependencyResolver.Current.GetService<IEmailSender>();
            return emailSender.SendMail(userManager.FindById(userId).Email, subject, body);
        }
    }
}