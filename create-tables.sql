drop table Borrows;
drop table Staff;
drop table BorrowAtempts;
drop table Customers;
drop table Books;

create table Staff(
  SID varchar(7) not null unique,
  FName varchar(15) not null,
  LName varchar(15) not null,
  PhoneNbr int not null,
  Email varchar(40) default null,
  primary key (SID)
);

create table Customers(
  CID varchar(8) not null unique,
  FName varchar(15) not null,
  LName varchar(15) not null,
  PhoneNbr int default null,
  Email varchar(40) default null,
  primary key (CID),
  constraint ValidateCustomer check (Email is not null or PhoneNBR is not null)
);

create table Books (
  ISBN int not null unique,
  Title varchar(25) not null,
  Price int not null,
  Quantity int default(0),
  primary key (ISBN)
);

create table Borrows (
  BID int not null unique auto_increment,
  ISBN int not null,
  CID varchar(8) not null,
  SID varchar(7) not null,
  StartDate date default(current_date()),
  EndDate date default(current_date() + 3),
  primary key (BID),
  foreign key (ISBN) references Books(ISBN),
  foreign key (CID) references Customers(CID),
  foreign key (SID) references Staff(SID)
);

create table BorrowAttempts (
  ID int not null unique auto_increment,
  ISBN int,
  TryDate Date,
  Quantity int,
  AlreadyBorrowed int,
  primary key (ID)
);
