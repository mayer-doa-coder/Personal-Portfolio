-- ================================================
-- ADMIN AUTHENTICATION DATABASE SETUP
-- This script adds admin authentication support
-- ================================================

USE TawhidPortfolioDB;
GO

-- ================================================
-- CREATE ADMINUSERS TABLE
-- ================================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AdminUsers]') AND type in (N'U'))
BEGIN
    PRINT 'Creating AdminUsers table...'
    CREATE TABLE [dbo].[AdminUsers] (
        [Id] INT IDENTITY(1,1) PRIMARY KEY,
        [Username] NVARCHAR(50) NOT NULL UNIQUE,
        [Password] NVARCHAR(256) NOT NULL,
        [Email] NVARCHAR(255) NOT NULL,
        [LastLogin] DATETIME NOT NULL DEFAULT GETDATE(),
        [IsActive] BIT NOT NULL DEFAULT 1,
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
        [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE()
    );
    PRINT 'AdminUsers table created successfully!'
END
ELSE
BEGIN
    PRINT 'AdminUsers table already exists.'
END
GO

-- ================================================
-- CREATE INDEXES FOR PERFORMANCE
-- ================================================
-- Index for Username (for login queries)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_AdminUsers_Username' AND object_id = OBJECT_ID('[dbo].[AdminUsers]'))
BEGIN
    PRINT 'Creating index on AdminUsers Username...'
    CREATE NONCLUSTERED INDEX [IX_AdminUsers_Username] 
    ON [dbo].[AdminUsers] ([Username]);
END

-- Index for Email
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_AdminUsers_Email' AND object_id = OBJECT_ID('[dbo].[AdminUsers]'))
BEGIN
    PRINT 'Creating index on AdminUsers Email...'
    CREATE NONCLUSTERED INDEX [IX_AdminUsers_Email] 
    ON [dbo].[AdminUsers] ([Email]);
END

-- Index for IsActive
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_AdminUsers_IsActive' AND object_id = OBJECT_ID('[dbo].[AdminUsers]'))
BEGIN
    PRINT 'Creating index on AdminUsers IsActive...'
    CREATE NONCLUSTERED INDEX [IX_AdminUsers_IsActive] 
    ON [dbo].[AdminUsers] ([IsActive]);
END
GO

-- ================================================
-- INSERT DEFAULT ADMIN USER
-- ================================================
-- Only create default admin if no users exist
IF NOT EXISTS (SELECT * FROM [dbo].[AdminUsers])
BEGIN
    PRINT 'Creating default admin user...'
    -- Password is "admin123" hashed with SHA256
    -- SHA256 hash of "admin123" = 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
    INSERT INTO [dbo].[AdminUsers] ([Username], [Password], [Email], [LastLogin], [IsActive], [CreatedAt], [UpdatedAt])
    VALUES 
        ('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'admin@portfolio.com', GETDATE(), 1, GETDATE(), GETDATE());
    
    PRINT 'Default admin user created successfully!'
    PRINT 'Login Credentials:'
    PRINT '  Username: admin'
    PRINT '  Password: admin123'
    PRINT 'IMPORTANT: Change these credentials after first login!'
END
ELSE
BEGIN
    PRINT 'Admin users already exist in the system.'
END
GO

-- ================================================
-- VERIFICATION
-- ================================================
PRINT '================================================'
PRINT 'ADMIN AUTHENTICATION SETUP VERIFICATION'
PRINT '================================================'

-- Check AdminUsers table structure
PRINT 'AdminUsers table structure:'
SELECT 
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length,
    c.is_nullable,
    c.is_identity
FROM sys.tables t
INNER JOIN sys.columns c ON t.object_id = c.object_id
INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE t.name = 'AdminUsers'
ORDER BY c.column_id;

-- Check admin users count
PRINT 'Admin users count:'
SELECT COUNT(*) AS AdminUserCount FROM [dbo].[AdminUsers] WHERE IsActive = 1;

-- Show admin users (without passwords)
PRINT 'Active admin users:'
SELECT Id, Username, Email, LastLogin, CreatedAt 
FROM [dbo].[AdminUsers] 
WHERE IsActive = 1;

PRINT '================================================'
PRINT 'ADMIN AUTHENTICATION SETUP COMPLETED!'
PRINT '================================================'
PRINT 'Next steps:'
PRINT '1. Access AdminLogin.aspx to test authentication'
PRINT '2. Use credentials: admin / admin123'
PRINT '3. Change default password after first login'
PRINT '4. All admin pages are now protected with authentication'
PRINT '================================================'
GO