DROP PROCEDURE IF EXISTS UpdateDate;

DELIMITER $$

CREATE PROCEDURE UpdateDate(
  IN in_bid INT,
  IN in_months INT
)
BEGIN
  DECLARE borrow_exist INT;
  DECLARE end_date DATE;
  DECLARE new_date DATE;
  DECLARE error_msg VARCHAR(60);

  SELECT Borrows.BID, Borrows.EndDate
  INTO borrow_exist, end_date
  FROM Borrows
  WHERE Borrows.BID = in_bid;
  
  IF borrow_exist IS NULL THEN
    SELECT concat('BID ', in_bid, ' doesn\'t exist.') 
    INTO error_msg;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
  END IF;
  
  SET new_date = date_add(end_date, INTERVAL in_months MONTH);
  
  IF new_date < curdate() THEN
    SELECT concat('Return date cant\'t be in the past, new date: \'', new_date, '\'')
    INTO error_msg;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
  END IF;

  UPDATE Borrows
  SET Borrows.EndDate = new_date
  WHERE Borrows.BID = in_bid;

  COMMIT; 
END $$

DELIMITER ;
