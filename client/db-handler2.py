import mysql.connector
import tomllib
from datetime import datetime, timedelta

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
    cred = get_credentials()
    try:
        with mysql.connector.connect(**cred) as db:
            with db.cursor() as cursor:
                query = "INSERT INTO Borrows (ISBN, CustomerID, StaffID, BorrowDate) VALUES (%s, %s, %s, %s)"
                borrow_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                cursor.execute(query, (isbn, cid, sid, borrow_date))
                db.commit()
                print("Borrow added successfully.")

    except mysql.connector.Error as e:
        print("Error adding borrow:", e)

def set_date(borrow_id: int):
    try:
        with mysql.connector.connect(**get_credentials()) as db:
            with db.cursor() as cursor:
                query = "UPDATE Borrows SET ReturnDate = %s WHERE BorrowID = %s"
                return_date = (datetime.now() + timedelta(days=14)).strftime('%Y-%m-%d %H:%M:%S')
                cursor.execute(query, (return_date, borrow_id))
                db.commit()
                print("Return date set successfully.")

    except mysql.connector.Error as e:
        print("Error setting return date:", e)

def update_date(borrow_id: int, new_return_date: str):
    try:
        with mysql.connector.connect(**get_credentials()) as db:
            with db.cursor() as cursor:
                query = "UPDATE Borrows SET ReturnDate = %s WHERE BorrowID = %s"
                cursor.execute(query, (new_return_date, borrow_id))
                db.commit()
                print("Return date updated successfully.")

    except mysql.connector.Error as e:
        print("Error updating return date:", e)

def return_book(borrow_id: int):
    try:
        with mysql.connector.connect(**get_credentials()) as db:
            with db.cursor() as cursor:
                query = "UPDATE Borrows SET Returned = 1 WHERE BorrowID = %s"
                cursor.execute(query, (borrow_id,))
                db.commit()
                print("Book returned successfully.")

    except mysql.connector.Error as e:
        print("Error returning book:", e)

# Add other functions (get_borrows, get_late_borrows, get_customers, get_books, get_staff) here...

if __name__ == "__main__":
    add_borrow(101, "CUST001", "LIB005")

