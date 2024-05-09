DROP TRIGGER IF EXISTS returnedBook;

DELIMITER $$

CREATE TRIGGER returnedBook
  AFTER UPDATE
  ON Borrows FOR EACH ROW
BEGIN

  DECLARE returnedDate DATE;

  SELECT Borrows.ReturnedDate
  INTO returnedDate
  FROM Borrows
  WHERE NEW.BID = Borrows.BID;

  IF returnedDate IS NOT NULL THEN
    UPDATE Books
    SET Books.Quantity = Books.Quantity + 1
    WHERE Books.ISBN = NEW.ISBN;
  END IF;

END $$

DELIMITER ;
