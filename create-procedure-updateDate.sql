DELIMITER $$

CREATE PROCEDURE UpdateDate(
  IN in_bid INT,
  IN in_months INT,
  IN in_add BOOL
)
BEGIN
  IF NOT in_add THEN
    UPDATE Borrows
    SET Borrows.EndDate = date_sub(Borrows.EndDate, INTERVAL in_months MONTH)
    WHERE Borrows.BID = in_bid;
  ELSE
    UPDATE Borrows
    SET Borrows.EndDate = date_add(Borrows.EndDate, INTERVAL in_months MONTH)
    WHERE Borrows.BID = in_bid;
  END IF;
END $$

DELIMITER ;