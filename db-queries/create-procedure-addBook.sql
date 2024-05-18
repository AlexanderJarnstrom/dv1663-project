DROP PROCEDURE IF EXISTS AddBook;

DELIMITER $$

CREATE PROCEDURE AddCook (
  IN in_isbn INT,
  IN in_title VARCHAR(25),
  IN in_quantity INT
)
BEGIN

  INSERT INTO Books (ISBN, Title, Quantity)
  VALUES (in_isbn, in_title, in_quantity);

  COMMIT;
END $$

DELIMITER ;
