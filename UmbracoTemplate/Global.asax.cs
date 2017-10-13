using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Archetype.Models;
using AutoMapper;
using Umbraco.Core.Models;
using Umbraco.Web;
using UmbracoTemplate.App_Start;
using UmbracoTemplate.Models.Entities;

namespace UmbracoTemplate
{
    public partial class Global : UmbracoApplication
    {
        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            base.OnApplicationStarted(sender, e);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            // Custom mapper and interesting thing here
            MapperConfiguration.Setup();
        }
    }
}