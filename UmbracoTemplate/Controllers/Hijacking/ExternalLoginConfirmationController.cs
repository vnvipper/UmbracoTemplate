using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Models.UmbracoIdentity;

namespace UmbracoTemplate.Controllers.Hijacking
{
    public class ExternalLoginConfirmationController : RenderMvcController
    {
        public ActionResult Index(string returnUrl, string loginProvider, string email)
        {
            var model = new ExternalLoginConfirmationViewModel {Email = email};
            ViewBag.ReturnUrl = returnUrl;
            ViewBag.LoginProvider = loginProvider;
            return CurrentTemplate(model);
        }
    }
}