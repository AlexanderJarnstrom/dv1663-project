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

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


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
                "password": data["Connection"]["password"]
            }
        return credentials
    except Exception as e:
        logging.error(f"Error loading credentials: {e}")
        raise e

        
def add_borrow(isbn: int, cid: str, sid: str):
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
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        raise e

        
def set_date(bid: int, date: datetime.date):
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
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        raise e
        
        
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
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        raise e

        
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
    except mysql.connector.Error as e:
        logging.error(f"Database error: {e}")
        raise e

        
def fetch_and_print(query: str, params: tuple = ()):
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.execute(query, params)
                result = cursor.fetchall()
                headers = [i[0] for i in cursor.description]
                print(tabulate(result, headers, tablefmt='psql'))
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

  
def get_borrows(bid: int = -1):
    """
    Gets all borrows, if bid isn't set it'll return
    all, otherwise it'll return the borrow with the
    given id.
    :param bid: Borrow ID
    """
    if bid == -1:
        query = "SELECT * FROM Borrows"
        params = ()
    else:
        query = "SELECT * FROM Borrows WHERE Borrows.BID = %s"
        params = (bid,)
    return fetch_and_print(query, params)

  
def get_customers(cid: str = ""):
    """
    Gets all customers, if bid isn't set it'll return
    all, otherwise it'll return the customer with the
    given id.
    :param cid: Customer ID
    """
    if cid == "":
        query = "SELECT * FROM Customers"
        params = ()
    else:
        query = "SELECT * FROM Customers WHERE Customers.CID = %s"
        params = (cid,)
    return fetch_and_print(query, params)

  
def get_books(isbn: int = -1):
    """
    Gets all books, if bid isn't set it'll return
    all, otherwise it'll return the book with the
    given id.
    :param isbn: International standard book number
    """
    if isbn == -1:
        query = "SELECT * FROM Books"
        params = ()
    else:
        query = "SELECT * FROM Books WHERE Books.ISBN = %s"
        params = (isbn,)
    return fetch_and_print(query, params)

  
def get_staff(sid: str = ""):
    """
    Gets all Staff, if bid isn't set it'll return
    all, otherwise it'll return the staff with the
    given id.
    :param sid: Staff ID
    """
    if sid == "":
        query = "SELECT * FROM Staff"
        params = ()
    else:
        query = "SELECT * FROM Staff WHERE Staff.SID = %s"
        params = (sid,)
    return fetch_and_print(query, params)

  
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

