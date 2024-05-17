from flask import Flask
from markupsafe import escape
from flask import render_template
from flask import request
from db_handler import get_books, get_currently_borrowed, get_customers, get_staff
from table_formatter import table_formatter

app = Flask(__name__)

@app.route("/books")
def books():
    cont = get_books()
    print(cont)
    return render_template("tables/book_table.html", books=cont)


@app.route("/borrows")
def currently_borrowed():
    content = get_currently_borrowed()
    print(content)
    return render_template("tables/currently_borrow_table.html", content=content)


@app.route("/customers")
def customers():
    content = get_customers()
    print(content)
    return render_template("tables/customer_table.html", content=content)


@app.route("/staff")
def staff():
    content = get_staff()
    print(content)
    return render_template("tables/staff_table.html", content=content)

