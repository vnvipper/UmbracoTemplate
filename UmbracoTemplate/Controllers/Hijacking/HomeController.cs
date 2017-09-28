using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Models;
using UmbracoTemplate.Models.ViewModels;
using UmbracoTemplate.Services.Abstracts;
using UmbracoTemplate.Services.Implements;

namespace UmbracoTemplate.Controllers.Hijacking
{
    public class HomeController : RenderMvcController
    {
        private readonly IDataService<Home> _homeDataService;
        private readonly IDataService<Post> _postDataService;

        public HomeController(IDataService<Home> homeDataService, IDataService<Post> postDataService)
        {
            _homeDataService = homeDataService;
            _postDataService = postDataService;
        }

        // GET: Home
        public ActionResult Index()
        {
            HomeViewModel model = new HomeViewModel
            {
                Home = new Home(CurrentPage),
                Posts = _postDataService.GetAllByCurrentCulture()
            };
            return CurrentTemplate(model);
        }
    }
}