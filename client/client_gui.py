from flask import Flask
from flask import render_template
from flask import request
from db_handler import get_books, get_currently_borrowed, get_customers, get_staff

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("home.html")

@app.route("/books")
def books():
    cont = get_books()
    return render_template("tables/book_table.html", books=cont)


@app.route("/borrows")
def currently_borrowed():
    content = get_currently_borrowed()
    return render_template("tables/currently_borrow_table.html", content=content)


@app.route("/customers")
def customers():
    content = get_customers()
    return render_template("tables/customer_table.html", content=content)


@app.route("/customers/add", methods = ["POST"])
def customer_add():
    return render_template("tables/customer_table.html")

@app.route("/customers/search", methods = ["POST"])
def customer_search():
    cid = request.form["txt-search-cid"]
    content = get_customers(cid = cid)
    return render_template("tables/customer_table.html", content=content)


@app.route("/staff")
def staff():
    content = get_staff()
    return render_template("tables/staff_table.html", content=content)

