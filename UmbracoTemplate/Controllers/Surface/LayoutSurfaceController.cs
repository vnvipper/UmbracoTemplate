using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Core.Models;
using Umbraco.Web;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Models;
using UmbracoTemplate.Models.ViewModels;
using UmbracoTemplate.Services.Abstracts;
using UmbracoTemplate.Services.Implements;
using Script = UmbracoTemplate.Models.ViewModels.Script;

namespace UmbracoTemplate.Controllers.Surface
{
    public class LayoutSurfaceController : SurfaceController
    {
        private readonly IDataService<Settings> _settingsDataService;
        private readonly IDataService<Home> _homeDataService;

        public LayoutSurfaceController(IDataService<Settings> settingsDataService, IDataService<Home> homeDataService)
        {
            _settingsDataService = settingsDataService;
            _homeDataService = homeDataService;
        }

        public ActionResult RenderHead()
        {
            Settings setting = _settingsDataService.Get();
            NavigationControls navigation = new NavigationControls(CurrentPage);

            MetaData model = new MetaData
            {
                BrowserTitle = $"{(string.IsNullOrEmpty(navigation.BrowserTitle) ? CurrentPage.Name : navigation.Name)} - {setting?.SiteName}",
                Description = navigation.SeoMetaDescription,
                Keywords = navigation.Keywords == null ? "" : string.Join(", ", navigation.Keywords),
                ImageUrl = AbsoluteUrl(navigation.SocialImageSharing?.Url) ?? AbsoluteUrl(setting?.SiteLogo?.Url),
                PageUrl = AbsoluteUrl(navigation.Url),
                Title = navigation.Name,
                SiteName = setting?.SiteName
            };
            return PartialView("~/Views/Partials/Layout/_MetaData.cshtml", model);
        }
        public ActionResult RenderNavigation()
        {
            Home homePage = _homeDataService.GetByCurrentCulture();
            Settings settingsPage = _settingsDataService.Get();

            Navigation model = new Navigation
            {
                Home = new Link(homePage.Name, homePage.Url),
                Setting = new Link(settingsPage.SiteName, settingsPage.Url),
                NavigationListItems = GetNavigationModelFromDatabase()
            };


            return PartialView("~/Views/Partials/Layout/_Navigation.cshtml", model);
        }
        public ActionResult RenderScript()
        {
            Script model = new Script
            {
                GoogleAnalyticsId = _settingsDataService.Get().GoogleAnalyticsId
            };
            return PartialView("~/Views/Partials/Layout/_Scripts.cshtml", model);
        }
        #region Helpers
        private string AbsoluteUrl(string url)
        {
            string absoluteUrl = url;
            if (!string.IsNullOrEmpty(url))
            {
                absoluteUrl = Request.Url.Scheme + System.Uri.SchemeDelimiter + Request.Url.Host + (Request.Url.IsDefaultPort ? "" : ":" + Request.Url.Port) + url;
            }
            return absoluteUrl;
        }

        /// <summary>
        /// Finds the home page and gets the navigation structure based on it and it's children
        /// </summary>
        /// <returns>A List of NavigationListItems, representing the structure of the site.</returns>
        private List<NavigationListItem> GetNavigationModelFromDatabase()
        {
            //const int HOME_PAGE_POSITION_IN_PATH = 1;
            //int homePageId = int.Parse(CurrentPage.Path.Split(',')[HOME_PAGE_POSITION_IN_PATH]);
            //IPublishedContent homePage = Umbraco.Content(homePageId);
            IPublishedContent homePage = _homeDataService.GetByCurrentCulture();
            List<NavigationListItem> nav = new List<NavigationListItem>();
            nav.AddRange(GetChildNavigationList(homePage));
            return nav;
        }

        /// <summary>
        /// Loops through the child pages of a given page and their children to get the structure of the site.
        /// </summary>
        /// <param name="page">The parent page which you want the child structure for</param>
        /// <returns>A List of NavigationListItems, representing the structure of the pages below a page.</returns>
        private List<NavigationListItem> GetChildNavigationList(IPublishedContent page)
        {
            List<NavigationListItem> listItems = null;
            var childPages = page.Children.Where(x=>x.IsVisible()).Where(x => x.Level <= 3).Where(x => !x.HasValue("excludeFromTopNavigation") || (x.HasValue("excludeFromTopNavigation") && !x.GetPropertyValue<bool>("excludeFromTopNavigation")));
            if (childPages != null && childPages.Any() && childPages.Count() > 0)
            {
                listItems = new List<NavigationListItem>();
                foreach (var childPage in childPages)
                {
                    NavigationListItem listItem = new NavigationListItem(new Link(childPage.Name, childPage.Url));
                    listItem.Items = GetChildNavigationList(childPage);
                    listItems.Add(listItem);
                }
            }
            return listItems;
        }
        #endregion
    }
}