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
        public static IHtmlString UrlFor<T>(this HtmlHelper helper, string innerText, object htmlAttributes = null) where T: PublishedContentModel
        {
            var page = GetPage<T>();
            TagBuilder a = new TagBuilder("a");
            a.Attributes.Add("href", page.Url);
            a.InnerHtml = innerText;
            a.MergeAttributes(new RouteValueDictionary(htmlAttributes));

            return MvcHtmlString.Create(a.ToString());
        }

        public static IHtmlString UrlFor<T>(this HtmlHelper helper, object htmlAttributes = null) where T : PublishedContentModel
        {
            var page = GetPage<T>();
            TagBuilder a = new TagBuilder("a");
            a.Attributes.Add("href", page.Url);
            a.InnerHtml = page.Name;
            a.MergeAttributes(new RouteValueDictionary(htmlAttributes));

            return MvcHtmlString.Create(a.ToString());
        }

        public static IEnumerable<T> GetPages<T>() where T : PublishedContentModel
        {
            var dataService = DependencyResolver.Current.GetService<IDataService<T>>();
            return dataService.GetAll();
        }

        public static T GetPage<T>() where T : PublishedContentModel
        {
            var dataService = DependencyResolver.Current.GetService<IDataService<T>>();
            return dataService.Get();
        }

        public static bool SendEmailConfirm(this UmbracoMembersUserManager<UmbracoApplicationMember> userManager, int userId,
            string subject, string body)
        {
            var emailSender = DependencyResolver.Current.GetService<IEmailSender>();
            return emailSender.SendMail(userManager.FindById(userId).Email, subject, body);
        }
    }
}