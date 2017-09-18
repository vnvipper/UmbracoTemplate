using System.ComponentModel.DataAnnotations;

namespace UmbracoTemplate.Models.UmbracoIdentity
{
    public class ExternalLoginConfirmationViewModel
    {
        [Required]
        [EmailAddress]
        [Display(Name = "Email")]
        public string Email { get; set; }

        public string ReturnUrl { get; set; }
        public string LoginProvider { get; set; }
    }
}
