DROP TABLE IF EXISTS Borrows;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS BorrowAtempts;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

CREATE TABLE Staff(
  SID VARCHAR(7) NOT NULL UNIQUE,
  FName VARCHAR(15) NOT NULL,
  LName VARCHAR(15) NOT NULL,
  PhoneNbr INT NOT NULL,
  Email VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (SID)
);

CREATE TABLE Customers(
  CID VARCHAR(8) NOT NULL UNIQUE,
  FName VARCHAR(15) NOT NULL,
  LName VARCHAR(15) NOT NULL,
  PhoneNbr INT DEFAULT NULL,
  Email VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (CID),
  CONSTRAINT ValidateCustomer CHECK (Email IS NOT NULL OR PhoneNbr IS NOT NULL)
);

CREATE TABLE Books (
  ISBN INT NOT NULL UNIQUE,
  Title VARCHAR(25) NOT NULL,
  Price INT NOT NULL,
  Quantity INT DEFAULT 0,
  PRIMARY KEY (ISBN)
);

CREATE TABLE Borrows (
  BID INT NOT NULL UNIQUE AUTO_INCREMENT,
  ISBN INT NOT NULL,
  CID VARCHAR(8) NOT NULL,
  SID VARCHAR(7) NOT NULL,
  StartDate DATE DEFAULT(curdate()),
  EndDate DATE DEFAULT(date_add(curdate(), INTERVAL 3 MONTH)),
  PRIMARY KEY (BID),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN),
  FOREIGN KEY (CID) REFERENCES Customers(CID),
  FOREIGN KEY (SID) REFERENCES Staff(SID)
);

CREATE TABLE BorrowAttempts (
  ID INT NOT NULL UNIQUE AUTO_INCREMENT,
  ISBN INT,
  TryDate DATE,
  Quantity INT,
  AlreadyBorrowed INT,
  PRIMARY KEY (ID)
);