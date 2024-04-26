drop procedure BorrowBook;

delimiter $$

create procedure BorrowBook(
  in in_isbn int,
  in in_cid varchar(8),
  in in_sid varchar(7)
)
begin
  declare AlreadyBorrowed int;
  declare Total int;
  
  select Books.Quantity
  into total
  from Books
  where Books.ISBN = in_isbn;
  
  select count(Borrows.ISBN)
  into alreadyBorrowed
  from Borrows
  where Borrows.ISBN = in_isbn;
  
  if AlreadyBorrowed >= Total then
    insert into BorrowAtempts (ISBN, TryDate, Quantity, AlreadyBorrowed)
    value (in_isbn, curdate(), total, alreadyBorrowed);    
  end if;
  if AlreadyBorrowed < Total then
    insert into Borrows (ISBN, CID, SID, StartDate, EndDate)
    value (in_isbn, in_cid, in_sid, curdate(), date_add(curdate(), interval 3 month));
  end if;
  
end $$

delimiter ;