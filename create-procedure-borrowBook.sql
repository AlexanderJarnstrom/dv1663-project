
DROP PROCEDURE IF EXISTS BorrowBook;

DELIMITER $$

CREATE PROCEDURE BorrowBook(
  IN in_isbn INT,
  IN in_cid VARCHAR(8),
  IN in_sid VARCHAR(7)
)
BEGIN
  DECLARE total INT;
  
  SELECT Books.Quantity
  INTO total
  FROM Books
  WHERE Books.ISBN = in_isbn;
  
  IF 0 >= total THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No more available books.';
  END IF;

  INSERT INTO Borrows (ISBN, CID, SID, StartDate, EndDate)
  VALUE (in_isbn, in_cid, in_sid, curdate(), date_add(curdate(), INTERVAL 3 MONTH));
END $$

DELIMITER ;
