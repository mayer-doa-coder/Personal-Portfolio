<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="TawhidPortfolio.AdminPanel" ValidateRequest="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Panel - Portfolio Management</title>
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

        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .admin-header {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(0, 212, 255, 0.2);
            margin-bottom: 30px;
            text-align: center;
        }

        .admin-header h1 {
            background: linear-gradient(45deg, #00d4ff, #87ceeb, #87ceeb, #6495ed, #87ceeb, #87ceeb, #00d4ff);
            background-size: 200% 200%;
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: gradientShift 3s ease-in-out infinite;
            margin-bottom: 10px;
        }

        .admin-header p {
            color: #e8ecf7;
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

        .nav-tabs {
            display: flex;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(0, 212, 255, 0.1);
            margin-bottom: 30px;
            overflow: hidden;
        }

        .nav-tab {
            flex: 1;
            padding: 15px 20px;
            background: transparent;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
            font-weight: 500;
            color: #e8ecf7;
        }

        .nav-tab:hover {
            background: rgba(0, 212, 255, 0.1);
            color: #00d4ff;
        }

        .nav-tab.active {
            background: linear-gradient(45deg, #00d4ff, #87ceeb);
            color: #0a0e27;
        }

        .nav-tab i {
            margin-right: 8px;
        }

        .tab-content {
            display: none;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(0, 212, 255, 0.1);
        }

        .tab-content.active {
            display: block;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(0, 212, 255, 0.2);
        }

        .section-header h2 {
            color: #00d4ff;
            font-size: 24px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
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

        .btn-success {
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
        }

        .btn-success:hover {
            background: linear-gradient(45deg, #20c997, #28a745);
            transform: translateY(-2px);
        }

        .btn-danger {
            background: linear-gradient(45deg, #dc3545, #fd7e14);
            color: white;
        }

        .btn-danger:hover {
            background: linear-gradient(45deg, #fd7e14, #dc3545);
            transform: translateY(-2px);
        }

        .btn-warning {
            background: linear-gradient(45deg, #ffc107, #fd7e14);
            color: #0a0e27;
        }

        .btn-warning:hover {
            background: linear-gradient(45deg, #fd7e14, #ffc107);
            transform: translateY(-2px);
        }

        .data-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.03);
            border-radius: 8px;
            overflow: hidden;
        }

        .data-grid th,
        .data-grid td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 212, 255, 0.1);
            word-wrap: break-word;
            max-width: 300px;
        }

        .data-grid th {
            background: rgba(0, 212, 255, 0.1);
            font-weight: 600;
            color: #00d4ff;
        }

        .data-grid td {
            color: #e8ecf7;
        }

        .data-grid tr:hover {
            background: rgba(0, 212, 255, 0.05);
        }

        .status-active {
            color: #28a745;
            font-weight: 600;
        }

        .status-inactive {
            color: #dc3545;
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }

        .action-buttons .btn {
            padding: 5px 10px;
            font-size: 12px;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(135deg, rgba(0, 212, 255, 0.1) 0%, rgba(135, 206, 235, 0.05) 100%);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(0, 212, 255, 0.2);
            color: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 212, 255, 0.2);
            border-color: rgba(0, 212, 255, 0.4);
        }

        .stat-card i {
            font-size: 30px;
            margin-bottom: 10px;
            color: #00d4ff;
        }

        .stat-card .number {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #00d4ff;
        }

        .stat-card .label {
            font-size: 14px;
            opacity: 0.9;
            color: #e8ecf7;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #8a9bb8;
        }

        .no-data i {
            font-size: 48px;
            margin-bottom: 15px;
            opacity: 0.5;
            color: #00d4ff;
        }

        .error-message {
            background: rgba(244, 67, 54, 0.1);
            color: #ff6b6b;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            border: 1px solid rgba(244, 67, 54, 0.3);
            backdrop-filter: blur(10px);
        }

        .success-message {
            background: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            border: 1px solid rgba(76, 175, 80, 0.3);
            backdrop-filter: blur(10px);
        }

        @media (max-width: 768px) {
            .nav-tabs {
                flex-direction: column;
            }

            .section-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .data-grid {
                font-size: 14px;
            }

            .data-grid th,
            .data-grid td {
                padding: 8px;
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="false"></asp:ScriptManager>
        
        <div class="admin-container">
            <div class="admin-header">
                <h1><i class="fas fa-cog"></i> Portfolio Admin Panel</h1>
                <p>Manage your projects, blog posts, and contact messages</p>
            </div>

            <div class="nav-tabs">
                <button type="button" class="nav-tab active" onclick="showTab('dashboard')">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </button>
                <button type="button" class="nav-tab" onclick="showTab('projects')">
                    <i class="fas fa-project-diagram"></i> Projects
                </button>
                <button type="button" class="nav-tab" onclick="showTab('blogs')">
                    <i class="fas fa-blog"></i> Blog Posts
                </button>
                <button type="button" class="nav-tab" onclick="showTab('messages')">
                    <i class="fas fa-envelope"></i> Messages
                </button>
            </div>

            <!-- Dashboard Tab -->
            <div id="dashboard" class="tab-content active">
                <div class="section-header">
                    <h2><i class="fas fa-tachometer-alt"></i> Dashboard Overview</h2>
                    <asp:Button ID="btnRefreshDashboard" runat="server" CssClass="btn btn-primary" Text="Refresh Data" OnClick="btnRefreshDashboard_Click" />
                </div>
                
                <div class="stats-container">
                    <div class="stat-card">
                        <i class="fas fa-project-diagram"></i>
                        <div class="number"><asp:Label ID="lblProjectCount" runat="server" Text="0"></asp:Label></div>
                        <div class="label">Total Projects</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-blog"></i>
                        <div class="number"><asp:Label ID="lblBlogCount" runat="server" Text="0"></asp:Label></div>
                        <div class="label">Blog Posts</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-envelope"></i>
                        <div class="number"><asp:Label ID="lblMessageCount" runat="server" Text="0"></asp:Label></div>
                        <div class="label">Contact Messages</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-eye"></i>
                        <div class="number"><asp:Label ID="lblActiveProjectCount" runat="server" Text="0"></asp:Label></div>
                        <div class="label">Total Projects</div>
                    </div>
                </div>
                
                <asp:Panel ID="pnlDashboardError" runat="server" Visible="false" CssClass="error-message">
                    <asp:Label ID="lblDashboardError" runat="server"></asp:Label>
                </asp:Panel>
            </div>

            <!-- Projects Tab -->
            <div id="projects" class="tab-content">
                <div class="section-header">
                    <h2><i class="fas fa-project-diagram"></i> Manage Projects</h2>
                    <a href="ManageProject.aspx" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Project
                    </a>
                </div>
                
                <asp:Panel ID="pnlProjectError" runat="server" Visible="false" CssClass="error-message">
                    <asp:Label ID="lblProjectError" runat="server"></asp:Label>
                </asp:Panel>
                
                <asp:GridView ID="gvProjects" runat="server" 
                    CssClass="data-grid" 
                    AutoGenerateColumns="false"
                    OnRowCommand="gvProjects_RowCommand"
                    DataKeyNames="Id"
                    EmptyDataText="No projects found. Click 'Add New Project' to create your first project.">
                    <Columns>
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Description" HeaderText="Description" HtmlEncode="false" />
                        <asp:BoundField DataField="TechStack" HeaderText="Tech Stack" />
                        <asp:BoundField DataField="CreatedAt" HeaderText="Created" DataFormatString="{0:MMM dd, yyyy}" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="action-buttons">
                                    <a href='ManageProject.aspx?id=<%# Eval("Id") %>' class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" 
                                        CssClass="btn btn-danger"
                                        CommandName="DeleteProject"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClientClick="return confirm('Are you sure you want to delete this project?');">
                                        <i class="fas fa-trash"></i> Delete
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Blog Posts Tab -->
            <div id="blogs" class="tab-content">
                <div class="section-header">
                    <h2><i class="fas fa-blog"></i> Manage Blog Posts</h2>
                    <a href="ManageBlog.aspx" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Blog Post
                    </a>
                </div>
                
                <asp:Panel ID="pnlBlogError" runat="server" Visible="false" CssClass="error-message">
                    <asp:Label ID="lblBlogError" runat="server"></asp:Label>
                </asp:Panel>
                
                <asp:GridView ID="gvBlogs" runat="server" 
                    CssClass="data-grid" 
                    AutoGenerateColumns="false"
                    OnRowCommand="gvBlogs_RowCommand"
                    DataKeyNames="Id"
                    EmptyDataText="No blog posts found. Click 'Add New Blog Post' to create your first blog post.">
                    <Columns>
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Content" HeaderText="Content" HtmlEncode="false" />
                        <asp:BoundField DataField="CreatedAt" HeaderText="Created" DataFormatString="{0:MMM dd, yyyy}" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="action-buttons">
                                    <a href='ManageBlog.aspx?id=<%# Eval("Id") %>' class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" 
                                        CssClass="btn btn-danger"
                                        CommandName="DeleteBlog"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClientClick="return confirm('Are you sure you want to delete this blog post?');">
                                        <i class="fas fa-trash"></i> Delete
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Messages Tab -->
            <div id="messages" class="tab-content">
                <div class="section-header">
                    <h2><i class="fas fa-envelope"></i> Contact Messages</h2>
                    <asp:Button ID="btnRefreshMessages" runat="server" 
                        CssClass="btn btn-primary" 
                        Text="Refresh" 
                        OnClick="btnRefreshMessages_Click" />
                </div>
                
                <asp:Panel ID="pnlMessageError" runat="server" Visible="false" CssClass="error-message">
                    <asp:Label ID="lblMessageError" runat="server"></asp:Label>
                </asp:Panel>
                
                <asp:GridView ID="gvMessages" runat="server" 
                    CssClass="data-grid" 
                    AutoGenerateColumns="false"
                    OnRowCommand="gvMessages_RowCommand"
                    DataKeyNames="Id"
                    EmptyDataText="No messages found. Contact messages will appear here when visitors use your contact form.">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Subject" HeaderText="Subject" />
                        <asp:BoundField DataField="Message" HeaderText="Message" HtmlEncode="false" />
                        <asp:BoundField DataField="CreatedAt" HeaderText="Received" DataFormatString="{0:MMM dd, yyyy HH:mm}" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDeleteMessage" runat="server" 
                                    CssClass="btn btn-danger"
                                    CommandName="DeleteMessage"
                                    CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this message?');">
                                    <i class="fas fa-trash"></i> Delete
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>

    <script>
        function showTab(tabName) {
            // Hide all tab contents
            var tabs = document.querySelectorAll('.tab-content');
            tabs.forEach(function(tab) {
                tab.classList.remove('active');
            });

            // Remove active class from all nav tabs
            var navTabs = document.querySelectorAll('.nav-tab');
            navTabs.forEach(function(navTab) {
                navTab.classList.remove('active');
            });

            // Show selected tab content
            document.getElementById(tabName).classList.add('active');

            // Add active class to clicked nav tab
            event.target.classList.add('active');
        }
    </script>
</body>
</html>