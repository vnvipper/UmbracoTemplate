using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security;
using UmbracoTemplate.Models.UmbracoIdentity;
using Umbraco.Web;
using UmbracoTemplate;
using Umbraco.Core;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;
using UmbracoIdentity;
using UmbracoIdentity.Models;
using UmbracoTemplate.Infrastructure;
using UmbracoTemplate.Models;
using UmbracoTemplate.Services.Abstracts;
using IdentityExtensions = UmbracoIdentity.IdentityExtensions;
using RedWillow.MvcToastrFlash;


namespace UmbracoTemplate.Controllers.Surface
{
    [Microsoft.AspNet.SignalR.Authorize]
    public class AccountSurfaceController : SurfaceController
    {
        private UmbracoMembersUserManager<UmbracoApplicationMember> _userManager;
        private UmbracoMembersRoleManager<UmbracoApplicationRole> _roleManager;
        private readonly IDataService<ConfirmEmail> _confirmEmailDataService;
        private readonly IEmailSender _emailSender;

        public AccountSurfaceController(UmbracoContext umbracoContext, UmbracoMembersUserManager<UmbracoApplicationMember> userManager, UmbracoMembersRoleManager<UmbracoApplicationRole> roleManager, IDataService<ConfirmEmail> confirmEmailDataService, IEmailSender emailSender) : base(umbracoContext)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _confirmEmailDataService = confirmEmailDataService;
            _emailSender = emailSender;
        }

        public AccountSurfaceController(UmbracoContext umbracoContext, UmbracoHelper umbracoHelper, UmbracoMembersUserManager<UmbracoApplicationMember> userManager, UmbracoMembersRoleManager<UmbracoApplicationRole> roleManager, IDataService<ConfirmEmail> confirmEmailDataService, IEmailSender emailSender) : base(umbracoContext, umbracoHelper)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _confirmEmailDataService = confirmEmailDataService;
            _emailSender = emailSender;
        }

        public AccountSurfaceController(UmbracoMembersUserManager<UmbracoApplicationMember> userManager, UmbracoMembersRoleManager<UmbracoApplicationRole> roleManager, IDataService<ConfirmEmail> confirmEmailDataService, IEmailSender emailSender)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _confirmEmailDataService = confirmEmailDataService;
            _emailSender = emailSender;
        }

        public AccountSurfaceController(IDataService<ConfirmEmail> confirmEmailDataService, IEmailSender emailSender)
        {
            _confirmEmailDataService = confirmEmailDataService;
            _emailSender = emailSender;
        }

        protected IOwinContext OwinContext
        {
            get { return Request.GetOwinContext(); }
        }

        public UmbracoMembersUserManager<UmbracoApplicationMember> UserManager
        {
            get
            {
                return _userManager ?? (_userManager = OwinContext
                           .GetUserManager<UmbracoMembersUserManager<UmbracoApplicationMember>>());
            }
        }

        public UmbracoMembersRoleManager<UmbracoApplicationRole> RoleManager
        {
            get
            {
                return _roleManager ?? (_roleManager = OwinContext
                           .Get<UmbracoMembersRoleManager<UmbracoApplicationRole>>());
            }
        }


        #region External login and registration

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLogin(string provider, string returnUrl = null)
        {
            //if (returnUrl.IsNullOrWhiteSpace())
            //{
            //    returnUrl = Request.RawUrl;
            //}

            // Request a redirect to the external login provider
            return new ChallengeResult(provider,
                Url.SurfaceAction<AccountSurfaceController>("ExternalLoginCallback", new { ReturnUrl = returnUrl }));
        }

        [HttpGet]
        [AllowAnonymous]
        public async Task<ActionResult> ExternalLoginCallback(string returnUrl)
        {
            var loginInfo = await OwinContext.Authentication.GetExternalLoginInfoAsync();
            if (loginInfo == null)
            {
                //go home, invalid callback
                return RedirectToLocal(returnUrl);
            }

            // Sign in the user with this external login provider if the user already has a login
            var user = await UserManager.FindAsync(loginInfo.Login);
            if (user != null)
            {
                await SignInAsync(user, isPersistent: false);
                return RedirectToLocal(returnUrl);
            }
            else
            {
                // If the user does not have an account, then prompt the user to create an account
                //ViewBag.ReturnUrl = returnUrl;
                //ViewBag.LoginProvider = loginInfo.Login.LoginProvider;
                //return View("~/Views/Partials/Account/_ExternalLoginConfirmation.cshtml", new ExternalLoginConfirmationViewModel { Email = loginInfo.Email });
                var url =
                    $"{Helpers.GetPage<ExternalLoginConfirmation>().Url}?returnUrl={Url.Encode(returnUrl)}&loginProvider={Url.Encode(loginInfo.Login.LoginProvider)}&email={Url.Encode(loginInfo.Email)}";
                return RedirectToLocal(url);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ExternalLoginConfirmation(ExternalLoginConfirmationViewModel model, string returnUrl)
        {
            if (User.Identity.IsAuthenticated)
            {
                //go home, already authenticated
                return RedirectToLocal(returnUrl);
            }

            if (ModelState.IsValid)
            {
                // Get the information about the user from the external login provider
                var info = await OwinContext.Authentication.GetExternalLoginInfoAsync();
                if (info == null)
                {
                    this.Flash(Toastr.ERROR, "Unsuccessful login with service.");
                    return CurrentUmbracoPage();
                }

                var user = new UmbracoApplicationMember
                {
                    Name = info.ExternalIdentity.Name,
                    UserName = model.Email,
                    Email = model.Email,
                    MemberProperties = new List<UmbracoProperty>
                    {
                        new UmbracoProperty
                        {
                            Alias = "isEmailConfirmed",
                            Value = "1"
                        }
                    }
                };

                var result = await UserManager.CreateAsync(user);
                if (result.Succeeded)
                {
                    result = await UserManager.AddLoginAsync(user.Id, info.Login);
                    if (result.Succeeded)
                    {


                        await SignInAsync(user, isPersistent: false);

                        // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                        // Send an email with this link
                        //string code = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);
                        //var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
                        //SendEmail(user.Email, callbackUrl, "Confirm your account", "Please confirm your account by clicking this link");
                        return RedirectToLocal(returnUrl);
                    }
                }
                AddModelErrors(result);
            }

            ViewBag.ReturnUrl = returnUrl;
            return CurrentUmbracoPage();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LinkLogin(string provider, string returnUrl = null)
        {
            if (returnUrl.IsNullOrWhiteSpace())
            {
                returnUrl = Request.RawUrl;
            }

            // Request a redirect to the external login provider to link a login for the current user
            return new ChallengeResult(provider,
                Url.SurfaceAction<AccountSurfaceController>("LinkLoginCallback", new { ReturnUrl = returnUrl }),
                User.Identity.GetUserId());
        }

        [HttpGet]
        public async Task<ActionResult> LinkLoginCallback(string returnUrl)
        {
            var loginInfo = await AuthenticationManager.GetExternalLoginInfoAsync(XsrfKey, User.Identity.GetUserId());
            if (loginInfo == null)
            {
                TempData["LinkLoginError"] = new[] { "An error occurred, could not get external login info" };
                return RedirectToLocal(returnUrl);
            }
            var result = await UserManager.AddLoginAsync(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity), loginInfo.Login);
            if (result.Succeeded)
            {
                return RedirectToLocal(returnUrl);
            }

            TempData["LinkLoginError"] = result.Errors.ToArray();
            return RedirectToLocal(returnUrl);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Disassociate(string loginProvider, string providerKey)
        {
            var result = await UserManager.RemoveLoginAsync(
                UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity),
                new UserLoginInfo(loginProvider, providerKey));

            if (result.Succeeded)
            {
                var user = await UserManager.FindByIdAsync(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity));
                await SignInAsync(user, isPersistent: false);
                return RedirectToCurrentUmbracoPage();
            }
            else
            {
                AddModelErrors(result);
                return CurrentUmbracoPage();
            }
        }

        [AllowAnonymous]
        public ActionResult ExternalLoginFailure()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult RemoveAccountList()
        {
            var linkedAccounts = UserManager.GetLogins(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity));
            ViewBag.ShowRemoveButton = HasPassword() || linkedAccounts.Count > 1;
            return PartialView(linkedAccounts);
        }

        #endregion

        #region Standard login and registration

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> HandleLogin(LoginViewModel model, string returnUrl)
        {

            if (ModelState.IsValid)
            {
                var user = await UserManager.FindAsync(model.Email, model.Password);

                if (user != null)
                {
                    if (!await IsEmailConfirmedAsync(user.Id))
                    {
                        ModelState.AddModelError(string.Empty,
                            "You must have a confirmed email to log in.");
                        return CurrentUmbracoPage();
                    }
                    await SignInAsync(user, model.RememberMe);
                    return RedirectToCurrentUmbracoPage();
                }
                ModelState.AddModelError("", "Invalid username or password");
            }

            return CurrentUmbracoPage();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult HandleLogout([Bind(Prefix = "logoutModel")]PostRedirectModel model)
        {
            if (ModelState.IsValid == false)
            {
                return CurrentUmbracoPage();
            }

            if (Members.IsLoggedIn())
            {
                //ensure to only clear the default cookies
                OwinContext.Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie, DefaultAuthenticationTypes.ExternalCookie);
            }

            //if there is a specified path to redirect to then use it
            if (model.RedirectUrl.IsNullOrWhiteSpace() == false)
            {
                return Redirect(model.RedirectUrl);
            }

            //redirect to current page by default
            this.Flash(Toastr.INFO, "You have just logout this system!");
            return RedirectToCurrentUmbracoPage();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> HandleRegisterMember(RegisterViewModel model, string returnUrl = null)
        {

            if (ModelState.IsValid == false)
            {
                return CurrentUmbracoPage();
            }

            var user = new UmbracoApplicationMember
            {
                UserName = model.Email,
                Email = model.Email,
                MemberTypeAlias = "Member"
            };

            var result = await UserManager.CreateAsync(user, model.Password);
            if (result.Succeeded)
            {
                //await SignInAsync(user, isPersistent: false);

                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                // Send an email with this link
                string code = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);

                user.MemberProperties = new List<UmbracoProperty>
                {
                    new UmbracoProperty
                    {
                        Alias = "emailConfirmationToken",
                        Value = code
                    }
                };

                var updateResult = await UserManager.UpdateAsync(user);
                if (updateResult.Succeeded)
                {
                    var callbackUrl
                        = /*$"{_confirmEmailDataService.Get().UrlAbsolute()}?userId={user.Id}&code={code}";*/
                        Url.Action("ConfirmEmail", "AccountSurface", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
                    await _emailSender.SendMailAsync(user.Email, "Confirm your account",
                        "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>");
                    this.Flash(Toastr.INFO, "A email have just to send for you! please confirm this to login!");
                    return RedirectToLocal(returnUrl);
                }
                else
                {
                    AddModelErrors(updateResult);
                }
            }
            else
            {
                AddModelErrors(result);
            }

            return CurrentUmbracoPage();
        }

        #endregion

        [AllowAnonymous]
        public async Task<ActionResult> ConfirmEmail(int userId, string code)
        {
            bool result = false;
            if (code == null)
            {
                return RedirectToLocal("/Error");
            }

            var user = await FindUserByAsync(userId, code);
            if (user != null)
            {
                user.MemberProperties.Find(m => m.Alias == "isEmailConfirmed").Value = "1";
                var updateResult = await UserManager.UpdateAsync(user);
                result = updateResult.Succeeded;
            }


            return RedirectToLocal(result ? _confirmEmailDataService.Get().Url : "/Error");
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ForgotPassword(ForgotPasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = await UserManager.FindByNameAsync(model.Email);
                if (user == null || !(await IsEmailConfirmedAsync(user.Id)))
                {
                    // Don't reveal that the user does not exist or is not confirmed
                    this.Flash(Toastr.WARNING, "Please check your email to reset your password.");
                }

                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                // Send an email with this link
                if (user != null)
                {
                    string code = await UserManager.GeneratePasswordResetTokenAsync(user.Id);
                    user.MemberProperties = new List<UmbracoProperty>
                    {
                        new UmbracoProperty
                        {
                            Alias = "emailConfirmationToken",
                            Value = code
                        }
                    };

                    var updateResult = await UserManager.UpdateAsync(user);
                    //var callbackUrl = Url.Action("ResetPassword", "AccountSurface", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
                    var callbackUrl = $"{Helpers.GetPage<ResetPassword>().UrlAbsolute()}?code={Url.Encode(code)}";
                    await _emailSender.SendMailAsync(user.Email, "Reset Password", "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>");
                    this.Flash(Toastr.INFO, "Please check your email to reset your password.");
                }

            }

            // If we got this far, something failed, redisplay form
            return CurrentUmbracoPage();
        }


        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ResetPassword(ResetPasswordViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return CurrentUmbracoPage();
            }
            var user = await UserManager.FindByNameAsync(model.Email);
            if (user == null)
            {
                // Don't reveal that the user does not exist
                var message = $"Your password has been reset. Please <a href='{Helpers.GetPage<Login>().Url}'>click here to log in</a>";
                this.Flash(Toastr.INFO, message);
                return RedirectToCurrentUmbracoPage();
            }

            if (IsUserHasToken(user, model.Code))
            {
                user.PasswordHash = UserManager.PasswordHasher.HashPassword(model.Password);
                var result = await UserManager.UpdateAsync(user);
                if (result.Succeeded)
                {
                    var message = $"Your password has been reset. Please <a href='{Helpers.GetPage<Login>().Url}'>click here to log in</a>";
                    this.Flash(Toastr.INFO, message);
                    return RedirectToCurrentUmbracoPage();
                }
                AddModelErrors(result);
            }

            return CurrentUmbracoPage();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ToggleRole(string roleName)
        {
            if (string.IsNullOrWhiteSpace(roleName)) throw new ArgumentNullException("role cannot be null");

            var user = await UserManager.FindByIdAsync(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity));
            if (user != null)
            {
                var found = user.Roles.FirstOrDefault(x => x.RoleName == roleName);
                if (found != null)
                {
                    user.Roles.Remove(found);
                }
                else
                {
                    user.Roles.Add(new IdentityMemberRole { RoleName = roleName, UserId = user.Id });
                }
                var result = await UserManager.UpdateAsync(user);
                if (result.Succeeded)
                {
                    return RedirectToCurrentUmbracoPage();
                }
                else
                {
                    foreach (var error in result.Errors)
                    {
                        ModelState.AddModelError("", error);
                    }
                    return CurrentUmbracoPage();
                }
            }

            return RedirectToCurrentUmbracoPage();
        }

        [ChildActionOnly]
        public async Task<ActionResult> ShowRoles()
        {
            var user = await UserManager.FindByIdAsync(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity));

            var model = new RoleManagementModel();

            if (user != null)
            {
                model.AssignedRoles = user.Roles.Select(x => x.RoleName);
                model.AvailableRoles = await RoleManager.GetAll();
            }

            return PartialView("ShowRoles", model);
        }

        [ChildActionOnly]
        public ActionResult ManagePassword()
        {
            ViewBag.HasLocalPassword = HasPassword();
            return View();
        }

        [NotChildAction]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ManagePassword([Bind(Prefix = "managePasswordModel")] UserPasswordModel model)
        {
            bool hasPassword = HasPassword();
            ViewBag.HasLocalPassword = hasPassword;

            //vaidate their passwords match
            if (model.NewPassword != model.ConfirmPassword)
            {
                ModelState.AddModelError("managePasswordModel.ConfirmPassword", "Passwords do not match");
            }

            if (hasPassword)
            {
                if (ModelState.IsValid)
                {
                    IdentityResult result = await UserManager.ChangePasswordAsync(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity), model.OldPassword, model.NewPassword);
                    if (result.Succeeded)
                    {
                        var user = await UserManager.FindByIdAsync(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity));
                        await SignInAsync(user, isPersistent: false);
                        TempData["ChangePasswordSuccess"] = true;
                        return RedirectToCurrentUmbracoPage();
                    }
                    else
                    {
                        AddModelErrors(result, "managePasswordModel");
                    }
                }
            }
            else
            {
                // User does not have a password so remove any validation errors caused by a missing OldPassword field
                var state = ModelState["managePasswordModel.OldPassword"];
                if (state != null)
                {
                    state.Errors.Clear();
                }

                if (ModelState.IsValid)
                {
                    IdentityResult result = await UserManager.AddPasswordAsync(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity), model.NewPassword);
                    if (result.Succeeded)
                    {
                        TempData["ChangePasswordSuccess"] = true;
                        return RedirectToCurrentUmbracoPage();
                    }
                    else
                    {
                        AddModelErrors(result, "managePasswordModel");
                    }
                }
            }

            // If we got this far, something failed, redisplay form
            return CurrentUmbracoPage();
        }



        #region Helpers

        // Used for XSRF protection when adding external logins
        private const string XsrfKey = "XsrfId";

        private string CreateEmailConfirmationToken()
        {
            return Guid.NewGuid().ToString();
        }
        private IAuthenticationManager AuthenticationManager
        {
            get
            {
                return HttpContext.GetOwinContext().Authentication;
            }
        }

        private async Task SignInAsync(UmbracoApplicationMember member, bool isPersistent)
        {
            OwinContext.Authentication.SignOut(DefaultAuthenticationTypes.ExternalCookie);
            OwinContext.Authentication.SignIn(new AuthenticationProperties() { IsPersistent = isPersistent },
                await member.GenerateUserIdentityAsync(UserManager));
        }

        private void AddModelErrors(IdentityResult result, string prefix = "")
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(prefix, error);
            }
        }
        private async Task<bool> IsEmailConfirmedAsync(int userId)
        {
            bool result = false;
            var user = await UserManager.FindByIdAsync(userId);

            if (user != null)
            {
                result = user.MemberProperties.Find(m => m.Alias == "isEmailConfirmed")?.Value == "1";
            }
            return result;
        }

        private async Task<UmbracoApplicationMember> FindUserByAsync(int userId, string token)
        {
            var user = await UserManager.FindByIdAsync(userId);
            if (user != null)
            {
                var code = WebUtility.HtmlDecode(token);
                if (IsUserHasToken(user, code))
                {
                    return user;
                }
            }

            return null;
        }

        private bool IsUserHasToken(UmbracoApplicationMember user, string token)
        {
            bool result = false;
            result = user.MemberProperties.Find(t =>
                t.Alias == "emailConfirmationToken")?.Value == token;
            return result;
        }

        private bool HasPassword()
        {
            var user = UserManager.FindById(UmbracoIdentity.IdentityExtensions.GetUserId<int>(User.Identity));
            if (user != null)
            {
                return !user.PasswordHash.IsNullOrWhiteSpace();
            }
            return false;
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return Redirect("/");
        }

        private class ChallengeResult : HttpUnauthorizedResult
        {
            public ChallengeResult(string provider, string redirectUri, string userId = null)
            {
                LoginProvider = provider;
                RedirectUri = redirectUri;
                UserId = userId;
            }

            private string LoginProvider { get; set; }
            private string RedirectUri { get; set; }
            private string UserId { get; set; }

            public override void ExecuteResult(ControllerContext context)
            {
                var properties = new AuthenticationProperties() { RedirectUri = RedirectUri };
                if (UserId != null)
                {
                    properties.Dictionary[XsrfKey] = UserId;
                }
                context.HttpContext.GetOwinContext().Authentication.Challenge(properties, LoginProvider);
            }
        }

        #endregion

    }
}