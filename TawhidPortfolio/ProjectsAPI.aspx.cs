using System;
using System.Web;
using System.Web.UI;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using TawhidPortfolio.DataAccess;
using TawhidPortfolio.Models;

namespace TawhidPortfolio
{
    public partial class ProjectsAPI : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Set response headers for CORS and JSON
                Response.ContentType = "application/json";
                Response.AppendHeader("Access-Control-Allow-Origin", "*");
                Response.AppendHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
                Response.AppendHeader("Access-Control-Allow-Headers", "Content-Type");
                
                // Handle preflight OPTIONS request
                if (Request.HttpMethod == "OPTIONS")
                {
                    Response.StatusCode = 200;
                    Response.End();
                    return;
                }

                ProjectDAL projectDAL = new ProjectDAL();
                List<Project> projects = projectDAL.GetAllProjects();  // Get all projects since there's no IsActive

                // Convert to JSON-friendly format
                var projectsData = new List<object>();
                foreach (var project in projects)
                {
                    projectsData.Add(new
                    {
                        Id = project.Id,
                        Title = project.Title,
                        Description = project.Description,
                        TechStack = project.TechStack,
                        ImageUrl = string.IsNullOrEmpty(project.ImageUrl) ? "assets/images/project-placeholder.png" : project.ImageUrl,
                        ProjectUrl = project.ProjectLink,  // Map ProjectLink to ProjectUrl for frontend compatibility
                        CreatedAt = project.CreatedAt.ToString("yyyy-MM-dd")
                    });
                }

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string json = serializer.Serialize(projectsData);
                Response.Write(json);
            }
            catch (Exception ex)
            {
                Response.StatusCode = 500;
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                Response.Write(serializer.Serialize(new { 
                    error = "Internal server error", 
                    message = ex.Message 
                }));
            }
            finally
            {
                Response.End();
            }
        }
    }
}