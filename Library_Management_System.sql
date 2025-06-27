USE LibraryDB;

-- Create Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Quantity INT
);

-- Create Members table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

-- Create IssuedBooks table
CREATE TABLE IssuedBooks (
    IssueID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
INSERT INTO Books (Title, Author, Genre, Quantity) VALUES
('The Alchemist', 'Paulo Coelho', 'Fiction', 5),
('Wings of Fire', 'A.P.J. Abdul Kalam', 'Autobiography', 3),
('Python Programming', 'Guido van Rossum', 'Education', 4),
('Harry Potter', 'J.K. Rowling', 'Fantasy', 7);
INSERT INTO Members (Name, Email, JoinDate) VALUES
('Anjali Reddy', 'anjali@example.com', '2024-01-10'),
('Rahul Sharma', 'rahul@example.com', '2024-02-15'),
('Meena Kapoor', 'meena@example.com', '2024-03-20');
INSERT INTO IssuedBooks (BookID, MemberID, IssueDate, ReturnDate) VALUES
(1, 2, '2024-04-01', '2024-04-15'),
(3, 1, '2024-04-05', '2024-04-20'),
(2, 3, '2024-04-10', NULL);
SELECT * FROM BOOKS;
SELECT * FROM Members;
SELECT 
    IssueID,
    Members.Name AS MemberName,
    Books.Title AS BookTitle,
    IssueDate,
    ReturnDate
FROM IssuedBooks
JOIN Members ON IssuedBooks.MemberID = Members.MemberID
JOIN Books ON IssuedBooks.BookID = Books.BookID;
SELECT 
    IssueID,
    Members.Name AS MemberName,
    Books.Title AS BookTitle,
    IssueDate
FROM IssuedBooks
JOIN Members ON IssuedBooks.MemberID = Members.MemberID
JOIN Books ON IssuedBooks.BookID = Books.BookID
WHERE ReturnDate IS NULL;
SELECT * FROM Books
WHERE Author = 'Paulo Coelho';
SELECT 
    Books.Title,
    COUNT(IssuedBooks.IssueID) AS TimesIssued
FROM IssuedBooks
JOIN Books ON IssuedBooks.BookID = Books.BookID
GROUP BY Books.Title;
-- Show fines for late returns (e.g., ₹10 per day)
SELECT 
    IssueID,
    Members.Name,
    Books.Title,
    DATEDIFF(ReturnDate, IssueDate) AS DaysBorrowed,
    CASE
        WHEN DATEDIFF(ReturnDate, IssueDate) > 15 THEN 
            (DATEDIFF(ReturnDate, IssueDate) - 15) * 10
        ELSE 0
    END AS Fine
FROM IssuedBooks
JOIN Members ON IssuedBooks.MemberID = Members.MemberID
JOIN Books ON IssuedBooks.BookID = Books.BookID
WHERE ReturnDate IS NOT NULL;
SELECT Title, Quantity FROM Books WHERE Quantity > 0;
-- Member returns book (example for IssueID 3)
UPDATE IssuedBooks
SET ReturnDate = CURDATE()
WHERE IssueID = 3;