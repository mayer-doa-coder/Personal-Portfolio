# ASP.NET Web Forms Backend Setup Instructions

## Prerequisites
- Visual Studio 2019/2022 or Visual Studio Code
- SQL Server (LocalDB, Express, or Full version)
- SQL Server Management Studio (SSMS)
- .NET Framework 4.8

## Database Setup

### Step 1: Create Database
1. Open SQL Server Management Studio (SSMS)
2. Connect to your SQL Server instance
3. Open the script file: `TawhidPortfolio\Database\CreateDatabase.sql`
4. Execute the script to create the database and table

### Step 2: Update Connection String
1. Open `Web.config` in the TawhidPortfolio project
2. Update the connection string to match your SQL Server configuration:

```xml
<connectionStrings>
    <add name="DefaultConnection" 
         connectionString="Data Source=YOUR_SERVER_NAME;Initial Catalog=TawhidPortfolioDB;Integrated Security=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

**Common connection string examples:**
- **LocalDB**: `Data Source=(LocalDB)\MSSQLLocalDB;Initial Catalog=TawhidPortfolioDB;Integrated Security=True`
- **SQL Server Express**: `Data Source=.\SQLEXPRESS;Initial Catalog=TawhidPortfolioDB;Integrated Security=True`
- **Full SQL Server**: `Data Source=localhost;Initial Catalog=TawhidPortfolioDB;Integrated Security=True`
- **With SQL Authentication**: `Data Source=localhost;Initial Catalog=TawhidPortfolioDB;User Id=your_username;Password=your_password`

## Project Setup

### Step 1: Build the Project
1. Open the solution in Visual Studio
2. Restore NuGet packages (right-click solution ? Restore NuGet Packages)
3. Build the solution (Build ? Build Solution or Ctrl+Shift+B)

### Step 2: Test Database Connection
1. Run the project (F5 or Ctrl+F5)
2. Navigate to the default page
3. Click "Test Database Connection" button
4. Verify the connection is successful

## Frontend Integration

### Step 1: Update HTML Form
Your existing contact form in `Front_End\home.html` should work as-is. The JavaScript has been updated to point to the ASP.NET backend.

### Step 2: Serve Frontend Files
You have several options to serve your frontend:

**Option A: Copy frontend to ASP.NET project**
1. Copy your `Front_End` folder contents to the root of the TawhidPortfolio project
2. Access via: `http://localhost:port/home.html`

**Option B: Use IIS Express for frontend (Recommended)**
1. Create a separate IIS Express site for your frontend
2. Update the ContactAPI.aspx to allow CORS (already implemented)
3. Update the fetch URL in your JavaScript to include the full backend URL

**Option C: Use Live Server (VS Code)**
1. Install Live Server extension in VS Code
2. Right-click on home.html and select "Open with Live Server"
3. Update the fetch URL to point to your ASP.NET backend

### Step 3: Update JavaScript Fetch URL (if using separate frontend server)
If your frontend is running on a different port/server than your backend, update the fetch URL in script.js:

```javascript
// Change this line in handleContactFormSubmission function:
fetch('/ContactAPI.aspx', {
    
// To this (replace with your actual backend URL):
fetch('http://localhost:YOUR_BACKEND_PORT/ContactAPI.aspx', {
```

## Testing the Integration

### Step 1: Test Contact Form
1. Navigate to your frontend page
2. Fill out the contact form
3. Submit the form
4. Verify you see a success message

### Step 2: Verify Database Storage
1. Navigate to `http://localhost:port/AdminMessages.aspx`
2. Verify your submitted message appears in the admin panel
3. Or check directly in SSMS: `SELECT * FROM ContactMessages`

## Admin Panel Access

Navigate to: `http://localhost:port/AdminMessages.aspx`

Features:
- View all contact messages
- Delete individual messages
- See total message count
- Refresh messages list

## Project Structure

```
TawhidPortfolio/
??? ContactAPI.aspx              # API endpoint for form submissions
??? ContactAPI.aspx.cs           # Backend logic for API
??? AdminMessages.aspx           # Admin panel UI
??? AdminMessages.aspx.cs        # Admin panel logic
??? Default.aspx                 # Default page with info and testing
??? Default.aspx.cs              # Default page logic
??? Web.config                   # Configuration file
??? Models/
?   ??? ContactMessage.cs        # Data model
??? DataAccess/
?   ??? ContactMessageDAL.cs     # Database access layer
??? Database/
?   ??? CreateDatabase.sql       # Database setup script
??? Front_End/                   # Your existing frontend files
    ??? home.html
    ??? assets/
    ?   ??? css/style.css
    ?   ??? js/script.js
    ??? ...
```

## Troubleshooting

### Common Issues:

1. **Database Connection Failed**
   - Verify SQL Server is running
   - Check connection string
   - Ensure database exists
   - Check Windows Authentication/SQL Authentication

2. **CORS Errors (if frontend and backend on different ports)**
   - ContactAPI.aspx already includes CORS headers
   - Make sure to include full URL in fetch request

3. **Form Submission Not Working**
   - Check browser console for JavaScript errors
   - Verify form field names match expected values
   - Check network tab in browser dev tools

4. **Admin Panel Not Loading**
   - Verify database connection
   - Check that ContactMessages table exists
   - Look at browser console for errors

### Debugging Steps:
1. Check browser console for JavaScript errors
2. Check Visual Studio output window for compilation errors
3. Use browser network tab to inspect API requests/responses
4. Check IIS Express logs if needed

## Security Considerations (For Production)

1. **Add Authentication to Admin Panel**
   - Implement login functionality
   - Add authorization checks

2. **Input Validation**
   - Server-side validation is implemented
   - Consider adding more robust email validation
   - Add CAPTCHA for spam protection

3. **SQL Injection Protection**
   - Parameterized queries are used (already implemented)

4. **HTTPS**
   - Use HTTPS in production
   - Update connection strings accordingly

5. **Error Handling**
   - Implement proper logging
   - Don't expose sensitive information in error messages

## Support

If you encounter any issues:
1. Check the troubleshooting section above
2. Verify all prerequisites are installed
3. Ensure database is properly configured
4. Check Visual Studio error list and output windows