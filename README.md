# DV1663 Project
Final project in DV1663 at BTH

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
  - **ReturnedDate** (Actual return date)

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
  - create-procedure-returnBook: creates procedure **ReturnBook**
#### create-view
  - create-view-currentlyBorrowed: creates view *CurrentlyBorrowed*
  - create-view-lateReturns: creates view *LateReturns*
#### create-trigger
  - create-trigger-borrowedBook: creates trigger *borrowedBook* on Borrows
  - create-trigger-returnedBook: creates trigger *returnedBook* on Borrows

## Procedures
### BorrowBook
#### Info
Adds a book to *Borrows* if their isn't any more books in stock it'll signal the user and cancle the operation. Sets the current date as **StartDate** and current date with an additional three months as **EndDate**.
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

### ReturnBook
#### Info
Sets the **ReturnedDate** as the current date.
Throws and error if:
  - The given **BID** doesn't exist.
#### Usage
```
call ReturnBook(<BID>);
```
  - **BID**, Borrow ID

## Triggers
  - **borrowedBook** - Updates the quantiy (x - 1) attribute on the book which got borrowed.
  - **returnedBook** - Updates the quantiy (x + 1) attribute on the book which got returned.


