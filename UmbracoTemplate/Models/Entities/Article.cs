using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Models;
using UmbracoTemplate.Infrastructure;

namespace UmbracoTemplate.Models.Entities
{
    public class Article
    {
        private string _creator;
        public string Title { get; set; }

        public string Creator
        {
            get
            {
                return string.Format(Helpers.UmbracoHelper.GetDictionaryValue(DictionaryConstants.POSTBY), _creator);
            }
            set { _creator = value; }
        }

        public string Category { get; set; }
        public DateTime PostedDate { get; set; }
        public string Description { get; set; }
        public string Content { get; set; }
        public IPublishedContent FeaturedImage { get; set; }
        public string Url { get; set; }
        public IEnumerable<string> Tags { get; set; }
    }
}