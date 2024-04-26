# dv1663-project
final project in DV1663 at BTH

## Tables
Current tables in project.

### Staff
Holds information about the staff at the library. The following attributes reprecent a worker:
  - **SID** (Staff ID, *Primary key*)
  - **FName** (First name)
  - **LName** (Last name)
  - **PhoneNbr** (Phone number)
  - **Email**

### Customers
Holds information about the customers in the system. A customer is reprecented by the following attributes:
  - **CID** (Customer ID, *Primary key*)
  - **FName** (First name)
  - **LName** (Last name)
  - **PhoneNbr** (Phone number)
  - **Email**

### Books
Holds information about the books in the system. A book is reprecented by the following attributes:
  - **ISBN** (International Standard Book Number, *Primary key*)
  - **Title**
  - **Quantity**

### Borrows
Shows who borrowed which book from who, A borrow is reprecented by the following attributes:
  - **BID** (Borrow ID, *Primary key*)
  - **ISBN** (International Standard Book Number, *Foreign key*)
  - **CID** (Customer ID, *Foreign key*)
  - **SID** (Personell ID, *Foreign key*)
  - **StartDate** (When the book was borrowed)
  - **EndDate** (Latest return date)

###  BorrowAttempts
Holds information about failed borrow atempts, currently a failed attempt is when all books are loaned already.
  - **ID** (primary key, auto_increment)
  - **ISBN** (Which book)
  - **TryDate** (Date when atempt occured)
  - **Quantity** (The book count at that day)
  - **AlreadyBorrowed** (The amount of currently borrowed books)

## Procedures
### BorrowBook
#### Parameters
  - ISBN
  - CID
  - SID
#### Info
Adds a book to *Borrows* if their isn't any more books in stock it'll add an attempt to *BorrowAttempts*.
### Usage
```
call BorrowBook(<ISBN>, <CID>, <SID>);
```

## Help SQL
### add-sample-data
Adds sample data into *Customers*, *Staff* and *Books*. If updating of the tables uccours, validate the sample data.
