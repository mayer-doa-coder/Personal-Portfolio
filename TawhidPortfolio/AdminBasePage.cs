using System;
using System.Web;
using System.Web.UI;

namespace TawhidPortfolio
{
    public class AdminBasePage : Page
    {
        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);
            
            // Check authentication before page loads
            if (!IsAdminAuthenticated())
            {
                RedirectToLogin();
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            
            // Double-check authentication on every request
            if (!IsAdminAuthenticated())
            {
                RedirectToLogin();
            }

            // Extend session if user is active
            ExtendSession();
        }

        /// <summary>
        /// Checks if admin is authenticated
        /// </summary>
        protected bool IsAdminAuthenticated()
        {
            try
            {
                // Check session variables
                if (Session["AdminId"] == null || Session["AdminUsername"] == null)
                {
                    return false;
                }

                // Check session timeout
                if (Session["AdminLoginTime"] != null)
                {
                    DateTime loginTime = (DateTime)Session["AdminLoginTime"];
                    TimeSpan sessionDuration = DateTime.Now - loginTime;
                    
                    // If session is older than 30 minutes of inactivity, logout
                    if (sessionDuration.TotalMinutes > 30)
                    {
                        ClearSession();
                        return false;
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Authentication check error: " + ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Gets current admin ID from session
        /// </summary>
        protected int GetCurrentAdminId()
        {
            if (Session["AdminId"] != null)
            {
                return Convert.ToInt32(Session["AdminId"]);
            }
            return 0;
        }

        /// <summary>
        /// Gets current admin username from session
        /// </summary>
        protected string GetCurrentAdminUsername()
        {
            return Session["AdminUsername"] as string ?? "";
        }

        /// <summary>
        /// Gets current admin email from session
        /// </summary>
        protected string GetCurrentAdminEmail()
        {
            return Session["AdminEmail"] as string ?? "";
        }

        /// <summary>
        /// Extends session by updating last activity time
        /// </summary>
        protected void ExtendSession()
        {
            if (IsAdminAuthenticated())
            {
                Session["AdminLastActivity"] = DateTime.Now;
            }
        }

        /// <summary>
        /// Logs out admin and redirects to login
        /// </summary>
        protected void LogoutAdmin()
        {
            try
            {
                // Clear session
                ClearSession();

                // Clear remember me cookie
                ClearRememberMeCookie();

                // Redirect to login
                Response.Redirect("AdminLogin.aspx?logout=true");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Logout error: " + ex.Message);
                Response.Redirect("AdminLogin.aspx");
            }
        }

        /// <summary>
        /// Redirects to login page
        /// </summary>
        private void RedirectToLogin()
        {
            string returnUrl = Request.Url.PathAndQuery;
            Response.Redirect($"AdminLogin.aspx?returnUrl={HttpUtility.UrlEncode(returnUrl)}");
        }

        /// <summary>
        /// Clears admin session
        /// </summary>
        private void ClearSession()
        {
            Session.Remove("AdminId");
            Session.Remove("AdminUsername");
            Session.Remove("AdminEmail");
            Session.Remove("AdminLoginTime");
            Session.Remove("AdminLastActivity");
            Session.Abandon();
        }

        /// <summary>
        /// Clears remember me cookie
        /// </summary>
        private void ClearRememberMeCookie()
        {
            HttpCookie rememberCookie = new HttpCookie("AdminRememberMe");
            rememberCookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(rememberCookie);
        }

        /// <summary>
        /// Shows success message (can be overridden by derived classes)
        /// </summary>
        protected virtual void ShowSuccess(string message)
        {
            Response.Write($"<script>alert('{message}');</script>");
        }

        /// <summary>
        /// Shows error message (can be overridden by derived classes)
        /// </summary>
        protected virtual void ShowError(string message)
        {
            Response.Write($"<script>alert('Error: {message}');</script>");
        }
    }
}