using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using UmbracoTemplate.Infrastructure;
using UmbracoTemplate.Infrastructure.UmbracoValidationAttribute;

namespace UmbracoTemplate.Models.ViewModels
{
    public class ContactViewModel
    {
        [URequired]
        [UDisplayName("FirstName")]
        public string FirstName { get; set; }

        [URequired]
        [UDisplayName("LastName")]
        public string LastName { get; set; }

        [URequired]
        [UEmail]
        [UDisplayName("EmailAddress")]
        public string EmailAddress { get; set; }

        [URequired]
        [UDisplayName("Subject")]
        public string  Subject { get; set; }

        [URequired]
        [UDisplayName("Message")]
        public string Message { get; set; }
    }
}