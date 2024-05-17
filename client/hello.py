from flask import Flask
from markupsafe import escape
from flask import render_template
from flask import request
from db_handler import get_books
from table_formatter import table_formatter

app = Flask(__name__)

@app.route("/")
def hello_world():
    cont = get_books()
    print(cont)
    return render_template("tables/book_table.html", books=cont)

