CREATE VIEW CustomersSearch 
AS SELECT 
  Customers.CID, 
  concat(
    Customers.CID, 
    Customers.Email, 
    Customers.FName,
    Customers.LName,
    Customers.PhoneNbr
  ) AS Search 
FROM Customers;

