import mysql.connector as connector
from mysql.connector import errorcode



try:
    connection = connector.connect(user = "root", password = "Tchen226", auth_plugin="mysql_native_password")
    print("Database is connected succesfully !")
except:
    print("Cannot connect to the database.\n Please check the username or password.")
    
    
    
# Print the error message by accessing the built in errorcode
try:
    connection = connector.connect(user = "root", password = "Tchen226", database = "big_lemon", auth_plugin="mysql_native_password")
    print("Database is connected succesfully !")
except connector.Error as er:
    print("Error code: {}".format(er.errno))
    print("Error message: {}".format(er.msg))
    
    
try:
    connection = connector.connect(user = "root", password = "Tchen226", database = "big_lemon", auth_plugin="mysql_native_password")
    print("Database is connected succesfully !")
except connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Connection user or password are incorrect")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)