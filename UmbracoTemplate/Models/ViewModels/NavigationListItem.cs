﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UmbracoTemplate.Models.ViewModels
{
    public class NavigationListItem
    {
        public string Text { get; set; }
        public Link Link { get; set; }
        public List<NavigationListItem> Items { get; set; }
        public bool HasChildren => Items != null && Items.Any() && Items.Count > 0;

        public NavigationListItem()
        { }

        public NavigationListItem(Link link)
        {
            Link = link;
        }

        public NavigationListItem(string text)
        {
            Text = text;
        }
    }
}