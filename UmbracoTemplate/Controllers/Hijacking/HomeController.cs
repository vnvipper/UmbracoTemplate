using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Models;
using UmbracoTemplate.Services.Abstracts;
using UmbracoTemplate.Services.Implements;

namespace UmbracoTemplate.Controllers.Hijacking
{
    public class HomeController : RenderMvcController
    {
        private readonly IDataService<Home> _homeDataService;

        public HomeController(IDataService<Home> homeDataService)
        {
            _homeDataService = homeDataService;
        }

        // GET: Home
        public ActionResult Index()
        {
            var home = _homeDataService.GetByCurrentCulture();
            return CurrentTemplate(home);
        }
    }
}