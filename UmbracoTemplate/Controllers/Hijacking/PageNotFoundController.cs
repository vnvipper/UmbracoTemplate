using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Models;
using UmbracoTemplate.Models.UmbracoIdentity;

namespace UmbracoTemplate.Controllers.Hijacking
{
    public class PageNotFoundController : RenderMvcController
    {
        public ActionResult Index()
        {
            PageNotFound model = new PageNotFound(CurrentPage);
            return CurrentTemplate(model);
        }
    }
}