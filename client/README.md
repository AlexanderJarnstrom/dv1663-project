# Library client
## Before using
### Dependencies
#### Toml
Used for config parseing
```
pip install toml
```
```
sudo pacman -S python-toml
```

#### Mysql connector
Used to connect to the database
```
pip install mysql-connector-python
```
```
sudo pacman -S python-mysql-connector
```

#### Flask
```
pip install Flask
```
```
sudo pacman -S python-flask
```

#### Tabulate
```
pip install tabulate
```
```
sudo pacman -S python-tabulate
```

### Database connection
A file named *credentials.toml* needs to be created in the directory *client/* with the following content:

```
# Database credentials

[Connection]
host = "localhost"      # server host
user = "username"       # username
password = "secret"     # user password
database = "database"   # database name
```
Make sure the content of this file does not upload to git.

### How to run
The only way to run the ui at the moment is opening a terminal, cd to directory and run:
```
flask --app client_gui.py run
```
if it is for debugging run it whit the ```--debug``` option.

## Files

### db-handler

Has all the database related functions. For more information run:
```
python db_handler.py
```
