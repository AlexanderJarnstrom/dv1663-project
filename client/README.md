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
