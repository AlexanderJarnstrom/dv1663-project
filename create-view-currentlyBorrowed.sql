drop view CurrentlyBorrowed;

create view CurrentlyBorrowed 
as select Borrows.ISBN, Books.Title, count(Borrows.ISBN) as CurrentlyBorrowed, min(Borrows.EndDate) as EarliestReturn 
from Borrows 
join Books
on Borrows.ISBN = Books.ISBN
group by Borrows.ISBN;
