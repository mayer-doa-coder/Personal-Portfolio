using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TawhidPortfolio.Models;
using System.Security.Cryptography;
using System.Text;

namespace TawhidPortfolio.DataAccess
{
    public class AdminDAL
    {
        private readonly string connectionString;

        public AdminDAL()
        {
            connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        /// <summary>
        /// Validates admin login credentials
        /// </summary>
        public Admin ValidateLogin(string username, string password)
        {
            Admin admin = null;
            string hashedPassword = HashPassword(password);

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT Id, Username, Password, Email, LastLogin, IsActive, CreatedAt, UpdatedAt 
                                   FROM AdminUsers 
                                   WHERE Username = @Username AND Password = @Password AND IsActive = 1";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword);

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                admin = new Admin
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Username = reader["Username"].ToString(),
                                    Password = reader["Password"].ToString(),
                                    Email = reader["Email"].ToString(),
                                    LastLogin = Convert.ToDateTime(reader["LastLogin"]),
                                    IsActive = Convert.ToBoolean(reader["IsActive"]),
                                    CreatedAt = Convert.ToDateTime(reader["CreatedAt"]),
                                    UpdatedAt = Convert.ToDateTime(reader["UpdatedAt"])
                                };
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("AdminDAL ValidateLogin Error: " + ex.Message);
                throw;
            }

            return admin;
        }

        /// <summary>
        /// Updates the last login time for admin user
        /// </summary>
        public bool UpdateLastLogin(int adminId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE AdminUsers 
                                   SET LastLogin = @LastLogin, UpdatedAt = @UpdatedAt 
                                   WHERE Id = @Id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", adminId);
                        cmd.Parameters.AddWithValue("@LastLogin", DateTime.Now);
                        cmd.Parameters.AddWithValue("@UpdatedAt", DateTime.Now);

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();
                        return result > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("AdminDAL UpdateLastLogin Error: " + ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Gets admin by ID
        /// </summary>
        public Admin GetAdminById(int adminId)
        {
            Admin admin = null;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT Id, Username, Password, Email, LastLogin, IsActive, CreatedAt, UpdatedAt 
                                   FROM AdminUsers 
                                   WHERE Id = @Id AND IsActive = 1";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", adminId);

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                admin = new Admin
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Username = reader["Username"].ToString(),
                                    Password = reader["Password"].ToString(),
                                    Email = reader["Email"].ToString(),
                                    LastLogin = Convert.ToDateTime(reader["LastLogin"]),
                                    IsActive = Convert.ToBoolean(reader["IsActive"]),
                                    CreatedAt = Convert.ToDateTime(reader["CreatedAt"]),
                                    UpdatedAt = Convert.ToDateTime(reader["UpdatedAt"])
                                };
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("AdminDAL GetAdminById Error: " + ex.Message);
            }

            return admin;
        }

        /// <summary>
        /// Creates initial admin user if none exists
        /// </summary>
        public bool CreateInitialAdmin()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Check if any admin exists
                    string checkQuery = "SELECT COUNT(*) FROM AdminUsers WHERE IsActive = 1";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        conn.Open();
                        int adminCount = Convert.ToInt32(checkCmd.ExecuteScalar());
                        
                        if (adminCount > 0)
                        {
                            return true; // Admin already exists
                        }
                    }

                    // Create default admin
                    string insertQuery = @"INSERT INTO AdminUsers (Username, Password, Email, LastLogin, IsActive, CreatedAt, UpdatedAt)
                                         VALUES (@Username, @Password, @Email, @LastLogin, @IsActive, @CreatedAt, @UpdatedAt)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", "admin");
                        cmd.Parameters.AddWithValue("@Password", HashPassword("admin123"));
                        cmd.Parameters.AddWithValue("@Email", "admin@portfolio.com");
                        cmd.Parameters.AddWithValue("@LastLogin", DateTime.Now);
                        cmd.Parameters.AddWithValue("@IsActive", true);
                        cmd.Parameters.AddWithValue("@CreatedAt", DateTime.Now);
                        cmd.Parameters.AddWithValue("@UpdatedAt", DateTime.Now);

                        int result = cmd.ExecuteNonQuery();
                        return result > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("AdminDAL CreateInitialAdmin Error: " + ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Hash password using SHA256
        /// </summary>
        private string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}