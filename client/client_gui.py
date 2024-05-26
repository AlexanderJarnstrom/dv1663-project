from flask import Flask
from flask import render_template
from flask import request
from db_handler import *

app = Flask(__name__)

# Route för att visa hemsidan
@app.route("/")
def home():
    return render_template("home.html")

# Route för att visa alla böcker
@app.route("/books")
def books():
    content = get_books()
    return render_template("pages/books.html", content=content)

# Route för att lägga till en ny bok, endast POST
@app.route("/books/add", methods=["POST"])
def book_add():
    isbn = int(request.form["txt-isbn"])
    title = request.form["txt-title"]
    quantity = int(request.form["txt-quantity"])
    add_book(isbn, title, quantity)

    content = get_books()
    return render_template("pages/books.html", content=content)

# Route för att söka efter böcker, endast POST
@app.route("/books/search", methods=["POST"])
def book_search():
    search = request.form["txt-search"]
    content = get_books(search)
    return render_template("pages/books.html", content=content)

# Route för att ta bort en bok, endast POST
@app.route("/books/remove", methods=["POST"])
def book_remove():
    isbn = request.form["txt-isbn"]
    remove_book(int(isbn))

    content = get_books()
    return render_template("pages/books.html", content=content)

# Route för att visa nuvarande lån, hanterar både GET och POST
@app.route("/borrows", methods=["GET", "POST"])
def currently_borrowed():
    table_type = 0

    if request.method == "POST":
        if request.form["btn-table"] == "All":
            table_type = 1
            content = get_borrows()
        elif request.form["btn-table"] == "Late":
            table_type = 1
            content = get_late_returns()
        else:
            content = get_currently_borrowed()
    else:
        content = get_currently_borrowed()

    return render_template("pages/currently_borrowed.html", content=content, table_type=table_type)

# Route för att låna en bok, endast POST
@app.route("/borrows/borrow", methods=["POST"])
def borrow():
    cid = int(request.form["txt-cid"])
    isbn = int(request.form["txt-isbn"])
    sid = int(request.form["txt-sid"])

    resp = add_borrow(isbn, cid, sid)
    content = get_currently_borrowed()

    return render_template("pages/currently_borrowed.html", content=content, table_type=0, borrow_error=resp)

# Route för att söka bland lån, endast POST
@app.route("/borrows/search", methods=["POST"])
def borrow_search():
    search = request.form["txt-search"]
    content = get_borrows(search)
    return render_template("pages/currently_borrowed.html", content=content, table_type=1)

# Route för att returnera en bok, endast POST
@app.route("/borrows/return", methods=["POST"])
def borrow_return():
    bid = int(request.form["txt-bid"])

    resp = return_book(bid)
    content = get_currently_borrowed()

    return render_template("pages/currently_borrowed.html", content=content, table_type=0, borrow_error=resp)

# Route för att uppdatera lånedatum, endast POST
@app.route("/borrows/update-date", methods=["POST"])
def borrow_update_date():
    months = int(request.form["number-days"])
    bid = int(request.form["txt-bid"])

    error_txt = update_date(bid, months)

    content = get_borrows(str(bid))
    return render_template("pages/currently_borrowed.html", content=content, table_type=1, error_txt=error_txt)

# Route för att sätta ett specifikt datum för ett lån, endast POST
@app.route("/borrows/set-date", methods=["POST"])
def borrow_set_date():
    date = request.form["date-new-date"]
    bid = int(request.form["txt-bid"])

    resp = set_date(bid, date)
    print(resp)
    content = get_currently_borrowed()

    return render_template("pages/currently_borrowed.html", content=content, table_type=0)

# Route för att visa alla kunder
@app.route("/customers")
def customers():
    content = get_customers()
    return render_template("pages/customers.html", content=content)

# Route för att lägga till en kund, endast POST
@app.route("/customers/add", methods=["POST"])
def customer_add():
    fname = request.form["txt-fname"]
    lname = request.form["txt-lname"]
    phone_nbr = int(request.form["txt-phone-nbr"])
    email = request.form["txt-email"]

    add_customer(fname, lname, phone_nbr, email)

    content = get_customers()
    return render_template("pages/customers.html", content=content)

# Route för att söka efter kunder, endast POST
@app.route("/customers/search", methods=["POST"])
def customer_search():
    search = request.form["txt-search"]
    content = get_customers(search)
    return render_template("pages/customers.html", content=content)

# Route för att ta bort en kund, endast POST
@app.route("/customers/remove", methods=["POST"])
def customer_remove():
    cid = request.form["txt-cid"]
    remove_customer(int(cid))

    content = get_customers()
    return render_template("pages/customers.html", content=content)

# Route för att visa all personal
@app.route("/staff")
def staff():
    content = get_staff()
    return render_template("pages/staff.html", content=content)

# Route för att lägga till personal, endast POST
@app.route("/staff/add", methods=["POST"])
def staff_add():
    fname = request.form["txt-fname"]
    lname = request.form["txt-lname"]
    phone_nbr = int(request.form["txt-phone-nbr"])
    email = request.form["txt-email"]
    add_staff(fname, lname, phone_nbr, email)

    content = get_staff()
    return render_template("pages/staff.html", content=content)

# Route för att söka efter personal, endast POST
@app.route("/staff/search", methods=["POST"])
def staff_search():
    search = request.form["txt-search"]
    content = get_staff(search)
    return render_template("pages/staff.html", content=content)

# Route för att ta bort personal, endast POST
@app.route("/staff/remove", methods=["POST"])
def staff_remove():
    sid = request.form["txt-sid"]
    remove_staff(int(sid))

    content = get_staff()
    return render_template("pages/staff.html", content=content)
