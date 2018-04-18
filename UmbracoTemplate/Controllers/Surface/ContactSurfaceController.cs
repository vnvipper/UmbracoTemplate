using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using RedWillow.MvcToastrFlash;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Infrastructure;
using UmbracoTemplate.Models;
using UmbracoTemplate.Models.ViewModels;
using UmbracoTemplate.Services.Abstracts;

namespace UmbracoTemplate.Controllers.Surface
{
    public class ContactSurfaceController : SurfaceController
    {
        public const string PARTIAL_VIEW_FOLDER = "~/Views/Partials/Contact/";
        private readonly IEmailSender _emailSender;
        private readonly IDataService<Contact> _contactDataService;

        public ContactSurfaceController(IEmailSender emailSender, IDataService<Contact> contactDataService)
        {
            _emailSender = emailSender;
            _contactDataService = contactDataService;
        }

        public ActionResult RenderForm()
        {
            return PartialView(PARTIAL_VIEW_FOLDER + "_Contact.cshtml", new ContactViewModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> SubmitForm(ContactViewModel model)
        {
            if (Helpers.IsValidRecaptcha(Request["g-recaptcha-response"]))
            {
                if (ModelState.IsValid)
                {
                    Contact contact = _contactDataService.GetByCurrentCulture();
                    if (await _emailSender.SendMailAsync(contact.ReceiverEmail, string.Format(contact.EmailSubject, model.FirstName), EmailBody(contact.EmailBody.ToString(), model)))
                    {
                        await _emailSender.SendMailAsync(model.EmailAddress, contact.ResponseSubject,
                            EmailBody(contact.ResponseBody.ToString(), model));
                        this.Flash(Toastr.SUCCESS, Umbraco.GetDictionaryValue(DictionaryConstants.CONTACTSUCCESS));
                    }
                    else
                    {
                        this.Flash(Toastr.ERROR, Umbraco.GetDictionaryValue(DictionaryConstants.SENDMAILFAIL));
                    }
                    return RedirectToCurrentUmbracoPage();
                }
            }
            else
            {
                ModelState.AddModelError("recapchaError", "Recapcha invalid!");
            }
            
            return CurrentUmbracoPage();
        }

        public string EmailBody(string mailBody, ContactViewModel model)
        {
            return mailBody.Replace("#firstname#", model.FirstName)
                .Replace("#lastname#", model.LastName)
                .Replace("#email#", model.EmailAddress)
                .Replace("#subject#", model.Subject)
                .Replace("#message#", model.Message);
        }
    }
}