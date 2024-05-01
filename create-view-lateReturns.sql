CREATE VIEW LateReturns 
AS SELECT * 
FROM Borrows
WHERE Borrows.EndDate < curdate()
--updated 
////////
CREATE VIEW LateReturns 
AS 
    SELECT
        *,
        CASE
            WHEN DATEDIFF(curdate(), EndDate) <= 7 THEN 'Warning'
            WHEN DATEDIFF(curdate(), EndDate) <= 14 THEN 'Late - Fine Imposed'
            ELSE 'Very Late - Serious Action Required'
        END AS LateStatus
    FROM 
        Borrows
    WHERE 
        EndDate < curdate();
--OR
CREATE VIEW LateReturns 
AS 
    SELECT 
        *,
        DATEDIFF(curdate(), EndDate) AS DaysLate
    FROM 
        Borrows
    WHERE 
        EndDate < curdate();

