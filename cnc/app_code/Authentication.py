
import mysql.connector
from cnc.app_code.db_connection import db_connection

class Authentication(db_connection):
    def __init__(self):
        super().__init__()

    def INSERT_USER(self,full_name,username,hash_password):
        try:
            sql = "INSERT INTO reware.users (full_name, username,hash_password) VALUES (%s, %s, %s);"
            val = (full_name, username, hash_password)
            self.execute(sql,val)
            user_id= self.get_data("SELECT id from reware.users where username='{0}';".format(username))
            return user_id[0][0]
        except (mysql.connector.Error, mysql.connector.Warning) as e:
           print(e)
        except:
            print("SQL ERROR")
            return  None

    #if username and password == correct : return user_id  else return None
    def authenticate(self,username,hash_password):
        try:
            sql="SELECT id from reware.users  where username='{0}' and hash_password='{1}'".format(username,hash_password)
            return self.get_data(sql)[0][0]
        except (mysql.connector.Error, mysql.connector.Warning) as e:
            print(e)
        except:
            print("SQL ERROR")
            return None

