"""
Collection of all database related calls.

    - get_credentials
    - add_borrow
    - set_date
    - update_date
    - return_book
    - get_currently_borrowed
    - get_late_returns
    - get_borrows
    - get_customers
    - get_books
    - get_staff
"""

import datetime
import mysql.connector
import tomllib
import logging
from tabulate import tabulate
import os

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


def add_sample_data():
    path = "../db-queries/data/add-sample-data.sql"

    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                with open(path, "r") as f:
                    data = f.read()
                    print(data)
                    cursor.execute(data, multi=True)
                    logging.info(f"Executed query: {path}")

                db.commit()

    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        return e.msg
    
    return None

def get_credentials():
    """
    Loads credentials form client/credentials.toml
    :return: a dict with the credentials
    """
    try:
        with open("credentials.toml", "rb") as f:
            data = tomllib.load(f)
            credentials = {
                "database": data["Connection"]["database"],
                "host": data["Connection"]["host"],
                "user": data["Connection"]["user"],
                "password": data["Connection"]["password"],
                "autocommit": "True"
            }
        return credentials
    except Exception as e:
        logging.error(f"Error loading credentials: {e}")
        raise e

        
def add_borrow(isbn: int, cid: int, sid: int):
    """
    Adds a book to the 'Borrows
    :param isbn: International Standard Book Number
    :param cid: Customer ID 
    :param sid: Staff ID
    """
    args = (isbn, cid, sid)

    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("BorrowBook", args)

        logging.info(f"Borrow added: ISBN={isbn}, CID={cid}, SID={sid}")
        return None
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        return e.msg

        
def set_date(bid: int, date: str):
    """
    Sets the the whished return date on a borrow.
    :param bid: Borrow ID 
    :param date: The date
    """
    args = (bid, date)
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("SetDate", args)

        logging.info(f"Date set for BID={bid} to {date}")
        return None
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        return e.msg
        
        
def update_date(bid: int, months: int):
    """
    Updates the wished return date with +/- months.
    :param bid: Borrow ID
    :param months: Amount of months
    """
    args = (bid, months)
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("UpdateDate", args)

        logging.info(f"Date updated for BID={bid} by {months} months")
        return None
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        return e.msg

        
def return_book(bid: int):
    """
    Updates the borrow as returned by setting the return
    date to todays date.
    :param bid: Borrow ID
    """
    args = (bid,)
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("ReturnBook", args)
        logging.info(f"Book returned for BID={bid}")
        return None
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        return e.msg


def add_customer(fname: str, lname: str, phone_nbr: int, email: str):
    """
    Updates the borrow as returned by setting the return
    date to todays date.
    :param bid: Borrow ID
    """
    args = (fname, lname, phone_nbr, email)
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("AddCustomer", args)
        logging.info(f"Added customer {fname} {lname} {phone_nbr} {email}")
        return None
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        return e.msg


def add_staff(fname: str, lname: str, phone_nbr: int, email: str):
    """
    Updates the borrow as returned by setting the return
    date to todays date.
    :param bid: Borrow ID
    """
    args = (fname, lname, phone_nbr, email)
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("AddStaff", args)
        logging.info(f"Added staff {fname} {lname} {phone_nbr} {email}")
        return None
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        return e.msg


def add_book(isbn: int, title: str, quantity: int):
    """
    Updates the borrow as returned by setting the return
    date to todays date.
    :param bid: Borrow ID
    """
    args = (isbn, title, quantity)
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("AddBook", args)
        logging.info(f"Added book {isbn} {title} {quantity}")
        return None
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        return e.msg


def fetch_and_print(query: str, params: tuple = ()):
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.execute(query, params)
                result = cursor.fetchall()
                #headers = [i[0] for i in cursor.description]
                #print(tabulate(result, headers, tablefmt='psql'))
                return result
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        raise e

        
def get_currently_borrowed():
    """
    Gets the books that are currently borrowed, how many
    of each and earliest up coming return.
    """
    query = "SELECT * FROM CurrentlyBorrowed"
    return fetch_and_print(query)

  
def get_late_returns():
    """
    Gets all borrows where the end date has passed
    todays date.
    """
    query = "SELECT * FROM LateReturns"
    return fetch_and_print(query)

  
def get_borrows(search: str = ""):
    """
    Gets all borrows, if bid isn't set it'll return
    all, otherwise it'll return the borrow with the
    given id.
    :param bid: Borrow ID
    """
    query = """
        SELECT 
            Borrows.BID,
            Books.Title,
            concat(Customers.FName, " ", Customers.LName) AS Customer,
            concat(Staff.FName, " ", Staff.LName) AS Librarian,
            Borrows.StartDate,
            Borrows.EndDate,
            Borrows.ReturnedDate
        FROM Borrows 
        JOIN Customers ON Borrows.CID = Customers.CID
        JOIN Books ON Borrows.ISBN = Books.ISBN
        JOIN Staff ON Borrows.SID = Staff.SID
        WHERE concat(
            Borrows.BID,
            Customers.FName,
            Customers.LName,
            Books.Title,
            Staff.FName,
            Staff.LName,
            Borrows.StartDate,
            Borrows.EndDate
        ) LIKE "%"""
    query += search
    query += "%\""
    return fetch_and_print(query)

  
def get_customers(search: str = ""):
    """
    Gets all customers, if bid isn't set it'll return
    all, otherwise it'll return the customer with the
    given id.
    :param cid: Customer ID
    """
    query = """SELECT *
        FROM Customers 
        WHERE concat(
            Customers.CID,
            Customers.Email,
            Customers.FName,
            Customers.LName,
            Customers.PhoneNbr
        ) LIKE "%"""
    query += search
    query += "%\""
    return fetch_and_print(query)

  
def get_books(search: str = ""):
    """
    Gets all books, if bid isn't set it'll return
    all, otherwise it'll return the book with the
    given id.
    :param isbn: International standard book number
    """
    query = """SELECT *
        FROM Books 
        WHERE concat(
            Books.ISBN,
            Books.Title
        ) LIKE "%"""
    query += search
    query += "%\""
    return fetch_and_print(query)

  
def get_staff(search: str = ""):
    """
    Gets all Staff, if bid isn't set it'll return
    all, otherwise it'll return the staff with the
    given id.
    :param sid: Staff ID
    """
    query = """SELECT *
        FROM Staff 
        WHERE concat(
            Staff.SID,
            Staff.Email,
            Staff.FName,
            Staff.LName,
            Staff.PhoneNbr
        ) LIKE "%"""
    query += search
    query += "%\""
    return fetch_and_print(query)

  
if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Library Database Management")
    parser.add_argument("operation", choices=[
        "get_credentials", "add_borrow", "set_date", "update_date",
        "return_book", "get_currently_borrowed", "get_late_returns",
        "get_borrows", "get_customers", "get_books", "get_staff"
    ], help="Operation to perform")
    parser.add_argument("--isbn", type=int, help="International Standard Book Number")
    parser.add_argument("--cid", type=str, help="Customer ID")
    parser.add_argument("--sid", type=str, help="Staff ID")
    parser.add_argument("--bid", type=int, help="Borrow ID")
    parser.add_argument("--date", type=lambda s: datetime.datetime.strptime(s, '%Y-%m-%d').date(), help="Date (YYYY-MM-DD)")
    parser.add_argument("--months", type=int, help="Number of months to update date by")

    args = parser.parse_args()

    if args.operation == "get_credentials":
        print(get_credentials())
    elif args.operation == "add_borrow":
        if args.isbn and args.cid and args.sid:
            add_borrow(args.isbn, args.cid, args.sid)
        else:
            print("ISBN, CID, and SID are required for adding a borrow.")
    elif args.operation == "set_date":
        if args.bid and args.date:
            set_date(args.bid, args.date)
        else:
            print("BID and date are required for setting a date.")
    elif args.operation == "update_date":
        if args.bid and args.months:
            update_date(args.bid, args.months)
        else:
            print("BID and months are required for updating a date.")
    elif args.operation == "return_book":
        if args.bid:
            return_book(args.bid)
        else:
            print("BID is required for returning a book.")
    elif args.operation == "get_currently_borrowed":
        get_currently_borrowed()
    elif args.operation == "get_late_returns":
        get_late_returns()
    elif args.operation == "get_borrows":
        get_borrows(args.bid if args.bid else -1)
    elif args.operation == "get_customers":
        get_customers(args.cid if args.cid else "")
    elif args.operation == "get_books":
        get_books(args.isbn if args.isbn else -1)
    elif args.operation == "get_staff":
        get_staff(args.sid if args.sid else "")

