DROP PROCEDURE IF EXISTS AddCustomer;

DELIMITER $$

CREATE PROCEDURE AddCustomer (
  IN in_f_name VARCHAR(15),
  IN in_l_name VARCHAR(15),
  IN in_phone_nbr INT,
  IN in_email VARCHAR(50)
)
BEGIN

  INSERT INTO Customers (FName, LName, PhoneNbr, Email)
  VALUES (in_f_name, in_l_name, in_phone_nbr, in_email);

END $$

DELIMITER ;
