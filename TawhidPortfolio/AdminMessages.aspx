<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminMessages.aspx.cs" Inherits="TawhidPortfolio.AdminMessages" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Messages - Admin Panel</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .messages-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .messages-grid th {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }
        .messages-grid td {
            padding: 12px;
            border: 1px solid #ddd;
            vertical-align: top;
        }
        .messages-grid tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .messages-grid tr:hover {
            background-color: #f5f5f5;
        }
        .message-content {
            max-width: 300px;
            word-wrap: break-word;
        }
        .no-messages {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }
        .stats {
            background-color: #e8f5e8;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .refresh-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
        }
        .refresh-btn:hover {
            background-color: #45a049;
        }
        .delete-btn {
            background-color: #f44336;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
        }
        .delete-btn:hover {
            background-color: #da190b;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Contact Messages Admin Panel</h1>
            
            <div class="stats">
                <strong>Total Messages: <asp:Label ID="lblTotalMessages" runat="server" Text="0"></asp:Label></strong>
            </div>
            
            <asp:Button ID="btnRefresh" runat="server" Text="Refresh Messages" CssClass="refresh-btn" OnClick="btnRefresh_Click" />
            
            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label>
            
            <asp:GridView ID="gvMessages" runat="server" CssClass="messages-grid" 
                          AutoGenerateColumns="false" 
                          OnRowCommand="gvMessages_RowCommand"
                          EmptyDataText="No messages found.">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="50px" />
                    <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-Width="150px" />
                    <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-Width="200px" />
                    <asp:BoundField DataField="Subject" HeaderText="Subject" ItemStyle-Width="200px" />
                    <asp:TemplateField HeaderText="Message" ItemStyle-Width="300px">
                        <ItemTemplate>
                            <div class="message-content">
                                <%# Eval("Message") %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" ItemStyle-Width="130px" />
                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="80px">
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" 
                                      Text="Delete" 
                                      CssClass="delete-btn"
                                      CommandName="DeleteMessage" 
                                      CommandArgument='<%# Eval("Id") %>'
                                      OnClientClick="return confirm('Are you sure you want to delete this message?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="no-messages">
                        No contact messages found.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </form>
</body>
</html>