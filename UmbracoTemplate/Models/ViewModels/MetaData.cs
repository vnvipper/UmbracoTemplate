using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using Umbraco.Core.Models;
using Umbraco.Web.Models;

namespace UmbracoTemplate.Models.ViewModels
{
    public class MetaData
    {
        public string BrowserTitle { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Keywords { get; set; }
        public string ImageUrl { get; set; }
        public string  PageUrl { get; set; }
        public string SiteName { get; set; }
    }
}