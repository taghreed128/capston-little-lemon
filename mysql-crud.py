import mysql.connector as connector

def connect():
    username = input("Enter Username: ")
    pass_word = input("Enter password: ")
    
    try:
        connection = connector.connect(user = username, password = pass_word, auth_plugin="mysql_native_password")
        print("Database connected successfully")
    except:
        print("Cannot connect to the databse.")
        
    return connection



def update(connection, database):
    cursor = connection.cursor()
    use_database = """Use {};""".format(database)
    update_data = """
    UPDATE MenuItems 
    SET Type = "Main Course"
    WHERE ItemID = 6;"""
    
    cursor.execute(use_database)
    cursor.execute(update_data)
    connection.commit()
    print("Update committed to the table.")
    
    cursor.close()
    

def delete(connection, database):
    cursor = connection.cursor()
    use_database = """USE {};""".format(database)
    delete_data = """
    DELETE FROM MenuItems
    WHERE ItemID = 10;"""
    
    cursor.execute(use_database)
    cursor.execute(delete_data)
    connection.commit()
    print("Deletion committed to the table.")
    
    cursor.close()



def read(connection, database, table):
    cursor = connection.cursor()
    use_database = """USE {};""".format(database)
    read_data = """SELECT * FROM {};""".format(table)
    
    cursor.execute(use_database)
    cursor.execute(read_data)
    result = cursor.fetchall()
    col = cursor.column_names
    # print(type(col))
    # print(type(result))
    print(col)
    for row in result:
        print(row)
    
    cursor.close()
    connection.close()
    
    

if __name__ == '__main__':
    connection = connect()
    # update(connection, "Company_3")
    # delete(connection, "Company_3")
    read(connection, "Company_3", "MenuItems")
    