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

def get_credentials():
    """
    Loads credentials form client/credentials.toml
    :return: a dict with the credentials
    """
    credentials = {}
    with open("credentials.toml", "rb") as f:
        data = tomllib.load(f)
       
        credentials["database"] = data["Connection"]["database"]
        credentials["host"] = data["Connection"]["host"]
        credentials["user"] = data["Connection"]["user"]
        credentials["password"] = data["Connection"]["password"]

    return credentials
    

def add_borrow(isbn: int, cid: str, sid: str):
    """
    Adds a book to the 'Borrows
    :param isbn: International Standard Book Number
    :param cid: Customer ID 
    :param sid: Staff ID
    """
    args = (isbn, cid, sid, 0)
    print(args)
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("BorrowBook", args)

    except mysql.connector.Error as e:
        print(e)
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

    except mysql.connector.Error as e:
        print(e)
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

    except mysql.connector.Error as e:
        print(e)
        raise e


def return_book(bid: int):
    """
    Updates the borrow as returned by setting the return
    date to todays date.
    :param bid: Borrow ID
    """
    args = (bid, )
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.callproc("ReturnBook", args)

    except mysql.connector.Error as e:
        print(e)
        raise e


def get_currently_borrowed():
    """
    Gets the books that are currently borrowed, how many
    of each and earliest up coming return.
    """
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.execute("SELECT * FROM CurrentlyBorrowed")
                result = cursor.fetchall()
                return result

    except mysql.connector.Error as e:
        print(e)

    return None


def get_late_returns():
    """
    Gets all borrows where the end date has passed
    todays date.
    """
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.execute("SELECT * FROM LateReturns")
                result = cursor.fetchall()
                for x in result:
                    print(x)

    except mysql.connector.Error as e:
        print(e)
        raise e


def get_borrows(bid: int = -1):
    """
    Gets all borrows, if bid isn't set it'll return
    all, otherwise it'll return the borrow with the
    given id.
    :param bid: Borrow ID
    """
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                if bid == -1:
                    cursor.execute("SELECT * FROM Borrows")
                else:
                    cursor.execute("SELECT * FROM Borrows WHERE Borrows.BID = %s", [bid])

                result = cursor.fetchall()
                for x in result:
                    print(x)

    except mysql.connector.Error as e:
        print(e)
        raise e


def get_customers(cid: str = ""):
    """
    Gets all customers, if bid isn't set it'll return
    all, otherwise it'll return the customer with the
    given id.
    :param cid: Customer ID
    """
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                if cid == "":
                    cursor.execute("SELECT * FROM Customers")
                else:
                    cursor.execute("SELECT * FROM Customers WHERE Customers.CID = %s", [cid])

                result = cursor.fetchall()
                return result

    except mysql.connector.Error as e:
        print(e)

    return None


def get_books(isbn: int = -1):
    """
    Gets all books, if bid isn't set it'll return
    all, otherwise it'll return the book with the
    given id.
    :param isbn: International standard book number
    """
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                if isbn == -1:
                    cursor.execute("SELECT * FROM Books")
                else:
                    cursor.execute("SELECT * FROM Books WHERE Books.ISBN = %s", [isbn])

                result = cursor.fetchall()
                return result

    except mysql.connector.Error as e:
        print(e)

    return None


def get_staff(sid: str = ""):
    """
    Gets all Staff, if bid isn't set it'll return
    all, otherwise it'll return the staff with the
    given id.
    :param sid: Staff ID
    """
    try:
        cred = get_credentials()
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                if sid == "":
                    cursor.execute("SELECT * FROM Staff")
                else:
                    cursor.execute("SELECT * FROM Staff WHERE Staff.SID = %s", [sid])

                result = cursor.fetchall()
                return result

    except mysql.connector.Error as e:
        print(e)

    return None


if __name__ == "__main__":
    print(__doc__)
    print(get_credentials.__doc__)
    print(add_borrow.__doc__)
    print(set_date.__doc__)
    print(update_date.__doc__)
    print(return_book.__doc__)
    print(get_currently_borrowed.__doc__)
    print(get_late_returns.__doc__)
    print(get_borrows.__doc__)
    print(get_customers.__doc__)
    print(get_books.__doc__)
    print(get_staff.__doc__)
