DROP VIEW IF EXISTS MostPopularBorrow;

CREATE VIEW MostPopularBorrow
AS SELECT 
  Borrows.ISBN,
  Books.Title,
  count(Borrows.ISBN) AS BorrowCount
FROM Borrows
JOIN Books
  ON Borrows.ISBN = Books.ISBN
GROUP BY Borrows.ISBN
ORDER BY BorrowCount DESC
LIMIT 1;


