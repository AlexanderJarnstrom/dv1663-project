
DROP TRIGGER IF EXISTS borrowedBook;

DELIMITER $$

CREATE TRIGGER borrowedBook
  AFTER INSERT
  ON Borrows FOR EACH ROW
BEGIN

  UPDATE Books
  SET Books.Quantity = Books.Quantity - 1
  WHERE NEW.ISBN = Books.ISBN;

END $$

DELIMITER ;
