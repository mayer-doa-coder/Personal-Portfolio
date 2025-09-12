# Tawhidul Hasan - Professional Portfolio

A comprehensive personal portfolio website built with ASP.NET Web Forms, featuring a dynamic administrative interface for content management and a responsive frontend showcasing professional projects, technical blogs, and achievements.

## Overview

This portfolio application serves as a complete web-based solution for professionals to showcase their work, manage content dynamically, and maintain an engaging online presence. The system combines a public-facing portfolio with a secure administrative backend for real-time content management.

## Core Features

### Public Portfolio Interface
- Fully responsive design optimized for all device types
- Professional user interface with modern design principles
- Dynamic content loading from database
- Interactive project galleries with detailed descriptions
- Technical blog system with rich content support
- Contact form integration with backend processing
- Smooth navigation and optimized user experience
- Search engine optimization (SEO) ready structure

### Administrative Management System
- Secure authentication and session management
- Project portfolio management (Create, Read, Update, Delete operations)
- Blog content management with rich text editing capabilities
- Contact message review and management system
- Real-time content updates without system downtime
- Data validation and security protocols
- Administrative dashboard with usage analytics

### Technical Implementation
- Server-side processing with ASP.NET Web Forms
- SQL Server database with optimized queries
- RESTful API endpoints for data consumption
- Cross-browser compatibility and web standards compliance
- Responsive CSS Grid and Flexbox layouts
- Modern JavaScript ES6+ implementation
- Security best practices and input validation

## Technology Stack

### Backend Technologies
- ASP.NET Web Forms (.NET Framework 4.7.2+)
- C# programming language
- SQL Server database management system
- ADO.NET for data access layer
- IIS web server deployment

### Frontend Technologies
- HTML5 semantic markup
- CSS3 with modern layout techniques
- Vanilla JavaScript (ES6+)
- Font Awesome icon library
- Responsive design principles

### Development Tools
- Microsoft Visual Studio IDE
- SQL Server Management Studio
- Git version control system
- Browser developer tools for testing

## System Requirements

### Development Environment
- Windows 10/11 operating system
- Visual Studio 2019 or later
- SQL Server 2016 or later (Express edition supported)
- .NET Framework 4.7.2 or higher
- IIS Express (included with Visual Studio)

### Production Environment
- Windows Server 2016 or later
- Internet Information Services (IIS) 8.0+
- SQL Server 2016 or later
- .NET Framework 4.7.2 runtime

## Installation Instructions

### Repository Setup
```bash
git clone https://github.com/mayer-doa-coder/TawhidPortfolio.git
cd TawhidPortfolio
```

### Database Configuration
1. Open SQL Server Management Studio
2. Connect to your SQL Server instance
3. Execute the database creation script:
   ```sql
   -- Run Database/CreateDatabase.sql
   ```
4. Populate with sample data:
   ```sql
   -- Run Database/DataRecoveryScript.sql
   ```

### Application Configuration
1. Open the solution file in Visual Studio
2. Update the connection string in Web.config:
   ```xml
   <connectionStrings>
     <add name="DefaultConnection" 
          connectionString="Server=YOUR_SERVER_NAME;Database=TawhidPortfolioDB;Integrated Security=true;" 
          providerName="System.Data.SqlClient" />
   </connectionStrings>
   ```
3. Build the solution to restore dependencies
4. Run the application using F5 or Debug menu

## Database Schema

### Projects Table Structure
```sql
CREATE TABLE Projects (
    Id int IDENTITY(1,1) PRIMARY KEY,
    Title nvarchar(255) NOT NULL,
    Description nvarchar(max),
    ImageUrl nvarchar(500),
    ProjectUrl nvarchar(500),
    CreatedAt datetime2 DEFAULT GETDATE(),
    UpdatedAt datetime2 DEFAULT GETDATE(),
    IsActive bit DEFAULT 1
);
```

### BlogPosts Table Structure
```sql
CREATE TABLE BlogPosts (
    Id int IDENTITY(1,1) PRIMARY KEY,
    Title nvarchar(255) NOT NULL,
    Description nvarchar(500),
    Content nvarchar(max),
    ImageUrl nvarchar(500),
    Slug nvarchar(255) UNIQUE,
    CreatedAt datetime2 DEFAULT GETDATE(),
    UpdatedAt datetime2 DEFAULT GETDATE(),
    IsActive bit DEFAULT 1
);
```

## API Documentation

### Projects API Endpoint
- **URL**: `/ProjectsAPI.aspx`
- **Method**: GET
- **Response**: JSON array of active projects
- **Usage**: Frontend project display and filtering

### Blogs API Endpoint
- **URL**: `/BlogsAPI.aspx`
- **Method**: GET
- **Response**: JSON array of published blog posts
- **Usage**: Dynamic blog content loading

### Contact API Endpoint
- **URL**: `/ContactAPI.aspx`
- **Method**: POST
- **Payload**: Contact form data
- **Usage**: Contact form submission processing

## Administrative Interface

### Access Credentials
Navigate to `/AdminLogin.aspx` and use configured administrative credentials.

### Available Functions
- **Dashboard**: System overview and recent activity
- **Project Management**: Add, edit, and remove portfolio projects
- **Blog Management**: Create, edit, and publish blog articles
- **Message Center**: Review and manage contact form submissions
- **Content Analytics**: View engagement and interaction statistics

## Deployment Guidelines

### IIS Deployment Process
1. Publish application from Visual Studio
2. Configure IIS application pool (.NET Framework v4.0+)
3. Create web application in IIS Manager
4. Update connection strings for production database
5. Configure appropriate file permissions
6. Test all functionality in production environment

### Security Considerations
- Implement HTTPS for all administrative functions
- Configure proper database user permissions
- Enable request validation and input sanitization
- Implement session timeout policies
- Regular security updates and patches

## Maintenance and Support

### Regular Maintenance Tasks
- Database backup and recovery procedures
- Log file monitoring and cleanup
- Performance monitoring and optimization
- Security patch management
- Content backup and archival

### Troubleshooting Common Issues
- Database connectivity problems
- Session timeout configurations
- File upload permission errors
- Cross-browser compatibility issues

## Development and Customization

### Extending Functionality
The application architecture supports easy extension through:
- Additional API endpoints for new data types
- Custom administrative modules
- Enhanced frontend components
- Integration with third-party services

### Code Organization
```
TawhidPortfolio/
├── Database/               # Database scripts and schema
├── Front_End/             # Client-side assets and pages
│   ├── assets/css/        # Stylesheets
│   ├── assets/js/         # JavaScript files
│   └── assets/images/     # Image resources
├── Models/                # Data model classes
├── DataAccess/           # Database access layer
├── Admin/                # Administrative interface pages
└── API/                  # RESTful API endpoints
```

## Contributing Guidelines

### Code Standards
- Follow Microsoft C# coding conventions
- Implement proper error handling and logging
- Write comprehensive comments for complex logic
- Maintain consistent indentation and formatting

### Pull Request Process
1. Fork the repository
2. Create feature branch from main
3. Implement changes with appropriate testing
4. Submit pull request with detailed description
5. Address code review feedback

## License and Legal

This project is distributed under the MIT License. See LICENSE file for complete terms and conditions.

## Contact Information

**Developer**: Tawhidul Hasan  
**Email**: ttawhid401@email.com  
**GitHub**: [@mayer-doa-coder](https://github.com/mayer-doa-coder)  
**LinkedIn**: [Professional Profile](https://www.linkedin.com/in/tawhidul-hasan401/)

## Version History

- **Version 1.0**: Initial release with core functionality
- **Version 1.1**: Enhanced admin panel and API improvements
- **Version 1.2**: Security updates and performance optimizations

For technical support, feature requests, or bug reports, please create an issue in the GitHub repository with detailed information about the problem or enhancement.
