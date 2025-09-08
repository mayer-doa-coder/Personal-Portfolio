<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quick Database Test</title>
</head>
<body>
    <h2>Database Connection Test</h2>
    <%
        try
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            Response.Write("<p><strong>Connection String:</strong> " + connectionString + "</p>");
            
            using (var connection = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                connection.Open();
                Response.Write("<p style='color: green;'>? Database connection successful!</p>");
                
                // Test if table exists
                var command = new System.Data.SqlClient.SqlCommand("SELECT COUNT(*) FROM ContactMessages", connection);
                int count = (int)command.ExecuteScalar();
                Response.Write("<p style='color: green;'>? ContactMessages table found with " + count + " records.</p>");
            }
        }
        catch (Exception ex)
        {
            Response.Write("<p style='color: red;'>? Database error: " + ex.Message + "</p>");
            Response.Write("<p style='color: red;'>Stack trace: " + ex.StackTrace + "</p>");
        }
    %>
</body>
</html>