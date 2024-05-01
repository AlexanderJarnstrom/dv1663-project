DELIMITER $$

CREATE PROCEDURE BorrowBook(
  IN in_isbn INT,
  IN in_cid VARCHAR(8),
  IN in_sid VARCHAR(7)
)
BEGIN
  DECLARE already_borrowed INT;
  DECLARE total INT;
  
  SELECT Books.Quantity
  INTO total
  FROM Books
  WHERE Books.ISBN = in_isbn;
  
  SELECT count(Borrows.ISBN)
  INTO already_borrowed
  FROM Borrows
  WHERE Borrows.ISBN = in_isbn;
  
  IF already_borrowed >= total THEN
    INSERT INTO BorrowAttempts (ISBN, TryDate, Quantity, AlreadyBorrowed)
    VALUE (in_isbn, curdate(), total, already_borrowed);    
  ELSE
    insert into Borrows (ISBN, CID, SID, StartDate, EndDate)
    value (in_isbn, in_cid, in_sid, curdate(), date_add(curdate(), interval 3 MONTH));
  END IF;
END $$

DELIMITER ;