using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Models.UmbracoIdentity;

namespace UmbracoTemplate.Controllers.Hijacking
{
    public class LoginController : RenderMvcController
    {
        public ActionResult Index(string returnUrl)
        {
            LoginViewModel model = new LoginViewModel();
            ViewBag.ReturnUrl = returnUrl;
            return CurrentTemplate(model);
        }
    }
}