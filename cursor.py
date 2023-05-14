import mysql.connector as connector

def connect(username, pass_word):
    try:
        connection = connector.connect(user = username, password = pass_word, auth_plugin="mysql_native_password")
        print("Database connected succesfully")
    except:
        print("Cannot connect to the database. Please check the username and password")
    return connection


def access_database(connection, databaes_name, table_name):
    cursor = connection.cursor()
    dict_cursor = connection.cursor(dictionary = True)
    use_database_query = """USE {};""".format(databaes_name)
    select_query = """SELECT * FROM {};""".format(table_name)
    cursor.execute(use_database_query)
    cursor.execute(select_query)
    
    # To store the queried data into a python variable
    result_1 = cursor.fetchall()
    # Remember to close the cursor before creating the other one
    cursor.close()
    
    dict_cursor.execute(use_database_query)
    dict_cursor.execute(select_query)
    result_2 = dict_cursor.fetchmany(size=2)
    result_3 = dict_cursor.fetchall()
    
    dict_cursor.close()
    
    # To access the data stored in cursor
    print("Data accessed by normal cursor: ")
    for row in result_1:
        print(row)
        
    print("Data accessed by dictionary cursor: ")
    for row in result_2:
        print(row)  
        
    print("The remaining data accessed by dictionary cursor: ")
    for row in result_3:
        print(row)
    
        
        

if __name__ == "__main__":
    connection = connect("root", "Tchen226")
    access_database(connection, "Little_Lemon", "Bookings")
        