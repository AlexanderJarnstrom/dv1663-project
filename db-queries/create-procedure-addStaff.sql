DROP PROCEDURE IF EXISTS AddStaff;

DELIMITER $$

CREATE PROCEDURE AddStaff (
  IN in_f_name VARCHAR(15),
  IN in_l_name VARCHAR(15),
  IN in_phone_nbr INT,
  IN in_email VARCHAR(50)
)
BEGIN

  INSERT INTO Staff (FName, LName, PhoneNbr, Email)
  VALUES (in_f_name, in_l_name, in_phone_nbr, in_email);

  COMMIT;
END $$


DELIMITER ;
