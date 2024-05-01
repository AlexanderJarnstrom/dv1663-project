DELIMITER $$

CREATE PROCEDURE SetDate(
  IN in_bid INT,
  IN in_newDate DATE
)
BEGIN
  IF curdate() < in_newDate THEN
    UPDATE Borrows 
    SET Borrows.EndDate = in_newDate
    WHERE Borrows.BID = in_bid;
  END IF;
END $$

DELIMITER ;
