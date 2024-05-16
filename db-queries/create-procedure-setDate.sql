DROP PROCEDURE IF EXISTS SetDate;

DELIMITER $$

CREATE PROCEDURE SetDate(
  IN in_bid INT,
  IN in_new_date DATE
)
BEGIN
  DECLARE error_msg VARCHAR(60);
  DECLARE borrow_exist INT;
  
  SELECT Borrows.BID
  INTO borrow_exist
  FROM Borrows
  WHERE Borrows.BID = in_bid;
  
  IF borrow_exist IS NULL THEN
    SELECT concat('BID ', in_bid, ' doesn\'t exist.') 
    INTO error_msg;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
  END IF;

  IF curdate() >= in_new_date THEN
    SELECT concat('Return date cant\'t be in the past, new date: \'', in_new_date, '\'')
    INTO error_msg;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
  END IF;
  
  UPDATE Borrows 
  SET Borrows.EndDate = in_new_date
  WHERE Borrows.BID = in_bid;

  COMMIT;
END $$

DELIMITER ;
