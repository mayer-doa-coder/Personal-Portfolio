using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TawhidPortfolio.Models;

namespace TawhidPortfolio.DataAccess
{
    public class BlogDAL
    {
        private readonly string connectionString;

        public BlogDAL()
        {
            connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        public List<Blog> GetAllBlogs()
        {
            List<Blog> blogs = new List<Blog>();
            
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Title, Content, ImageUrl, CreatedAt FROM Blogs ORDER BY CreatedAt DESC";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            blogs.Add(new Blog
                            {
                                Id = reader.GetInt32(0), // Id
                                Title = reader.GetString(1), // Title
                                Content = reader.GetString(2), // Content
                                ImageUrl = reader.IsDBNull(3) ? "" : reader.GetString(3), // ImageUrl
                                CreatedAt = reader.GetDateTime(4) // CreatedAt
                            });
                        }
                    }
                }
            }
            
            return blogs;
        }

        public List<Blog> GetActiveBlogs()
        {
            // Since there's no IsActive column, return all blogs
            return GetAllBlogs();
        }

        public Blog GetBlogById(int id)
        {
            Blog blog = null;
            
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Title, Content, ImageUrl, CreatedAt FROM Blogs WHERE Id = @Id";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            blog = new Blog
                            {
                                Id = reader.GetInt32(0), // Id
                                Title = reader.GetString(1), // Title
                                Content = reader.GetString(2), // Content
                                ImageUrl = reader.IsDBNull(3) ? "" : reader.GetString(3), // ImageUrl
                                CreatedAt = reader.GetDateTime(4) // CreatedAt
                            };
                        }
                    }
                }
            }
            
            return blog;
        }

        public int InsertBlog(Blog blog)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Blogs (Title, Content, ImageUrl, CreatedAt) 
                                VALUES (@Title, @Content, @ImageUrl, @CreatedAt);
                                SELECT SCOPE_IDENTITY();";
                
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Title", blog.Title);
                    command.Parameters.AddWithValue("@Content", blog.Content ?? "");
                    command.Parameters.AddWithValue("@ImageUrl", blog.ImageUrl ?? "");
                    command.Parameters.AddWithValue("@CreatedAt", DateTime.Now);
                    
                    connection.Open();
                    return Convert.ToInt32(command.ExecuteScalar());
                }
            }
        }

        public bool UpdateBlog(Blog blog)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"UPDATE Blogs SET 
                                Title = @Title, 
                                Content = @Content, 
                                ImageUrl = @ImageUrl
                                WHERE Id = @Id";
                
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", blog.Id);
                    command.Parameters.AddWithValue("@Title", blog.Title);
                    command.Parameters.AddWithValue("@Content", blog.Content ?? "");
                    command.Parameters.AddWithValue("@ImageUrl", blog.ImageUrl ?? "");
                    
                    connection.Open();
                    return command.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool DeleteBlog(int id)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Blogs WHERE Id = @Id";
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