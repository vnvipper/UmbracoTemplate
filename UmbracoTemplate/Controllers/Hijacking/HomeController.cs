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
        private readonly IDataService<Home> _homeService;

        public HomeController(IDataService<Home> homeService)
        {
            _homeService = homeService;
        }

        // GET: Home
        public ActionResult Index()
        {
            var home = _homeService.GetAll().FirstOrDefault();
            return CurrentTemplate(home);
        }
    }
}