# ?? How to Verify Messages in SQL Server Management Studio (SSMS)

## Method 1: Quick Check Query
```sql
-- Open a new query window in SSMS and run this:
USE TawhidPortfolioDB;
SELECT * FROM ContactMessages ORDER BY CreatedAt DESC;
```

## Method 2: Count Messages
```sql
-- Check total number of messages
USE TawhidPortfolioDB;
SELECT COUNT(*) as TotalMessages FROM ContactMessages;
```

## Method 3: Check Recent Messages (Last 24 hours)
```sql
-- See only recent messages
USE TawhidPortfolioDB;
SELECT 
    Id,
    Name,
    Email,
    Subject,
    LEFT(Message, 50) + '...' as MessagePreview,
    CreatedAt
FROM ContactMessages 
WHERE CreatedAt >= DATEADD(day, -1, GETDATE())
ORDER BY CreatedAt DESC;
```

## Method 4: Watch for New Messages (Refresh Query)
```sql
-- Use this query and press F5 to refresh after submitting forms
USE TawhidPortfolioDB;
SELECT 
    'Message #' + CAST(Id as VARCHAR) as MessageID,
    Name,
    Email,
    Subject,
    CreatedAt,
    CASE 
        WHEN Subject LIKE '[TEST]%' THEN 'Test Message'
        ELSE 'Real Message'
    END as MessageType
FROM ContactMessages 
ORDER BY Id DESC;
```

## Step-by-Step Instructions:

### 1. Open SSMS
- Launch SQL Server Management Studio
- Connect to your SQL Server instance

### 2. Open New Query Window
- Click "New Query" button (or Ctrl+N)
- Make sure you're connected to the right server

### 3. Run Verification Query
- Copy and paste one of the queries above
- Press F5 or click "Execute"

### 4. Real-Time Testing
- Keep the query window open
- Submit a message from your form
- Press F5 to refresh the query results
- New message should appear at the top

## ?? Quick Test Process:
1. Run the count query: `SELECT COUNT(*) FROM ContactMessages;`
2. Note the current count
3. Submit a message from your form
4. Run the count query again
5. Count should increase by 1
6. Run the full query to see the new message details