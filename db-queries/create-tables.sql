DROP TABLE IF EXISTS Borrows;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

CREATE TABLE Staff(
  SID INT AUTO_INCREMENT,
  FName VARCHAR(15) NOT NULL,
  LName VARCHAR(15) NOT NULL,
  PhoneNbr INT NOT NULL,
  Email VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (SID)
);

CREATE TABLE Customers(
  CID INT AUTO_INCREMENT,
  FName VARCHAR(15) NOT NULL,
  LName VARCHAR(15) NOT NULL,
  PhoneNbr INT DEFAULT NULL,
  Email VARCHAR(40) DEFAULT NULL,
  PRIMARY KEY (CID),
  CONSTRAINT ValidateCustomer CHECK (Email IS NOT NULL OR PhoneNbr IS NOT NULL)
);

CREATE TABLE Books (
  ISBN INT,
  Title VARCHAR(25) NOT NULL,
  Quantity INT DEFAULT 0,
  PRIMARY KEY (ISBN)
);

CREATE TABLE Borrows (
  BID INT AUTO_INCREMENT,
  ISBN INT,
  CID INT,
  SID INT,
  StartDate DATE DEFAULT(curdate()),
  EndDate DATE DEFAULT(date_add(curdate(), INTERVAL 3 MONTH)),
  ReturnedDate Date DEFAULT NULL,
  PRIMARY KEY (BID),
  FOREIGN KEY (ISBN) REFERENCES Books(ISBN),
  FOREIGN KEY (CID) REFERENCES Customers(CID),
  FOREIGN KEY (SID) REFERENCES Staff(SID)
);

