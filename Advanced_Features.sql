-- View for Overdue Books
CREATE VIEW OverdueBooks AS
SELECT 
    i.IssueID, 
    m.Name AS MemberName, 
    b.Title AS BookTitle, 
    i.IssueDate, 
    CURDATE() AS Today,
    DATEDIFF(CURDATE(), i.IssueDate) AS DaysOverdue
FROM IssuedBooks i
JOIN Books b ON i.BookID = b.BookID
JOIN Members m ON i.MemberID = m.MemberID
WHERE i.ReturnDate IS NULL AND i.IssueDate < CURDATE() - INTERVAL 15 DAY;

 -- Trigger to Reduce Book Quantity

DELIMITER //

CREATE TRIGGER after_book_issued
AFTER INSERT ON IssuedBooks
FOR EACH ROW
BEGIN
   UPDATE Books
   SET Quantity = Quantity - 1
   WHERE BookID = NEW.BookID;
END;
//
DELIMITER ;
-- Step 3: Analytics Queries
-- Top 5 Most Issued Books
SELECT b.Title, COUNT(*) AS TimesIssued
FROM IssuedBooks i
JOIN Books b ON i.BookID = b.BookID
GROUP BY b.Title
ORDER BY TimesIssued DESC
LIMIT 5;

-- Members with Most Borrowed Books
SELECT m.Name, COUNT(*) AS BooksBorrowed
FROM IssuedBooks i
JOIN Members m ON i.MemberID = m.MemberID
GROUP BY m.Name
ORDER BY BooksBorrowed DESC
LIMIT 5;