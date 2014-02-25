using System;
using System.Linq;
using System.Web;
using System.Web.Security;
using EPiServer.Framework.Localization;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Customers.Profile;
using Mediachase.Commerce.Security;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Catalog.ContentTypes;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.Security
{
    public partial class Login : RendererControlBase<EntryContentBase>
    {
        private readonly static string[] DefaultUserRoles = { AppRoles.RegisteredRole, AppRoles.EveryoneRole };

        /// <summary>
        /// Handles the click event of an existing user
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void loginExisting_Click(object sender, EventArgs e)
        {
            var username = EmailAddress_ExistingId.Value;
            var password = Password_ExistingId.Value;
            bool remember = !String.IsNullOrEmpty(Request.Form["RememberMe"]);

            if (username == null || !Membership.ValidateUser(username, password))
            {
                SignInFailureText.Text = "Login failed. Please make sure username and password are correct.";
                return;
            }

            var profile = SecurityContext.Current.CurrentUserProfile as CustomerProfileWrapper;
            if (profile == null)
            {
                throw new NullReferenceException("profile");
            }
            var accountState = profile.State;

            if (accountState == 1 || accountState == 3)
            {
                SignInFailureText.Text = LocalizationService.Current.GetString("Sample/Validation/AccountLocked");
                return;
            }

            CreateAuthenticationCookie(username, AppContext.Current.ApplicationName, remember);
            Context.RedirectFast(UrlResolver.GetUrl(Settings.AccountPage));
        }

        /// <summary>
        /// Handles the click event of a new user
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void loginCreateNew_Click(object sender, EventArgs e)
        {
            string firstName = FirstNameId.Value;
            string lastName = LastNameId.Value;
            string emailAddress = EmailAddressNewId.Value;
            string password = Password_NewId.Value;
            MembershipUser user = null;

            MembershipCreateStatus createStatus;
            user = Membership.CreateUser(emailAddress, password, emailAddress,
                                         null, null, true, out createStatus);
            if (createStatus == MembershipCreateStatus.DuplicateUserName)
            {
                CreateFailureText.Text = "The supplied email address already exists. Please use a different email address";
                return;
            }
            if (createStatus != MembershipCreateStatus.Success)
            {
                CreateFailureText.Text = "Error when attempting to create the user: " + createStatus.ToString();
                return;
            }

            // Now create an account in the ECF 
            var customerContact = CustomerContact.CreateInstance(user);
            customerContact.FirstName = firstName;
            customerContact.LastName = lastName;
            customerContact.RegistrationSource = String.Format("{0}, {1}", this.Request.Url.Host, SiteContext.Current);
            customerContact["Email"] = emailAddress;

            customerContact.SaveChanges();
            AssignDefaultRolesToUser(user);

            CreateAuthenticationCookie(emailAddress, AppContext.Current.ApplicationName, false);

            Context.RedirectFast(UrlResolver.GetUrl(Settings.AccountPage));
        }

        /// <summary>
        /// Creates the authentication cookie.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="domain">The domain.</param>
        /// <param name="remember">if set to <c>true</c> [remember].</param>
        private static void CreateAuthenticationCookie(string username, string domain, bool remember)
        {
            // this line is needed for cookieless authentication
            FormsAuthentication.SetAuthCookie(username, remember);
            var expirationDate = FormsAuthentication.GetAuthCookie(username, remember).Expires;

            // the code below does not work for cookieless authentication

            // we need to handle ticket ourselves since we need to save session paremeters as well
            var ticket = new FormsAuthenticationTicket(2,
                    username,
                    DateTime.Now,
                /*expirationDate, - doesn't work when it's DateTime.MinValue. The date needs to be convertible to FileTime, i.e. >=01/01/1601 */
                    expirationDate == DateTime.MinValue ? DateTime.Now.Add(FormsAuthentication.Timeout) : expirationDate,
                    remember,
                    domain,
                    FormsAuthentication.FormsCookiePath);

            // Encrypt the ticket.
            string encTicket = FormsAuthentication.Encrypt(ticket);

            // remove the cookie, if one already exists with the same cookie name
            if (HttpContext.Current.Response.Cookies[FormsAuthentication.FormsCookieName] != null)
                HttpContext.Current.Response.Cookies.Remove(FormsAuthentication.FormsCookieName);

            var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encTicket);
            cookie.HttpOnly = true;

            cookie.Path = FormsAuthentication.FormsCookiePath;
            cookie.Secure = FormsAuthentication.RequireSSL;
            if (FormsAuthentication.CookieDomain != null)
                cookie.Domain = FormsAuthentication.CookieDomain;

            if (ticket.IsPersistent)
                cookie.Expires = ticket.Expiration;

            // Create the cookie.
            HttpContext.Current.Response.Cookies.Set(cookie);
        }

        private static void AssignDefaultRolesToUser(MembershipUser user)
        {
            var roles = DefaultUserRoles.Where(r => !SecurityContext.Current.CheckUserInGlobalRole(user, r));
            var principal = SecurityContext.Current.GetPrincipalByUser(user);
            foreach (var roleName in roles)
            {
                var globalRoleAssign = new GlobalRoleAssignment(principal, roleName);
                SecurityContext.Current.CreateUserRoleAssignments(globalRoleAssign);
            }
        }
    }
}