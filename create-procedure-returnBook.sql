DROP PROCEDURE IF EXISTS ReturnBook;

DELIMITER $$

CREATE PROCEDURE ReturnBook (
  IN in_bid INT
)
BEGIN
  DECLARE borrow_exist INT;
  DECLARE error_msg VARCHAR(60);

  SELECT Count(Borrows.BID)
  INTO borrow_exist
  FROM Borrows
  WHERE Borrows.BID = in_bid;

  IF borrow_exist < 1 THEN
    SELECT concat("BID ", in_bid, "doesn't exist.")
    INTO error_msg;

    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
  END IF;

  UPDATE Borrows
  SET Borrows.ReturnedDate = current_date()
  WHERE Borrows.BID = in_bid;

END $$

DELIMITER ;
