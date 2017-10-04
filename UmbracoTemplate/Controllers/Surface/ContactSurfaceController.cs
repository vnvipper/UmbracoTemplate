using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using RedWillow.MvcToastrFlash;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Infrastructure;
using UmbracoTemplate.Models.ViewModels;
using UmbracoTemplate.Services.Abstracts;

namespace UmbracoTemplate.Controllers.Surface
{
    public class ContactSurfaceController : SurfaceController
    {
        public const string PARTIAL_VIEW_FOLDER = "~/Views/Partials/Contact/";
        private readonly IEmailSender _emailSender;

        public ContactSurfaceController(IEmailSender emailSender)
        {
            _emailSender = emailSender;
        }

        public ActionResult RenderForm()
        {
            return PartialView(PARTIAL_VIEW_FOLDER + "_Contact.cshtml", new ContactViewModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm(ContactViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (_emailSender.SendMail("nguyenpvdtu@gmail.com", model.FirstName, model.Message))
                {
                    this.Flash(Toastr.SUCCESS, Umbraco.GetDictionaryValue(Constants.Dictionary.CONTACTSUCCESS));
                }
                else
                {
                    this.Flash(Toastr.ERROR, Umbraco.GetDictionaryValue(Constants.Dictionary.SENDMAILFAIL));
                }          
                return RedirectToCurrentUmbracoPage();
            }
            return CurrentUmbracoPage();
        }
    }
}