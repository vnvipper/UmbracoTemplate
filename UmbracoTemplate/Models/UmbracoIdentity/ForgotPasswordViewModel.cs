using System.ComponentModel.DataAnnotations;

namespace UmbracoTemplate.Models.UmbracoIdentity
{
    public class ForgotPasswordViewModel
    {
        [Required]
        [EmailAddress]
        [Display(Name = "Email")]
        public string Email { get; set; }
    }
}
