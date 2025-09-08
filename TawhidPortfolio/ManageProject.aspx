<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageProject.aspx.cs" Inherits="TawhidPortfolio.ManageProject" ValidateRequest="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Project</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgb(10, 14, 39) 0%, rgb(20, 10, 40) 30%, rgb(25, 15, 45) 50%, rgb(20, 10, 40) 70%, rgb(10, 14, 39) 100%);
            background-attachment: fixed;
            min-height: 100vh;
            padding: 20px;
            color: #fff;
        }

        /* Elegant background overlay to match portfolio */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20% 80%, rgba(0, 212, 255, 0.03) 0%, transparent 50%), radial-gradient(circle at 80% 20%, rgba(135, 206, 235, 0.03) 0%, transparent 50%), radial-gradient(circle at 40% 40%, rgba(0, 212, 255, 0.02) 0%, transparent 50%);
            pointer-events: none;
            z-index: -1;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(0, 212, 255, 0.2);
            padding: 30px;
            transition: all 0.3s ease;
        }

        .container:hover {
            box-shadow: 0 10px 30px rgba(0, 212, 255, 0.2);
            border-color: rgba(0, 212, 255, 0.4);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(0, 212, 255, 0.2);
        }

        .header h1 {
            background: linear-gradient(45deg, #00d4ff, #87ceeb, #87ceeb, #6495ed, #87ceeb, #87ceeb, #00d4ff);
            background-size: 200% 200%;
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: gradientShift 3s ease-in-out infinite;
            margin-bottom: 10px;
        }

        @keyframes gradientShift {
            0% {
                background-position: 0% 50%;
            }

            50% {
                background-position: 100% 50%;
            }

            100% {
                background-position: 0% 50%;
            }
        }

        .back-link {
            display: inline-block;
            color: #87ceeb;
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 12px;
            border-radius: 5px;
            border: 1px solid rgba(135, 206, 235, 0.3);
        }

        .back-link:hover {
            color: #00d4ff;
            background: rgba(0, 212, 255, 0.1);
            border-color: rgba(0, 212, 255, 0.5);
            transform: translateY(-2px);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #00d4ff;
            font-size: 14px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid rgba(0, 212, 255, 0.3);
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.08);
            color: #e8ecf7;
            backdrop-filter: blur(5px);
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #00d4ff;
            background: rgba(0, 212, 255, 0.08);
            box-shadow: 0 0 0 3px rgba(0, 212, 255, 0.1);
            transform: translateY(-1px);
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: #8a9bb8;
            font-size: 13px;
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
            font-family: inherit;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #00d4ff, #87ceeb);
            color: #0a0e27;
            border: 2px solid transparent;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #87ceeb, #00d4ff);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 212, 255, 0.3);
        }

        .btn-secondary {
            background: rgba(108, 117, 125, 0.2);
            color: #e8ecf7;
            border: 2px solid rgba(108, 117, 125, 0.5);
        }

        .btn-secondary:hover {
            background: rgba(108, 117, 125, 0.4);
            border-color: rgba(108, 117, 125, 0.8);
            transform: translateY(-2px);
        }

        .form-actions {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid rgba(0, 212, 255, 0.2);
        }

        .required {
            color: #ff6b6b;
            font-weight: bold;
        }

        .error-message {
            background: rgba(244, 67, 54, 0.1);
            color: #ff6b6b;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            border: 1px solid rgba(244, 67, 54, 0.3);
            backdrop-filter: blur(10px);
        }

        .success-message {
            background: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            border: 1px solid rgba(76, 175, 80, 0.3);
            backdrop-filter: blur(10px);
        }

        .text-danger {
            color: #ff6b6b !important;
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                padding: 20px;
            }

            .header h1 {
                font-size: 1.8rem;
            }

            .btn {
                width: 100%;
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <a href="AdminPanel.aspx" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Admin Panel
            </a>

            <div class="header">
                <h1>
                    <i class="fas fa-project-diagram"></i>
                    <asp:Literal ID="litPageTitle" runat="server" Text="Add New Project"></asp:Literal>
                </h1>
            </div>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="error-message">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="success-message">
                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
            </asp:Panel>

            <div class="form-group">
                <label for="txtTitle">Project Title <span class="required">*</span></label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Enter project title"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" 
                    ControlToValidate="txtTitle" 
                    ErrorMessage="Project title is required" 
                    Display="Dynamic"
                    CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtDescription">Description <span class="required">*</span></label>
                <asp:TextBox ID="txtDescription" runat="server" 
                    TextMode="MultiLine" 
                    CssClass="form-control" 
                    placeholder="Enter project description"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" 
                    ControlToValidate="txtDescription" 
                    ErrorMessage="Project description is required" 
                    Display="Dynamic"
                    CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtTechStack">Tech Stack <span class="required">*</span></label>
                <asp:TextBox ID="txtTechStack" runat="server" 
                    CssClass="form-control" 
                    placeholder="e.g., Python, NumPy, Matplotlib, Jupyter"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTechStack" runat="server" 
                    ControlToValidate="txtTechStack" 
                    ErrorMessage="Tech stack is required" 
                    Display="Dynamic"
                    CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtImageUrl">Image URL</label>
                <asp:TextBox ID="txtImageUrl" runat="server" 
                    CssClass="form-control" 
                    placeholder="Enter image URL (e.g., assets/images/project.png)"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtProjectLink">Project URL</label>
                <asp:TextBox ID="txtProjectLink" runat="server" 
                    CssClass="form-control" 
                    placeholder="Enter project URL (e.g., GitHub repository link)"></asp:TextBox>
            </div>

            <div class="form-actions">
                <asp:Button ID="btnSave" runat="server" 
                    CssClass="btn btn-primary" 
                    Text="Save Project" 
                    OnClick="btnSave_Click" />
                <a href="AdminPanel.aspx" class="btn btn-secondary">Cancel</a>
            </div>
        </div>
    </form>
</body>
</html>