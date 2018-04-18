using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using PagedList;
using Umbraco.Core.Models;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Models;
using UmbracoTemplate.Models.Entities;
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
        public ActionResult Index(int? page)
        {
            int pageSize = 3;
            int pageNumber = (page ?? 1);

            HomeViewModel model = new HomeViewModel
            {
                Home = new Home(CurrentPage),
                Articles = _postDataService.GetAllByCurrentCulture().Select(Mapper.Map<Article>)
                    .OrderByDescending(m => m.PostedDate).ToPagedList(pageNumber, pageSize)
            };
            model.HeroImages = model.Home.Sliders.Select(Mapper.Map<HeroImage>);
            return CurrentTemplate(model);
        }
    }
}