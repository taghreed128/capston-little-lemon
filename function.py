import mysql.connector as connector



def connect():
    username = input("Enter the username: ")
    pass_word = input("Enter the database password: ")
    try:
        connection = connector.connect(user = username, password = pass_word)
        print("Datanase connected succesfully")
    except:
        print("Cannot connect to the database")
    return connection



def read(connection, database):
    cursor = connection.cursor()
    use_query = """
        USE {};""".format(database)
    read_query = """
        SELECT 
        BookingID AS ID,
        UPPER(CONCAT(GuestFirstName,' ',GuestLastName)) 
        AS GuestFullName 
        FROM bookings;"""
        
    cursor.execute(use_query)
    print("The current using database is {}".format(connection.database))
    cursor.execute(read_query)
    result = cursor.fetchall()
    columns = cursor.column_names
    
    print(columns)
    for row in result:
        print(row)
    print("|________________________|")
    
    cursor.close()
    
    
    
def summary(connection, database):
    cursor = connection.cursor()
    use_database = """
        USE {};""".format(database)
    summary_query = """
        SELECT 
        COUNT(OrderID),
        SUM(Quantity),
        SUM(BillAmount)
        FROM Orders;
        """
    
    cursor.execute(use_database)
    cursor.execute(summary_query)
    result = cursor.fetchall()

    for row in result:
        print("Numbers of order today: {}".format(row[0]))
        print("Ordered quantity today: {}".format(row[1]))
        print("Today's income: ${}".format(row[2]))
        
    cursor.close()
    
    
    
    
if __name__ == "__main__":
    connection = connect()
    read(connection, "Company_3")
    summary(connection, "Company_3")
    connection.close()
    