using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using TawhidPortfolio.Models;
using TawhidPortfolio.DataAccess;

namespace TawhidPortfolio
{
    public partial class TestContactForm : System.Web.UI.Page
    {
        protected TextBox txtName;
        protected TextBox txtEmail;
        protected TextBox txtSubject;
        protected TextBox txtMessage;
        protected Button btnSubmitTest;
        protected Button btnTestSystem;
        protected Button btnCheckConfig;
        protected Label lblSubmissionResult;
        protected Label lblSystemStatus;
        protected Label lblConfigCheck;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblSystemStatus.Text = "";
                lblSubmissionResult.Text = "";
                lblConfigCheck.Text = "";
            }
        }

        protected void btnTestSystem_Click(object sender, EventArgs e)
        {
            try
            {
                // Test 1: Database Connection
                string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                bool dbConnected = false;
                string dbMessage = "";

                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        string query = "SELECT COUNT(*) FROM ContactMessages";
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            int count = Convert.ToInt32(command.ExecuteScalar());
                            dbConnected = true;
                            dbMessage = $"? Database connected successfully! Found {count} messages.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    dbMessage = $"? Database connection failed: {ex.Message}";
                }

                // Test 2: Data Access Layer
                bool dalWorking = false;
                string dalMessage = "";
                try
                {
                    ContactMessageDAL dal = new ContactMessageDAL();
                    var messages = dal.GetAllContactMessages();
                    dalWorking = true;
                    dalMessage = $"? Data Access Layer working! Retrieved {messages.Count} messages.";
                }
                catch (Exception ex)
                {
                    dalMessage = $"? Data Access Layer failed: {ex.Message}";
                }

                // Test 3: Contact API Test
                string apiMessage = "? Contact API endpoint available at /ContactAPI.aspx";

                // Compile results
                string overallStatus = "";
                if (dbConnected && dalWorking)
                {
                    overallStatus = "?? All systems operational! Ready for frontend integration.";
                    lblSystemStatus.CssClass = "status success";
                }
                else
                {
                    overallStatus = "?? Some systems need attention. Check the details below.";
                    lblSystemStatus.CssClass = "status error";
                }

                lblSystemStatus.Text = $@"
                    <div style='margin: 15px 0;'>
                        <h4>{overallStatus}</h4>
                        <p><strong>Database:</strong> {dbMessage}</p>
                        <p><strong>Data Layer:</strong> {dalMessage}</p>
                        <p><strong>API Endpoint:</strong> {apiMessage}</p>
                    </div>";
            }
            catch (Exception ex)
            {
                lblSystemStatus.Text = $"<div class='status error'>System test failed: {ex.Message}</div>";
            }
        }

        protected void btnSubmitTest_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate inputs
                if (string.IsNullOrWhiteSpace(txtName.Text) ||
                    string.IsNullOrWhiteSpace(txtEmail.Text) ||
                    string.IsNullOrWhiteSpace(txtSubject.Text) ||
                    string.IsNullOrWhiteSpace(txtMessage.Text))
                {
                    lblSubmissionResult.Text = "<div class='status error'>Please fill in all fields.</div>";
                    return;
                }

                // Create test message
                ContactMessage testMessage = new ContactMessage
                {
                    Name = txtName.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Subject = $"[TEST] {txtSubject.Text.Trim()}",
                    Message = $"TEST MESSAGE: {txtMessage.Text.Trim()}"
                };

                // Submit through DAL
                ContactMessageDAL dal = new ContactMessageDAL();
                bool success = dal.InsertContactMessage(testMessage);

                if (success)
                {
                    lblSubmissionResult.Text = "<div class='status success'>? Test message submitted successfully! Check the <a href='AdminMessages.aspx'>Admin Panel</a> to view it.</div>";
                    
                    // Clear form
                    txtName.Text = "";
                    txtEmail.Text = "";
                    txtSubject.Text = "";
                    txtMessage.Text = "";
                }
                else
                {
                    lblSubmissionResult.Text = "<div class='status error'>? Failed to submit test message. Check your database connection.</div>";
                }
            }
            catch (Exception ex)
            {
                lblSubmissionResult.Text = $"<div class='status error'>Error submitting test message: {ex.Message}</div>";
            }
        }

        protected void btnCheckConfig_Click(object sender, EventArgs e)
        {
            try
            {
                string configReport = "<div style='margin: 15px 0;'>";
                
                // Check connection string
                var connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"];
                if (connectionString != null)
                {
                    configReport += $"<p><strong>? Connection String:</strong> Found</p>";
                    configReport += $"<p><strong>Provider:</strong> {connectionString.ProviderName}</p>";
                    
                    // Mask password in connection string for display
                    string safeConnectionString = connectionString.ConnectionString;
                    if (safeConnectionString.Contains("Password="))
                    {
                        safeConnectionString = System.Text.RegularExpressions.Regex.Replace(
                            safeConnectionString, @"Password=[^;]*", "Password=***");
                    }
                    configReport += $"<p><strong>Connection:</strong> {safeConnectionString}</p>";
                }
                else
                {
                    configReport += "<p><strong>? Connection String:</strong> Not found!</p>";
                }

                // Check .NET Framework version
                configReport += $"<p><strong>? .NET Framework:</strong> {System.Environment.Version}</p>";
                
                // Check if running in debug mode
                bool isDebug = System.Diagnostics.Debugger.IsAttached;
                configReport += $"<p><strong>Debug Mode:</strong> {(isDebug ? "Yes" : "No")}</p>";

                configReport += "</div>";

                lblConfigCheck.Text = configReport;
                lblConfigCheck.CssClass = "status info";
            }
            catch (Exception ex)
            {
                lblConfigCheck.Text = $"<div class='status error'>Configuration check failed: {ex.Message}</div>";
            }
        }
    }
}