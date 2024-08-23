DROP PROCEDURE IF EXISTS AddBook;

DELIMITER $$

CREATE PROCEDURE AddBook (
  IN in_isbn INT,
  IN in_title VARCHAR(25),
  IN in_quantity INT
)
BEGIN
  DECLARE exists INT;

  SELECT Books.ISBN
  INTO exists
  FROM Books
  WHERE Books.ISBN = in_isbn;

  IF exists != NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Book already exist.";
  END IF;

  INSERT INTO Books (ISBN, Title, Quantity)
  VALUES (in_isbn, in_title, in_quantity);

  COMMIT;
END $$

DELIMITER ;
