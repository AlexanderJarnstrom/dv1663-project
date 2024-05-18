# Library client
## Before using
### Dependencies
#### Toml
Used for config parseing

**Pip**
```
pip install toml
```

**Pacman**
```
sudo pacman -S python-toml
```

#### Mysql connector
Used to connect to the database

**Pip**
```
pip install mysql-connector-python
```

**Pacman**
```
sudo pacman -S python-mysql-connector
```

#### Flask

**Pip**
```
pip install Flask
```

**Pacman**
```
sudo pacman -S python-flask
```
**tabulate**
```
pip install tabulate
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
python db-handler.py
```
