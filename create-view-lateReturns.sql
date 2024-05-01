CREATE VIEW LateReturns 
AS SELECT * 
FROM Borrows
WHERE Borrows.EndDate < curdate()
--updated counter for late days 
////////

CREATE VIEW LateReturns 
AS 
    SELECT 
        *,
        DATEDIFF(curdate(), EndDate) AS DaysLate
    FROM 
        Borrows
    WHERE 
        EndDate < curdate();

