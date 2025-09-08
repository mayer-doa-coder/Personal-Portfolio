using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using TawhidPortfolio.Models;
using TawhidPortfolio.DataAccess;

namespace TawhidPortfolio
{
    public partial class AdminMessages : System.Web.UI.Page
    {
        protected GridView gvMessages;
        protected Label lblTotalMessages;
        protected Label lblMessage;
        protected Button btnRefresh;
        
        private ContactMessageDAL messageDAL;

        public AdminMessages()
        {
            messageDAL = new ContactMessageDAL();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMessages();
            }
        }

        private void LoadMessages()
        {
            try
            {
                List<ContactMessage> messages = messageDAL.GetAllContactMessages();
                
                // Bind data to GridView
                gvMessages.DataSource = messages;
                gvMessages.DataBind();
                
                // Update total count
                lblTotalMessages.Text = messages.Count.ToString();
                
                // Clear any previous messages
                lblMessage.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading messages: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblTotalMessages.Text = "0";
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadMessages();
            lblMessage.Text = "Messages refreshed successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }

        protected void gvMessages_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteMessage")
            {
                try
                {
                    int messageId = Convert.ToInt32(e.CommandArgument);
                    bool success = messageDAL.DeleteContactMessage(messageId);
                    
                    if (success)
                    {
                        lblMessage.Text = "Message deleted successfully!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        LoadMessages(); // Refresh the grid
                    }
                    else
                    {
                        lblMessage.Text = "Failed to delete message.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error deleting message: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}