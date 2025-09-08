using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TawhidPortfolio.Models;

namespace TawhidPortfolio.DataAccess
{
    public class BlogPostDAL
    {
        private readonly string connectionString;

        public BlogPostDAL()
        {
            connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        public List<BlogPost> GetAllBlogPosts()
        {
            List<BlogPost> blogPosts = new List<BlogPost>();
            
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Title, Description, Content, ImageUrl, Slug, CreatedAt, UpdatedAt, IsActive FROM BlogPosts ORDER BY CreatedAt DESC";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            blogPosts.Add(new BlogPost
                            {
                                Id = reader.GetInt32(0), // Id
                                Title = reader.GetString(1), // Title
                                Description = reader.GetString(2), // Description
                                Content = reader.IsDBNull(3) ? "" : reader.GetString(3), // Content
                                ImageUrl = reader.IsDBNull(4) ? "" : reader.GetString(4), // ImageUrl
                                Slug = reader.IsDBNull(5) ? "" : reader.GetString(5), // Slug
                                CreatedAt = reader.GetDateTime(6), // CreatedAt
                                UpdatedAt = reader.GetDateTime(7), // UpdatedAt
                                IsActive = reader.GetBoolean(8) // IsActive
                            });
                        }
                    }
                }
            }
            
            return blogPosts;
        }

        public List<BlogPost> GetActiveBlogPosts()
        {
            List<BlogPost> blogPosts = new List<BlogPost>();
            
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Title, Description, Content, ImageUrl, Slug, CreatedAt, UpdatedAt, IsActive FROM BlogPosts WHERE IsActive = 1 ORDER BY CreatedAt DESC";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            blogPosts.Add(new BlogPost
                            {
                                Id = reader.GetInt32(0), // Id
                                Title = reader.GetString(1), // Title
                                Description = reader.GetString(2), // Description
                                Content = reader.IsDBNull(3) ? "" : reader.GetString(3), // Content
                                ImageUrl = reader.IsDBNull(4) ? "" : reader.GetString(4), // ImageUrl
                                Slug = reader.IsDBNull(5) ? "" : reader.GetString(5), // Slug
                                CreatedAt = reader.GetDateTime(6), // CreatedAt
                                UpdatedAt = reader.GetDateTime(7), // UpdatedAt
                                IsActive = reader.GetBoolean(8) // IsActive
                            });
                        }
                    }
                }
            }
            
            return blogPosts;
        }

        public BlogPost GetBlogPostById(int id)
        {
            BlogPost blogPost = null;
            
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Title, Description, Content, ImageUrl, Slug, CreatedAt, UpdatedAt, IsActive FROM BlogPosts WHERE Id = @Id";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            blogPost = new BlogPost
                            {
                                Id = reader.GetInt32(0), // Id
                                Title = reader.GetString(1), // Title
                                Description = reader.GetString(2), // Description
                                Content = reader.IsDBNull(3) ? "" : reader.GetString(3), // Content
                                ImageUrl = reader.IsDBNull(4) ? "" : reader.GetString(4), // ImageUrl
                                Slug = reader.IsDBNull(5) ? "" : reader.GetString(5), // Slug
                                CreatedAt = reader.GetDateTime(6), // CreatedAt
                                UpdatedAt = reader.GetDateTime(7), // UpdatedAt
                                IsActive = reader.GetBoolean(8) // IsActive
                            };
                        }
                    }
                }
            }
            
            return blogPost;
        }

        public int InsertBlogPost(BlogPost blogPost)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO BlogPosts (Title, Description, Content, ImageUrl, Slug, CreatedAt, UpdatedAt, IsActive) 
                                VALUES (@Title, @Description, @Content, @ImageUrl, @Slug, @CreatedAt, @UpdatedAt, @IsActive);
                                SELECT SCOPE_IDENTITY();";
                
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Title", blogPost.Title);
                    command.Parameters.AddWithValue("@Description", blogPost.Description);
                    command.Parameters.AddWithValue("@Content", blogPost.Content ?? "");
                    command.Parameters.AddWithValue("@ImageUrl", blogPost.ImageUrl ?? "");
                    command.Parameters.AddWithValue("@Slug", blogPost.Slug ?? "");
                    command.Parameters.AddWithValue("@CreatedAt", DateTime.Now);
                    command.Parameters.AddWithValue("@UpdatedAt", DateTime.Now);
                    command.Parameters.AddWithValue("@IsActive", blogPost.IsActive);
                    
                    connection.Open();
                    return Convert.ToInt32(command.ExecuteScalar());
                }
            }
        }

        public bool UpdateBlogPost(BlogPost blogPost)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"UPDATE BlogPosts SET 
                                Title = @Title, 
                                Description = @Description, 
                                Content = @Content, 
                                ImageUrl = @ImageUrl, 
                                Slug = @Slug, 
                                UpdatedAt = @UpdatedAt, 
                                IsActive = @IsActive 
                                WHERE Id = @Id";
                
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", blogPost.Id);
                    command.Parameters.AddWithValue("@Title", blogPost.Title);
                    command.Parameters.AddWithValue("@Description", blogPost.Description);
                    command.Parameters.AddWithValue("@Content", blogPost.Content ?? "");
                    command.Parameters.AddWithValue("@ImageUrl", blogPost.ImageUrl ?? "");
                    command.Parameters.AddWithValue("@Slug", blogPost.Slug ?? "");
                    command.Parameters.AddWithValue("@UpdatedAt", DateTime.Now);
                    command.Parameters.AddWithValue("@IsActive", blogPost.IsActive);
                    
                    connection.Open();
                    return command.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool DeleteBlogPost(int id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM BlogPosts WHERE Id = @Id";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);
                    connection.Open();
                    return command.ExecuteNonQuery() > 0;
                }
            }
        }
    }
}