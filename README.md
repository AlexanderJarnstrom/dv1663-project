# dv1663-project
final project in DV1663 at BTH

## Tables
Current tables in project.
### Personell
Holds information about the staff at the library. The following attributes reprecent a worker:
  - **PID** (Personell ID, *Primary key*)
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
  - **PID** (Personell ID, *Foreign key*)
  - **StartDate** (When the book was borrowed)
  - **EndDate** (Latest return date)
