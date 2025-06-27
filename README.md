# 📚 Library Management System (SQL Project)

This project is a simple **Library Management System** built using **MySQL**. It simulates how a basic library backend works — including managing books, members, and issuing/returning books.

---

## 🛠 Technologies Used

- 💾 MySQL Database
- 🧠 SQL (DDL, DML, JOINs, Aggregate Functions)
- ✅ MySQL Workbench

---

## 🧱 Database Structure

### 📘 1. Books Table

| Column    | Type        | Description                |
|-----------|-------------|----------------------------|
| BookID    | INT (PK)    | Auto-increment ID          |
| Title     | VARCHAR     | Title of the book          |
| Author    | VARCHAR     | Author's name              |
| Genre     | VARCHAR     | Genre of the book          |
| Quantity  | INT         | Available copies           |

---

### 👤 2. Members Table

| Column    | Type        | Description                |
|-----------|-------------|----------------------------|
| MemberID  | INT (PK)    | Auto-increment ID          |
| Name      | VARCHAR     | Member's full name         |
| Email     | VARCHAR     | Email address              |
| JoinDate  | DATE        | Membership date            |

---

### 🔄 3. IssuedBooks Table

| Column      | Type        | Description                    |
|-------------|-------------|--------------------------------|
| IssueID     | INT (PK)    | Unique issue record            |
| BookID      | INT (FK)    | Book that was issued           |
| MemberID    | INT (FK)    | Member who borrowed the book   |
| IssueDate   | DATE        | Date book was issued           |
| ReturnDate  | DATE        | Date book was returned         |

---

## 📥 Sample Queries

```sql
-- View all books
SELECT * FROM Books;

-- View all members
SELECT * FROM Members;

-- View all issued books with member and book names
SELECT 
    IssueID,
    Members.Name AS MemberName,
    Books.Title AS BookTitle,
    IssueDate,
    ReturnDate
FROM IssuedBooks
JOIN Members ON IssuedBooks.MemberID = Members.MemberID
JOIN Books ON IssuedBooks.BookID = Books.BookID;

-- View books not yet returned
SELECT 
    IssueID,
    Members.Name,
    Books.Title,
    IssueDate
FROM IssuedBooks
JOIN Members ON IssuedBooks.MemberID = Members.MemberID
JOIN Books ON IssuedBooks.BookID = Books.BookID
WHERE ReturnDate IS NULL;

-- Count how many times each book was issued
SELECT 
    Books.Title,
    COUNT(IssuedBooks.IssueID) AS TimesIssued
FROM IssuedBooks
JOIN Books ON IssuedBooks.BookID = Books.BookID
GROUP BY Books.Title;
```

---

## 🧾 How to Run

1. Open MySQL Workbench
2. Paste the contents of `Library_Management_System.sql`
3. Run the script to create database, tables, and insert sample data
4. Run the queries to test the system

---

## 📌 Author

**Name:** Pavani Reddy  
**Project Type:** SQL Mini Project  
**Role:** Beginner SQL Developer / Student

---

## 📂 License

Free to use under the MIT License.

## 🔧 Advanced Features Added

A separate file advanced_features includes:

- 📄 A *VIEW* to track overdue books (OverdueBooks)
- ⚙ A *TRIGGER* to reduce book quantity after issuing
- 📊 *Analytics Queries*:
  - Top 5 most issued books
  - Members who borrowed the most books

> 📂 Check the file: [Advanced_Features](./Advanced_Features.sql)
