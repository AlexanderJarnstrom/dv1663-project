DROP VIEW LateReturns;

CREATE VIEW LateReturns 
AS SELECT 
  Books.Title,
  Books.ISBN,
  concat(Customers.FName, ' ', Customers.LName) AS CName,
  Borrows.EndDate,
  datediff(curdate(), EndDate) AS DaysLate
FROM Borrows
JOIN Customers
ON Borrows.CID = Customers.CID
JOIN Books
ON Borrows.ISBN = Books.ISBN
WHERE EndDate < curdate();

