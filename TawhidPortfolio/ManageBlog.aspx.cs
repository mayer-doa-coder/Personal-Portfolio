using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using TawhidPortfolio.DataAccess;
using TawhidPortfolio.Models;

namespace TawhidPortfolio
{
    public partial class ManageBlog : Page
    {
        // Control declarations
        protected Literal litPageTitle;
        protected TextBox txtTitle;
        protected TextBox txtContent;
        protected TextBox txtImageUrl;
        protected Button btnSave;
        protected Panel pnlError;
        protected Label lblError;
        protected Panel pnlSuccess;
        protected Label lblSuccess;

        private BlogDAL blogDAL = new BlogDAL();  // Changed from BlogPostDAL
        private int blogId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    // Check if editing existing blog post
                    if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out blogId))
                    {
                        LoadBlog(blogId);
                        litPageTitle.Text = "Edit Blog Post";
                        btnSave.Text = "Update Blog Post";
                    }
                    else
                    {
                        litPageTitle.Text = "Add New Blog Post";
                        btnSave.Text = "Save Blog Post";
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Page Load Error: " + ex.Message);
            }
        }

        private void LoadBlog(int id)
        {
            try
            {
                Blog blog = blogDAL.GetBlogById(id);  // Changed from BlogPost
                if (blog != null)
                {
                    txtTitle.Text = blog.Title;
                    txtContent.Text = blog.Content;
                    txtImageUrl.Text = blog.ImageUrl;
                    ViewState["BlogId"] = blog.Id;
                }
                else
                {
                    ShowError("Blog post not found.");
                    Response.Redirect("AdminPanel.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading blog post: " + ex.Message);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear previous messages
                pnlError.Visible = false;
                pnlSuccess.Visible = false;

                if (Page.IsValid)
                {
                    Blog blog = new Blog  // Changed from BlogPost
                    {
                        Title = txtTitle.Text.Trim(),
                        Content = txtContent.Text.Trim(),
                        ImageUrl = txtImageUrl.Text.Trim()
                    };

                    bool success = false;
                    string message = "";

                    // Check if editing existing blog post
                    if (ViewState["BlogId"] != null)
                    {
                        blog.Id = Convert.ToInt32(ViewState["BlogId"]);
                        success = blogDAL.UpdateBlog(blog);  // Changed method name
                        message = success ? "Blog post updated successfully!" : "Failed to update blog post.";
                    }
                    else
                    {
                        int newId = blogDAL.InsertBlog(blog);  // Changed method name
                        success = newId > 0;
                        message = success ? "Blog post added successfully!" : "Failed to add blog post.";
                    }

                    if (success)
                    {
                        ShowSuccess(message);
                        // Redirect to admin panel after a short delay
                        Response.Write("<script>setTimeout(function(){ window.location.href='AdminPanel.aspx'; }, 2000);</script>");
                    }
                    else
                    {
                        ShowError(message);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error saving blog post: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            pnlSuccess.Visible = false;
            lblError.Text = message;
        }

        private void ShowSuccess(string message)
        {
            pnlSuccess.Visible = true;
            pnlError.Visible = false;
            lblSuccess.Text = message;
        }
    }
}