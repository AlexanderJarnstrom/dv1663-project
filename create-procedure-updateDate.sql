DROP PROCEDURE UpdateDate;

DELIMITER $$

CREATE PROCEDURE UpdateDate(
  IN in_bid INT,
  IN in_months INT
)
BEGIN
  DECLARE borrow_exist INT;
  DECLARE end_date DATE;
  DECLARE new_date DATE;

  SELECT Borrows.BID, Borrows.EndDate
  INTO borrow_exist, end_date
  FROM Borrows
  WHERE Borrows.BID = in_bid;
  
  IF borrow_exist IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BID doesn\'t exist.';
  END IF;
  
  SET new_date = date_add(end_date, INTERVAL in_months MONTH);
  
  IF new_date < curdate() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Return date can\'t be in the past.';
  END IF;

  UPDATE Borrows
  SET Borrows.EndDate = new_date
  WHERE Borrows.BID = in_bid;
END $$

DELIMITER ;