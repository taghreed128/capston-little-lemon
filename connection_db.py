import mysql.connector as connector
from mysql.connector import errorcode


# First create the function to connect the LittleLemon database
def database_connect():
    try:
        connection = connector.connect(username = 'root', password = 'Tchen226', db = 'LittleLemonDB',auth_plugin="mysql_native_password")
        print('Database connected succesfully !')
        
        return connection
    
    except connector.Error as er:
        print('Unable to connect to the datanase')
        print("Error code: {}".format(er.errno))
        print("Error message {}".format(er.msg))
    
    
    
    
# Second, create the function for query execution
def query_exe_1(connection):
    cursor = connection.cursor()
    query = 'SHOW TABLES;'
    cursor.execute(query)
    print("Query executed succesfully !")
    
    # To fetch and print the query result
    results = cursor.fetchall()
    col = cursor.column_names
    
    # Print the column name and results
    print(col)
    for row in results:
        print(results)
    
    # Close the cursor and spare it for the next query execution
    cursor.close()
    print("Cursor closed ! Ready for the next query ?")
    
    
 
def query_exe_2(connection):
    cursor =  connection.cursor()
    query = """
    SELECT CONCAT(c.first_name, c.last_name) AS Full_Name,
           c.phone_num AS Contact_info
    FROM Orders AS o
    INNER JOIN Customers As c
    ON o.customer_id = c.Customer_id
    WHERE o.total_cost > 60
    """
    
    cursor.execute(query)
    results = cursor.fetchall()
    col = cursor.column_names
    print(col)
    for row in results:
        print(row)
    
    cursor.close()
    
 
    
# Execute functions inside the main function to enhance readibility
if __name__ == "__main__":
    connection = database_connect()
    query_exe_1(connection)
    query_exe_2(connection)
    