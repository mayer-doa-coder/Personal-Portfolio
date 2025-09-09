<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="TawhidPortfolio.AdminLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login - Portfolio Management</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            padding: 20px;
        }

        /* Elegant background overlay */
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

        .login-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(0, 212, 255, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .login-container:hover {
            border-color: rgba(0, 212, 255, 0.4);
            box-shadow: 0 12px 40px rgba(0, 212, 255, 0.2);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h1 {
            background: linear-gradient(45deg, #00d4ff, #87ceeb, #87ceeb, #6495ed, #87ceeb, #87ceeb, #00d4ff);
            background-size: 200% 200%;
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: gradientShift 3s ease-in-out infinite;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .login-header p {
            color: #8a9bb8;
            font-size: 14px;
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

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #00d4ff;
            font-weight: 500;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 15px 20px;
            padding-left: 50px;
            border: 1px solid rgba(0, 212, 255, 0.3);
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.08);
            color: #e8ecf7;
            font-size: 14px;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .form-group input:focus {
            outline: none;
            border-color: #00d4ff;
            background: rgba(0, 212, 255, 0.08);
            box-shadow: 0 0 0 3px rgba(0, 212, 255, 0.1);
            transform: translateY(-1px);
        }

        .form-group input::placeholder {
            color: #8a9bb8;
        }

        .form-icon {
            position: absolute;
            left: 18px;
            top: 38px;
            color: #87ceeb;
            font-size: 16px;
            z-index: 1;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            font-size: 13px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #e8ecf7;
        }

        .remember-me input[type="checkbox"] {
            width: auto;
            margin: 0;
            accent-color: #00d4ff;
        }

        .forgot-password {
            color: #87ceeb;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .forgot-password:hover {
            color: #00d4ff;
            text-decoration: underline;
        }

        .login-button {
            width: 100%;
            padding: 15px;
            background: linear-gradient(45deg, #00d4ff, #87ceeb);
            color: #0a0e27;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .login-button:hover {
            background: linear-gradient(45deg, #87ceeb, #00d4ff);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 212, 255, 0.3);
        }

        .login-button:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
        }

        .error-message {
            background: rgba(244, 67, 54, 0.1);
            color: #ff6b6b;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(244, 67, 54, 0.3);
            backdrop-filter: blur(10px);
            font-size: 14px;
            text-align: center;
        }

        .success-message {
            background: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(76, 175, 80, 0.3);
            backdrop-filter: blur(10px);
            font-size: 14px;
            text-align: center;
        }

        .back-to-home {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid rgba(0, 212, 255, 0.2);
        }

        .back-to-home a {
            color: #87ceeb;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .back-to-home a:hover {
            color: #00d4ff;
            text-decoration: underline;
        }

        .loading {
            position: relative;
            color: transparent;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 20px;
            height: 20px;
            border: 2px solid #0a0e27;
            border-top: 2px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }

        .default-credentials {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(0, 212, 255, 0.2);
            border-radius: 8px;
            padding: 15px;
            margin-top: 20px;
            font-size: 12px;
            text-align: center;
        }

        .default-credentials h4 {
            color: #00d4ff;
            margin-bottom: 8px;
            font-size: 13px;
        }

        .default-credentials p {
            color: #8a9bb8;
            margin: 2px 0;
        }

        @media (max-width: 768px) {
            .login-container {
                padding: 30px 20px;
                margin: 10px;
            }

            .login-header h1 {
                font-size: 1.6rem;
            }

            .remember-forgot {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-header">
                <h1><i class="fas fa-shield-alt"></i> Admin Login</h1>
                <p>Secure access to portfolio management</p>
            </div>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="error-message">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="success-message">
                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
            </asp:Panel>

            <div class="form-group">
                <label for="txtUsername">Username</label>
                <div class="form-icon">
                    <i class="fas fa-user"></i>
                </div>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter your username" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                    ControlToValidate="txtUsername" 
                    ErrorMessage="Username is required" 
                    Display="Dynamic"
                    CssClass="error-message"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtPassword">Password</label>
                <div class="form-icon">
                    <i class="fas fa-lock"></i>
                </div>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" 
                    Display="Dynamic"
                    CssClass="error-message"></asp:RequiredFieldValidator>
            </div>

            <div class="remember-forgot">
                <div class="remember-me">
                    <asp:CheckBox ID="chkRememberMe" runat="server" />
                    <label for="<%= chkRememberMe.ClientID %>">Remember me for 7 days</label>
                </div>
            </div>

            <asp:Button ID="btnLogin" runat="server" 
                Text="Login to Admin Panel" 
                CssClass="login-button" 
                OnClick="btnLogin_Click" />

            <div class="back-to-home">
                <a href="../Front_End/home.html">
                    <i class="fas fa-arrow-left"></i> Back to Portfolio
                </a>
            </div>

            <div class="default-credentials">
                <h4><i class="fas fa-info-circle"></i> Default Login Credentials</h4>
                <p><strong>Username:</strong> admin</p>
                <p><strong>Password:</strong> admin123</p>
                <p style="color: #ff6b6b; margin-top: 8px; font-size: 11px;">
                    <i class="fas fa-exclamation-triangle"></i> Change these credentials after first login
                </p>
            </div>
        </div>
    </form>
</body>
</html>