using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UmbracoTemplate.Models.ViewModels
{
    public class HomeViewModel
    {
        public Home Home { get; set; }
        public IEnumerable<Post> Posts { get; set; }
    }
}