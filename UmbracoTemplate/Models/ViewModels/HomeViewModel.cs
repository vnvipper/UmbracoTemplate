using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PagedList;
using UmbracoTemplate.Models.Entities;

namespace UmbracoTemplate.Models.ViewModels
{
    public class HomeViewModel
    {
        public Home Home { get; set; }
        public IPagedList<Article> Articles { get; set; }
        public IEnumerable<HeroImage> HeroImages { get; set; }
    }
}