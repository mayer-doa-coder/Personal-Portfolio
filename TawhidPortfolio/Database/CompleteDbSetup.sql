-- ================================================
-- COMPLETE DATABASE FIX SCRIPT
-- This script will fix all database issues
-- ================================================

USE master;
GO

-- ================================================
-- 1. CREATE DATABASE IF NOT EXISTS
-- ================================================
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'TawhidPortfolioDB')
BEGIN
    PRINT 'Creating TawhidPortfolioDB database...'
    CREATE DATABASE TawhidPortfolioDB;
    PRINT 'Database created successfully!'
END
ELSE
BEGIN
    PRINT 'Database TawhidPortfolioDB already exists.'
END
GO

-- Switch to the database
USE TawhidPortfolioDB;
GO

-- ================================================
-- 2. CREATE OR UPDATE CONTACTMESSAGES TABLE
-- ================================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactMessages]') AND type in (N'U'))
BEGIN
    PRINT 'Creating ContactMessages table...'
    CREATE TABLE [dbo].[ContactMessages] (
        [Id] INT IDENTITY(1,1) PRIMARY KEY,
        [Name] NVARCHAR(100) NOT NULL,
        [Email] NVARCHAR(255) NOT NULL,
        [Subject] NVARCHAR(255) NOT NULL,
        [Message] NVARCHAR(MAX) NOT NULL,
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
    );
    PRINT 'ContactMessages table created successfully!'
END
ELSE
BEGIN
    PRINT 'ContactMessages table already exists.'
END
GO

-- ================================================
-- 3. CREATE OR UPDATE PROJECTS TABLE
-- ================================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Projects]') AND type in (N'U'))
BEGIN
    PRINT 'Creating Projects table...'
    CREATE TABLE [dbo].[Projects] (
        [Id] INT IDENTITY(1,1) PRIMARY KEY,
        [Title] NVARCHAR(255) NOT NULL,
        [Description] NVARCHAR(MAX) NOT NULL,
        [ImageUrl] NVARCHAR(500),
        [ProjectUrl] NVARCHAR(500),
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
        [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
        [IsActive] BIT NOT NULL DEFAULT 1
    );
    PRINT 'Projects table created successfully!'
END
ELSE
BEGIN
    PRINT 'Projects table already exists. Checking for missing columns...'
    
    -- Check and add ProjectUrl column if missing
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Projects]') AND name = 'ProjectUrl')
    BEGIN
        PRINT 'Adding ProjectUrl column to Projects table...'
        ALTER TABLE [dbo].[Projects] ADD [ProjectUrl] NVARCHAR(500);
        PRINT 'ProjectUrl column added!'
    END
    
    -- Check and add UpdatedAt column if missing
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Projects]') AND name = 'UpdatedAt')
    BEGIN
        PRINT 'Adding UpdatedAt column to Projects table...'
        ALTER TABLE [dbo].[Projects] ADD [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE();
        PRINT 'UpdatedAt column added!'
    END
    
    -- Check and add IsActive column if missing
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Projects]') AND name = 'IsActive')
    BEGIN
        PRINT 'Adding IsActive column to Projects table...'
        ALTER TABLE [dbo].[Projects] ADD [IsActive] BIT NOT NULL DEFAULT 1;
        PRINT 'IsActive column added!'
    END
END
GO

-- ================================================
-- 4. CREATE OR UPDATE BLOGPOSTS TABLE
-- ================================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BlogPosts]') AND type in (N'U'))
BEGIN
    PRINT 'Creating BlogPosts table...'
    CREATE TABLE [dbo].[BlogPosts] (
        [Id] INT IDENTITY(1,1) PRIMARY KEY,
        [Title] NVARCHAR(255) NOT NULL,
        [Description] NVARCHAR(MAX) NOT NULL,
        [Content] NVARCHAR(MAX),
        [ImageUrl] NVARCHAR(500),
        [Slug] NVARCHAR(255),
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
        [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
        [IsActive] BIT NOT NULL DEFAULT 1
    );
    PRINT 'BlogPosts table created successfully!'
END
ELSE
BEGIN
    PRINT 'BlogPosts table already exists.'
END
GO

-- ================================================
-- 5. CREATE INDEXES FOR PERFORMANCE
-- ================================================
-- Index for ContactMessages
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ContactMessages_CreatedAt' AND object_id = OBJECT_ID('[dbo].[ContactMessages]'))
BEGIN
    PRINT 'Creating index on ContactMessages...'
    CREATE NONCLUSTERED INDEX [IX_ContactMessages_CreatedAt] 
    ON [dbo].[ContactMessages] ([CreatedAt] DESC);
END

-- Index for Projects
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Projects_CreatedAt' AND object_id = OBJECT_ID('[dbo].[Projects]'))
BEGIN
    PRINT 'Creating index on Projects...'
    CREATE NONCLUSTERED INDEX [IX_Projects_CreatedAt] 
    ON [dbo].[Projects] ([CreatedAt] DESC);
END

-- Index for BlogPosts
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BlogPosts_CreatedAt' AND object_id = OBJECT_ID('[dbo].[BlogPosts]'))
BEGIN
    PRINT 'Creating index on BlogPosts...'
    CREATE NONCLUSTERED INDEX [IX_BlogPosts_CreatedAt] 
    ON [dbo].[BlogPosts] ([CreatedAt] DESC);
END
GO

-- ================================================
-- 6. INSERT SAMPLE DATA
-- ================================================

-- Sample Projects (only if table is empty)
IF NOT EXISTS (SELECT * FROM [dbo].[Projects])
BEGIN
    PRINT 'Inserting sample projects...'
    INSERT INTO [dbo].[Projects] ([Title], [Description], [ImageUrl], [ProjectUrl], [CreatedAt], [UpdatedAt], [IsActive])
    VALUES 
        ('Numerical Method Project', 'A comprehensive Numerical Method Project that focuses on applying computational techniques to solve mathematical problems that are difficult to solve analytically. This project implements various numerical algorithms and methods.', 'assets/images/numerical.png', 'https://github.com/mayer-doa-coder/Numerical-Method-Project', GETDATE(), GETDATE(), 1),
        ('Readify - Book Reading App', 'A modern Book Reading App that allows users to read, organize, and manage books conveniently on their devices. Features include bookmarking, note-taking, and reading progress tracking.', 'assets/images/readifylogo.png', 'https://github.com/mayer-doa-coder/Readify-Android-App', GETDATE(), GETDATE(), 1),
        ('Police Department Management System', 'A Console-based Project designed to manage and organize police records efficiently. This OOP-based system handles officer information, case management, and department operations.', 'assets/images/oop project.png', 'https://github.com/mayer-doa-coder/OOP-Project', GETDATE(), GETDATE(), 1),
        ('ParaBounce - Projectile Motion Simulator', 'A Physics Projectile Simulator that allows users to simulate and visualize projectile motion in a 2D environment. Features realistic physics calculations and interactive graphics.', 'assets/images/parabounce.png', 'https://github.com/mayer-doa-coder/ParaBounce-Projectile-Motion-Simulator', GETDATE(), GETDATE(), 1),
        ('Portfolio Website with Admin Panel', 'A comprehensive portfolio website built with ASP.NET Web Forms featuring a dynamic admin panel for content management. Includes project management, blog system, and contact form handling.', 'assets/images/portfolio-admin.png', 'https://github.com/mayer-doa-coder/Personal-Portfolio-Backend', GETDATE(), GETDATE(), 1);
    PRINT 'Sample projects inserted successfully!'
END
ELSE
BEGIN
    PRINT 'Projects table already contains data.'
END
GO

-- Sample Blog Posts (only if table is empty)
IF NOT EXISTS (SELECT * FROM [dbo].[BlogPosts])
BEGIN
    PRINT 'Inserting sample blog posts...'
    INSERT INTO [dbo].[BlogPosts] ([Title], [Description], [Content], [ImageUrl], [Slug], [CreatedAt], [UpdatedAt], [IsActive])
    VALUES 
        ('Getting Started with Competitive Programming', 'A comprehensive guide for beginners who want to dive into the world of competitive programming. Learn about essential algorithms, data structures, and problem-solving strategies.', 
         '<h2>Introduction to Competitive Programming</h2><p>Competitive programming is a mind sport that involves solving algorithmic problems within a time limit. It''s an excellent way to improve your programming skills and logical thinking.</p><h3>Essential Topics to Master</h3><ul><li><strong>Data Structures:</strong> Arrays, Linked Lists, Stacks, Queues, Trees, Graphs</li><li><strong>Algorithms:</strong> Sorting, Searching, Dynamic Programming, Greedy Algorithms</li><li><strong>Mathematics:</strong> Number Theory, Combinatorics, Probability</li><li><strong>Graph Theory:</strong> BFS, DFS, Shortest Path, Minimum Spanning Tree</li></ul><h3>Popular Platforms</h3><p>Start practicing on these platforms:</p><ul><li>Codeforces</li><li>AtCoder</li><li>CodeChef</li><li>LeetCode</li><li>HackerRank</li></ul><p>Remember, consistency is key. Practice regularly and participate in contests to improve your skills!</p>',
         'assets/images/blog-competitive-programming.jpg', 'getting-started-with-competitive-programming', GETDATE(), GETDATE(), 1),
        
        ('Modern Web Development Trends 2025', 'Exploring the latest trends in web development including React, TypeScript, and modern frameworks. Discover how these technologies are shaping the future of web applications.',
         '<h2>The Evolution of Web Development</h2><p>Web development has evolved significantly over the past few years. Let''s explore the key trends that are shaping the industry in 2025.</p><h3>Key Trends</h3><h4>1. TypeScript Adoption</h4><p>TypeScript has become the standard for large-scale JavaScript applications, providing better tooling and catching errors at compile time.</p><h4>2. Component-Based Architecture</h4><p>Frameworks like React, Vue, and Angular have made component-based development the norm, promoting reusability and maintainability.</p><h4>3. JAMstack Architecture</h4><p>JavaScript, APIs, and Markup (JAMstack) provides better performance, security, and scalability for modern web applications.</p><h4>4. Progressive Web Apps (PWAs)</h4><p>PWAs bridge the gap between web and mobile applications, offering native app-like experiences in the browser.</p><h3>Tools and Technologies</h3><ul><li><strong>Frontend:</strong> React, Vue.js, Angular, Svelte</li><li><strong>Backend:</strong> Node.js, Express, NestJS, Deno</li><li><strong>Database:</strong> MongoDB, PostgreSQL, Firebase</li><li><strong>Deployment:</strong> Vercel, Netlify, AWS, Docker</li></ul><p>The future of web development is exciting, with new tools and frameworks constantly emerging to solve modern challenges.</p>',
         'assets/images/blog-web-development.jpg', 'modern-web-development-trends-2025', GETDATE(), GETDATE(), 1),
        
        ('Building Scalable Systems: Best Practices', 'Learn the principles and best practices for designing and building scalable software systems. From architecture patterns to performance optimization techniques.',
         '<h2>Scalability in Software Systems</h2><p>Building scalable systems is crucial for handling growing user bases and increasing data loads. Here are the key principles and practices.</p><h3>Core Principles</h3><h4>1. Horizontal vs Vertical Scaling</h4><p><strong>Vertical Scaling:</strong> Adding more power (CPU, RAM) to existing machines.</p><p><strong>Horizontal Scaling:</strong> Adding more machines to the pool of resources.</p><h4>2. Load Distribution</h4><p>Use load balancers to distribute incoming requests across multiple servers.</p><h4>3. Caching Strategies</h4><ul><li>Browser caching</li><li>CDN (Content Delivery Network)</li><li>Database query caching</li><li>Application-level caching (Redis, Memcached)</li></ul><h3>Architecture Patterns</h3><h4>Microservices Architecture</h4><p>Break down monolithic applications into smaller, independent services that can be developed, deployed, and scaled independently.</p><h4>Event-Driven Architecture</h4><p>Use events to communicate between services, enabling loose coupling and better scalability.</p><h3>Database Scaling</h3><ul><li><strong>Read Replicas:</strong> Distribute read operations across multiple database instances</li><li><strong>Sharding:</strong> Partition data across multiple databases</li><li><strong>NoSQL:</strong> Consider NoSQL databases for specific use cases</li></ul><h3>Monitoring and Optimization</h3><p>Implement comprehensive monitoring to identify bottlenecks and optimize performance:</p><ul><li>Application Performance Monitoring (APM)</li><li>Database query optimization</li><li>Memory and CPU usage monitoring</li><li>Network latency tracking</li></ul><p>Remember, scalability should be considered from the beginning of your project, not as an afterthought.</p>',
         'assets/images/blog-scalable-systems.jpg', 'building-scalable-systems-best-practices', GETDATE(), GETDATE(), 1),
        
        ('Machine Learning for Beginners: A Practical Guide', 'An introduction to machine learning concepts and practical applications. Discover how to get started with Python libraries and build your first ML models.',
         '<h2>Introduction to Machine Learning</h2><p>Machine Learning (ML) is a subset of artificial intelligence that enables computers to learn and make decisions without being explicitly programmed.</p><h3>Types of Machine Learning</h3><h4>1. Supervised Learning</h4><p>Learning with labeled examples. Common algorithms:</p><ul><li>Linear Regression</li><li>Logistic Regression</li><li>Decision Trees</li><li>Random Forest</li><li>Support Vector Machines</li></ul><h4>2. Unsupervised Learning</h4><p>Finding patterns in data without labels:</p><ul><li>Clustering (K-means, Hierarchical)</li><li>Dimensionality Reduction (PCA)</li><li>Association Rules</li></ul><h4>3. Reinforcement Learning</h4><p>Learning through interaction with an environment, receiving rewards or penalties.</p><h3>Essential Python Libraries</h3><ul><li><strong>NumPy:</strong> Numerical computing</li><li><strong>Pandas:</strong> Data manipulation and analysis</li><li><strong>Matplotlib/Seaborn:</strong> Data visualization</li><li><strong>Scikit-learn:</strong> Machine learning algorithms</li><li><strong>TensorFlow/PyTorch:</strong> Deep learning frameworks</li></ul><h3>Your First ML Project Steps</h3><ol><li><strong>Data Collection:</strong> Gather relevant data</li><li><strong>Data Cleaning:</strong> Handle missing values, outliers</li><li><strong>Exploratory Data Analysis:</strong> Understand your data</li><li><strong>Feature Engineering:</strong> Select and create relevant features</li><li><strong>Model Selection:</strong> Choose appropriate algorithm</li><li><strong>Training:</strong> Train your model</li><li><strong>Evaluation:</strong> Assess model performance</li><li><strong>Deployment:</strong> Put your model into production</li></ol><h3>Common Applications</h3><ul><li>Image Recognition</li><li>Natural Language Processing</li><li>Recommendation Systems</li><li>Fraud Detection</li><li>Predictive Analytics</li></ul><p>Start small, practice regularly, and gradually work on more complex projects. The key to mastering ML is hands-on experience!</p>',
         'assets/images/blog-machine-learning.jpg', 'machine-learning-for-beginners-practical-guide', GETDATE(), GETDATE(), 1);
    PRINT 'Sample blog posts inserted successfully!'
END
ELSE
BEGIN
    PRINT 'BlogPosts table already contains data.'
END
GO

-- Sample Contact Messages (only if table is empty)
IF NOT EXISTS (SELECT * FROM [dbo].[ContactMessages])
BEGIN
    PRINT 'Inserting sample contact messages...'
    INSERT INTO [dbo].[ContactMessages] ([Name], [Email], [Subject], [Message], [CreatedAt])
    VALUES 
        ('John Smith', 'john.smith@example.com', 'Project Inquiry', 'Hi Tawhidul, I found your portfolio very impressive. I would like to discuss a potential collaboration opportunity.', GETDATE()),
        ('Sarah Johnson', 'sarah.j@tech-company.com', 'Job Opportunity', 'Hello, we have an exciting software developer position that might interest you. Would you be available for a call?', GETDATE()),
        ('Mike Chen', 'mike.chen@startup.io', 'Technical Question', 'I loved your blog post about scalable systems. Do you have any recommendations for implementing microservices?', GETDATE());
    PRINT 'Sample contact messages inserted successfully!'
END
ELSE
BEGIN
    PRINT 'ContactMessages table already contains data.'
END
GO

-- ================================================
-- 7. VERIFICATION QUERIES
-- ================================================
PRINT '================================================'
PRINT 'DATABASE SETUP VERIFICATION'
PRINT '================================================'

-- Check table structures
PRINT 'Checking table structures...'
SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length,
    c.is_nullable,
    c.is_identity
FROM sys.tables t
INNER JOIN sys.columns c ON t.object_id = c.object_id
INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id
WHERE t.name IN ('ContactMessages', 'Projects', 'BlogPosts')
ORDER BY t.name, c.column_id;

-- Check data counts
PRINT 'Checking data counts...'
SELECT 'ContactMessages' AS TableName, COUNT(*) AS RecordCount FROM [dbo].[ContactMessages]
UNION ALL
SELECT 'Projects' AS TableName, COUNT(*) AS RecordCount FROM [dbo].[Projects]
UNION ALL
SELECT 'BlogPosts' AS TableName, COUNT(*) AS RecordCount FROM [dbo].[BlogPosts];

PRINT '================================================'
PRINT 'DATABASE SETUP COMPLETED SUCCESSFULLY!'
PRINT '================================================'
PRINT 'You can now:'
PRINT '1. Run your ASP.NET application'
PRINT '2. Access the Admin Panel at /AdminPanel.aspx'
PRINT '3. Test the frontend at /Front_End/home.html'
PRINT '4. All database errors should be resolved!'
PRINT '================================================'