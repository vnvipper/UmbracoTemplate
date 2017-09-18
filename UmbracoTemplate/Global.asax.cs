using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Umbraco.Web;

namespace UmbracoTemplate
{
    public partial class Global : UmbracoApplication
    {
        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            base.OnApplicationStarted(sender, e);
            // Custom mapper and interesting thing here
        }
    }
}