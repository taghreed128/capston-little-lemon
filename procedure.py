import mysql.connector as connector


def connect():
    username = input("Please enter the usermame: ")
    pass_word = input("Enter password: ")
    try:
        conn = connector.connect(user = username, password = pass_word, )
        print("Database connected succesfully")
    except:
        print("Failed to connect to the database")
    return conn
        
def store_procedure(connection, procedureName):
    cursor = connection.cursor()
    use_database = """USE Company_3;"""
    drop_procedure = """DROP PROCEDURE IF EXISTS {};""".format(procedureName)
    create_procedure = """CREATE PROCEDURE {}()
    SELECT CONCAT(GuestFirstName, GuestLastName) AS Guest
    FROM Orders RIGHT JOIN Bookings
    ON Orders.BookingID = Bookings.BookingID
    WHERE Orders.BillAmount IS NULL;
    """.format(procedureName)
    

    cursor.execute(use_database)
    cursor.execute(drop_procedure)
    cursor.execute(create_procedure)
    cursor.callproc(procedureName)
    print("The procedure {} called successfully".format(procedureName))
    
    result_1 = cursor.stored_results()
    result_2 = next(result_1)

    dataset = result_2.fetchall()
    # print(type(result_1))
    # print(type(result_2))
    # print(type(dataset))

    for row in dataset:
        print(row)
    
    cursor.close()
    
    
    




if __name__ == "__main__":
    conn = connect()
    store_procedure(conn, "Noarrival")
    conn.close()