<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TawhidPortfolio.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tawhidul Hasan - Portfolio Backend</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .info-section {
            background-color: #e8f5e8;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .endpoint-info {
            background-color: #f0f8ff;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            border-left: 4px solid #4CAF50;
        }
        .code {
            background-color: #f4f4f4;
            padding: 10px;
            border-radius: 3px;
            font-family: 'Courier New', monospace;
            margin: 10px 0;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
        .status {
            padding: 10px;
            margin: 10px 0;
            border-radius: 3px;
        }
        .status.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .status.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Tawhidul Hasan Portfolio - Backend API</h1>
            
            <div class="info-section">
                <h3>Backend Status</h3>
                <asp:Label ID="lblStatus" runat="server" CssClass="status"></asp:Label>
            </div>
            
            <div class="endpoint-info">
                <h3>Available Endpoints:</h3>
                <p><strong>Contact Form API:</strong></p>
                <div class="code">POST: /ContactAPI.aspx</div>
                <p>Use this endpoint to submit contact form data from your frontend.</p>
                
                <p><strong>Admin Panel:</strong></p>
                <div class="code"><a href="AdminMessages.aspx">View Contact Messages</a></div>
                <p>Access the admin panel to view and manage submitted contact messages.</p>
            </div>
            
            <div class="endpoint-info">
                <h3>Frontend Integration:</h3>
                <p>Update your JavaScript fetch request to point to:</p>
                <div class="code">
                    fetch('/ContactAPI.aspx', {<br/>
                    &nbsp;&nbsp;method: 'POST',<br/>
                    &nbsp;&nbsp;headers: { 'Content-Type': 'application/x-www-form-urlencoded' },<br/>
                    &nbsp;&nbsp;body: formData<br/>
                    })
                </div>
            </div>
            
            <div class="info-section">
                <h3>Database Connection Test:</h3>
                <asp:Button ID="btnTestConnection" runat="server" Text="Test Database Connection" OnClick="btnTestConnection_Click" />
                <asp:Label ID="lblConnectionTest" runat="server"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>