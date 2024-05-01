DROP VIEW CurrentlyBorrowed;

CREATE VIEW CurrentlyBorrowed 
AS SELECT Borrows.ISBN, Books.Title, count(Borrows.ISBN) AS CurrentlyBorrowed, min(Borrows.EndDate) AS EarliestReturn 
FROM Borrows 
JOIN Books
ON Borrows.ISBN = Books.ISBN
GROUP BY Borrows.ISBN;
