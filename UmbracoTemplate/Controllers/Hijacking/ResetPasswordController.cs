using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Models;
using UmbracoTemplate.Models.UmbracoIdentity;

namespace UmbracoTemplate.Controllers.Hijacking
{
    public class ResetPasswordController : RenderMvcController  {
        public ActionResult Index(string code)
        {
            ResetPasswordViewModel model = new ResetPasswordViewModel
            {
                Code = code
            };

            return CurrentTemplate(model);
        }
    }
}