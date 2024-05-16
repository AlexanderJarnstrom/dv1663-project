import mysql.connector
import tomllib

def get_credentials():
    credentials = {}
    with open("credentials.toml", "rb") as f:
        data = tomllib.load(f)
       
        credentials["database"] = data["Connection"]["database"]
        credentials["host"] = data["Connection"]["host"]
        credentials["user"] = data["Connection"]["user"]
        credentials["password"] = data["Connection"]["password"]

    return credentials
    

def add_borrow(isbn: int, cid: str, sid: str):
    args = (isbn, cid, sid, 0)
    cred = get_credentials()
    print(args)
    try:
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                result = cursor.callproc("BorrowBook", args)
                 

    except mysql.connector.Error as e:
        print(e)
        raise e



def set_date():
    pass


def update_date():
    pass


def return_book():
    pass


def get_borrows():
    cred = get_credentials()
    try:
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.execute("SELECT * FROM Borrows")
                result = cursor.fetchall()
                for x in result:
                    print(x)

    except mysql.connector.Error as e:
        print(e)
        raise e


def get_late_borrows():
    pass


def get_customers():
    cred = get_credentials()
    try:
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.execute("SELECT * FROM Customers")
                result = cursor.fetchall()
                for x in result:
                    print(x)

    except mysql.connector.Error as e:
        print(e)
        raise e


def get_books():
    cred = get_credentials()
    try:
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.execute("SELECT * FROM Books")
                result = cursor.fetchall()
                for x in result:
                    print(x)

    except mysql.connector.Error as e:
        print(e)
        raise e


def get_staff():
    cred = get_credentials()
    try:
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                cursor.execute("SELECT * FROM Staff")
                result = cursor.fetchall()
                for x in result:
                    print(x)

    except mysql.connector.Error as e:
        print(e)
        raise e


if __name__ == "__main__":
    add_borrow(101, "CUST001", "LIB005")
