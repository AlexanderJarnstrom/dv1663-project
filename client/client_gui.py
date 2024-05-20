from flask import Flask
from flask import render_template
from flask import request
from db_handler import *

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("home.html")


@app.route("/books")
def books():
    content = get_books()
    return render_template("pages/books.html", content=content)


@app.route("/books/add", methods = ["POST"])
def book_add():

    isbn = int(request.form["txt-isbn"])
    title = request.form["txt-title"]
    quantity = int(request.form["txt-quantity"])
    error_txt = add_book(isbn, title, quantity)

    content = get_books()
    return render_template("pages/books.html", content=content, error_txt=error_txt)


@app.route("/books/search", methods = ["POST"])
def book_search():
    search = request.form["txt-search"]
    content = get_books(search)
    return render_template("pages/books.html", content=content)


@app.route("/borrows", methods = ["GET", "POST"])
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



@app.route("/borrows/borrow", methods=["POST"])
def borrow():
    cid = int(request.form["txt-cid"])
    isbn = int(request.form["txt-isbn"])
    sid = int(request.form["txt-sid"])

    error_txt = add_borrow(isbn, cid, sid)
    content = get_currently_borrowed()

    return render_template("pages/currently_borrowed.html", content=content, table_type=0, error_txt=error_txt)


@app.route("/borrows/search", methods = ["POST"])
def borrow_search():
    search = request.form["txt-search"]
    content = get_borrows(search)
    return render_template("pages/currently_borrowed.html", content=content, table_type = 1)


@app.route("/borrows/return", methods=["POST"])
def borrow_return():
    bid = int(request.form["txt-bid"])

    error_txt = return_book(bid)
    content = get_currently_borrowed()

    return render_template("pages/currently_borrowed.html", content=content, table_type=0, error_txt=error_txt)


@app.route("/borrows/update-date", methods=["POST"])
def borrow_update_date():
    
    months = int(request.form["number-days"])
    bid = int(request.form["txt-bid"])

    error_txt = update_date(bid, months)

    content = get_borrows(str(bid))
    return render_template("pages/currently_borrowed.html", content=content, table_type=1, error_txt=error_txt)


@app.route("/borrows/set-date", methods=["POST"])
def borrow_set_date():
    date = request.form["date-new-date"]
    bid = int(request.form["txt-bid"])

    error_txt = set_date(bid, date)
    content = get_currently_borrowed()

    return render_template("pages/currently_borrowed.html", content=content, table_type=1, error_txt=error_txt)


@app.route("/customers")
def customers():
    content = get_customers()
    return render_template("pages/customers.html", content=content)


@app.route("/customers/add", methods = ["POST"])
def customer_add():
    fname = request.form["txt-fname"]
    lname = request.form["txt-lname"]
    phone_nbr = int(request.form["txt-phone-nbr"])
    email = request.form["txt-email"]

    error_txt = add_customer(fname, lname, phone_nbr, email)

    content = get_customers()

    return render_template("pages/customers.html", content=content, error_txt=error_txt)


@app.route("/customers/search", methods = ["POST"])
def customer_search():
    search = request.form["txt-search"]
    content = get_customers(search)
    return render_template("pages/customers.html", content=content)


@app.route("/staff")
def staff():
    content = get_staff()
    return render_template("pages/staff.html", content=content)


@app.route("/staff/add", methods = ["POST"])
def staff_add():

    fname = request.form["txt-fname"]
    lname = request.form["txt-lname"]
    phone_nbr = int(request.form["txt-phone-nbr"])
    email = request.form["txt-email"]
    error_txt = add_staff(fname, lname, phone_nbr, email)

    content = get_staff()
    return render_template("pages/staff.html", content=content, error_txt=error_txt)


@app.route("/staff/search", methods = ["POST"])
def staff_search():
    search = request.form["txt-search"]
    content = get_staff(search)
    return render_template("pages/staff.html", content=content)
