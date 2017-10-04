using System.Collections.Generic;

namespace UmbracoTemplate.Models.Entities
{
    public class Navigation
    {
        public Link Login { get; set; }
        public Link Register { get; set; }
        public Link Home { get; set; }
        public Link Setting { get; set; }
        public List<NavigationListItem> NavigationListItems { get; set; }
    }
}