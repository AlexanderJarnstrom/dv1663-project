CREATE VIEW LateReturns 
AS SELECT * 
FROM Borrows
WHERE Borrows.EndDate < curdate()