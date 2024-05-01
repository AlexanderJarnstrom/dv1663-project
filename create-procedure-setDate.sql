DELIMITER $$

CREATE PROCEDURE SetDate(
  IN in_bid INT,
  IN in_newDate DATE
)
BEGIN
  IF curdate() >= in_newDate THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Return date can\'t be in the past.';
  END IF;
  
  UPDATE Borrows 
  SET Borrows.EndDate = in_newDate
  WHERE Borrows.BID = in_bid;
END $$

DELIMITER ;
