DROP PROCEDURE IF EXISTS RemoveCustomer;
DROP PROCEDURE IF EXISTS RemoveStaff;
DROP PROCEDURE IF EXISTS RemoveBook;

DELIMITER $$

CREATE PROCEDURE RemoveCustomer (IN in_cid INT)
BEGIN
  
  DELETE FROM Customers WHERE Customers.CID = in_cid;
  COMMIT;

END $$

CREATE PROCEDURE RemoveStaff (IN in_sid INT)
BEGIN
  
  DELETE FROM Staff WHERE Staff.SID = in_sid;
  COMMIT;

END $$

CREATE PROCEDURE RemoveBook (IN in_isbn INT)
BEGIN
  
  DELETE FROM Books WHERE Books.ISBN = in_isbn;
  COMMIT;

END $$
DELIMITER ;
