import mysql.connector
import tomllib

def get_credentials():
    global host
    global user
    global password
    global database
    
    with open("credentials.toml", "rb") as f:
        data = tomllib.load(f)

        host = data["Connection"]["host"]
        user = data["Connection"]["user"]
        password = data["Connection"]["password"]
        database = data["Connection"]["database"]


def test():
    print(host)
    print(user)
    print(password)
    print(database)

    mydb = mysql.connector.connect(
        host = host,
        user = user,
        password = password,
        database = database 
    )

    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM Books")

    myresult = mycursor.fetchall()

    for x in myresult:
        print(x)

if __name__ == "__main__":
    get_credentials()
    test()
