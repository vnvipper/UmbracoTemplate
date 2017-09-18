﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace UmbracoTemplate.Models.ViewModels
{
    public class Link
    {
        public Link()
        {
            
        }

        public Link(string name, string url, bool newWindow = false, string title = null)
        {
            Text = name;
            Url = url;
            NewWindow = newWindow;
            Title = title;
        }

        public string Text { get; set; }
        public string  Url { get; set; }
        public bool NewWindow { get; set; }
        public string Target => NewWindow ? "_blank" : null;
        public string Title { get; set; }
    }
}