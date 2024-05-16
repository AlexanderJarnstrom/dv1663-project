# Database queries

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

## Views
### CurrentlyBorrowed
Shows how many of the individual books are currently borrowed and when the earliest return date is set.
  - **ISBN** (Which book)
  - **Title**
  - **CurrentlyBorrowed** (How many which are currently borrowed)
  - **EarliestReturn** (Shows the date of the closest return)

### LateReturns
Shows all the *Borrows* where the **EndDate** has pasted. Same attributes as *Borrows*.

## Help SQL
### add-sample-data
Adds sample data into *Customers*, *Staff* and *Books*. If updating of the tables uccours, validate the sample data.

### create
  - create-tables: creates the needed tables
#### create-procedure
  - create-procedure-borrowBook: creates procedure **BorrowBook**
  - create-procedure-setDate: creates procedure **SetDate**
  - create-procedure-updateDate: creates procedure **UpdateDate**
#### create-view
  - create-view-currentlyBorrowed: creates view *CurrentlyBorrowed*
  - create-view-lateReturns: creates view *LateReturns*

## Procedures
### BorrowBook
#### Info
Adds a book to *Borrows* if their isn't any more books in stock it'll add an attempt to *BorrowAttempts*. Sets the current date as **StartDate** and current date with an additional three months as **EndDate**.
#### Usage
```
call BorrowBook(<ISBN>, <CID>, <SID>);
```
  - **ISBN**, International Standard Book Number
  - **CID**, Customer ID
  - **SID**, Staff ID
### SetDate
#### Info
Sets the end date to the given date in *Borrows*.
Throws an error if:
  - The given date is before the current date.
  - The given **BID** doesn't exist.

#### Usage
```
call SetDate(<BID>, <date>)
```
  - **BID**, Borrow ID
  - **date**, the wished date ('YYYY-MM-DD')
### UpdateDate
#### Info
Adds the given amount from the current end date in *Borrows*, works with negative numbers if the time is wished to be shortend.
Throws an error if:
  - The given months moves **EndDate** before the current date.
  - The given **BID** doesn't exist.

#### Usage
```
call UpdateDate(<BID>, <Months>)
```
  - **BID**, Borrow ID
  - **Months**, Amount of months (int)