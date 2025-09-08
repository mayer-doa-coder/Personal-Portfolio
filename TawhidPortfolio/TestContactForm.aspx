<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestContactForm.aspx.cs" Inherits="TawhidPortfolio.TestContactForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Form Test Page</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
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
        .test-section {
            background-color: #f0f8ff;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            border-left: 4px solid #4CAF50;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
            margin: 20px 0;
        }
        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
        }
        .form-input {
            flex: 1;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-input.full-width {
            width: 100%;
        }
        .form-textarea {
            width: 100%;
            min-height: 120px;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
            font-size: 14px;
            font-family: Arial, sans-serif;
        }
        .btn-test {
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin: 10px 5px;
        }
        .btn-test:hover {
            background-color: #45a049;
        }
        .btn-test:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .status {
            padding: 15px;
            margin: 15px 0;
            border-radius: 4px;
            font-weight: bold;
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
        .status.info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        .links {
            text-align: center;
            margin: 30px 0;
        }
        .links a {
            color: #4CAF50;
            text-decoration: none;
            margin: 0 15px;
            padding: 10px 20px;
            border: 2px solid #4CAF50;
            border-radius: 4px;
            display: inline-block;
        }
        .links a:hover {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Contact Form Integration Test</h1>
            
            <div class="test-section">
                <h3>?? Backend System Status</h3>
                <asp:Button ID="btnTestSystem" runat="server" Text="Test All Systems" CssClass="btn-test" OnClick="btnTestSystem_Click" />
                <asp:Label ID="lblSystemStatus" runat="server"></asp:Label>
            </div>

            <div class="test-section">
                <h3>?? Contact Form Test</h3>
                <p>Use this form to test the contact form submission before integrating with your frontend:</p>
                
                <div class="form-container">
                    <div class="form-row">
                        <asp:TextBox ID="txtName" runat="server" placeholder="Your Name" CssClass="form-input" />
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Your Email" CssClass="form-input" TextMode="Email" />
                    </div>
                    <asp:TextBox ID="txtSubject" runat="server" placeholder="Subject" CssClass="form-input full-width" style="margin-bottom: 15px;" />
                    <asp:TextBox ID="txtMessage" runat="server" placeholder="Your message here..." CssClass="form-textarea" TextMode="MultiLine" />
                    
                    <asp:Button ID="btnSubmitTest" runat="server" Text="Submit Test Message" CssClass="btn-test" OnClick="btnSubmitTest_Click" />
                    <asp:Label ID="lblSubmissionResult" runat="server"></asp:Label>
                </div>
            </div>

            <div class="test-section">
                <h3>?? Quick Links</h3>
                <div class="links">
                    <a href="Default.aspx">Backend Info</a>
                    <a href="AdminMessages.aspx">View Messages</a>
                    <a href="Front_End/home.html" target="_blank">Frontend Portfolio</a>
                </div>
            </div>

            <div class="test-section">
                <h3>?? Integration Steps</h3>
                <ol>
                    <li><strong>Test Backend:</strong> Click "Test All Systems" above</li>
                    <li><strong>Test Form:</strong> Fill out and submit the test form above</li>
                    <li><strong>Check Database:</strong> View the message in <a href="AdminMessages.aspx">Admin Panel</a></li>
                    <li><strong>Test Frontend:</strong> Go to your <a href="Front_End/home.html" target="_blank">portfolio page</a> and test the contact form</li>
                </ol>
            </div>

            <div class="test-section">
                <h3>?? Configuration Check</h3>
                <asp:Button ID="btnCheckConfig" runat="server" Text="Check Configuration" CssClass="btn-test" OnClick="btnCheckConfig_Click" />
                <asp:Label ID="lblConfigCheck" runat="server"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>