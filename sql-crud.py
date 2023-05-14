import mysql.connector as connector

def mysql_connect(username, pass_word):
    try:
        connection = connector.connect(user = username, password = pass_word, auth_plugin="mysql_native_password")
        print("Database connected successfully")
    except:
        print("Cannot connect to the database. Please check the username and password.")
    return connection


def mysql_create(connection, database, table_1, table_2, table_3, table_4):
    cursor = connection.cursor()
    create_database = """CREATE DATABASE IF NOT EXISTS {};""".format(database)
    use_database = """USE {};""".format(database)
    create_table_1 = """
        CREATE TABLE {} (
        ItemID INT AUTO_INCREMENT,
        Name VARCHAR(200),
        Type VARCHAR(100),
        Price INT,
        PRIMARY KEY (ItemID)
        );""".format(table_1)
        
    create_table_2 = """
        CREATE TABLE {} (
        MenuID INT,
        ItemID INT,
        Cuisine VARCHAR(100),
        PRIMARY KEY (MenuID,ItemID)
        );""".format(table_2)
    
    create_table_3 = """
        CREATE TABLE {} (
        BookingID INT AUTO_INCREMENT,
        TableNo INT,
        GuestFirstName VARCHAR(100) NOT NULL,
        GuestLastName VARCHAR(100) NOT NULL,
        BookingSlot TIME NOT NULL,
        EmployeeID INT,
        PRIMARY KEY (BookingID)
        );""".format(table_3)
        
    create_table_4 = """
        CREATE TABLE {} (
        OrderID INT,
        TableNo INT,
        MenuID INT,
        BookingID INT,
        BillAmount INT,
        Quantity INT,
        PRIMARY KEY (OrderID,TableNo)
        );""".format(table_4)
        
        
    insert_table_1 = """
        INSERT INTO {} VALUES
        (1,'Olives','Starters',5),
        (2,'Flatbread','Starters', 5),
        (3, 'Minestrone', 'Starters', 8),
        (4, 'Tomato bread','Starters', 8),
        (5, 'Falafel', 'Starters', 7),
        (6, 'Hummus', 'Starters', 5),
        (7, 'Greek salad', 'Main Courses', 15),
        (8, 'Bean soup', 'Main Courses', 12),
        (9, 'Pizza', 'Main Courses', 15),
        (10,'Greek yoghurt','Desserts', 7),
        (11, 'Ice cream', 'Desserts', 6),
        (12, 'Cheesecake', 'Desserts', 4),
        (13, 'Athens White wine', 'Drinks', 25),
        (14, 'Corfu Red Wine', 'Drinks', 30),
        (15, 'Turkish Coffee', 'Drinks', 10),
        (16, 'Turkish Coffee', 'Drinks', 10),
        (17, 'Kabasa', 'Main Courses', 17);""".format(table_1)
    
    insert_table_2 = """
        INSERT INTO {} VALUES
        (1, 1, 'Greek'),
        (1, 7, 'Greek'),
        (1, 10, 'Greek'),
        (1, 13, 'Greek'),
        (2, 3, 'Italian'),
        (2, 9, 'Italian'),
        (2, 12, 'Italian'),
        (2, 15, 'Italian'),
        (3, 5, 'Turkish'),
        (3, 17, 'Turkish'),
        (3, 11, 'Turkish'),
        (3, 16, 'Turkish');""".format(table_2)
        
    insert_table_3 = """
        INSERT INTO {} (BookingID, TableNo, GuestFirstName, 
        GuestLastName, BookingSlot, EmployeeID)
        VALUES
        (1,12,'Anna','Iversen','19:00:00',1),
        (2, 12, 'Joakim', 'Iversen', '19:00:00', 1),
        (3, 19, 'Vanessa', 'McCarthy', '15:00:00', 3),
        (4, 15, 'Marcos', 'Romero', '17:30:00', 4),
        (5, 5, 'Hiroki', 'Yamane', '18:30:00', 2),
        (6, 8, 'Diana', 'Pinto', '20:00:00', 5);""".format(table_3)
    
    insert_table_4 = """
        INSERT INTO {} (OrderID, TableNo, MenuID, BookingID, Quantity, BillAmount)
        VALUES
        (1, 12, 1, 1, 2, 86),
        (2, 19, 2, 2, 1, 37),
        (3, 15, 2, 3, 1, 37),
        (4, 5, 3, 4, 1, 40),
        (5, 8, 1, 5, 1, 43);""".format(table_4)
    
    cursor.execute(create_database)
    cursor.execute(use_database)
    print("Current using database: {}".format(connection.database))
    
    cursor.execute(create_table_1)
    print("{} table created successfully".format(table_1))
    cursor.execute(create_table_2)
    print("{} table created successfully".format(table_2))
    cursor.execute(create_table_3)
    print("{} table created successfully".format(table_3))
    cursor.execute(create_table_4)
    print("{} table created successfully".format(table_4))
    
    cursor.execute(insert_table_1)
    connection.commit()
    print("Data inserted in table {}.".format(table_1))
    cursor.execute(insert_table_2)
    connection.commit()
    print("Data inserted in table {}.".format(table_2))
    cursor.execute(insert_table_3)
    connection.commit()
    print("Data inserted in table {}.".format(table_3))
    cursor.execute(insert_table_4)
    connection.commit()
    print("Data inserted in table {}.".format(table_4))
    cursor.close()
    



def mysql_read(connection, database, table, row_limit):
    cursor = connection.cursor()
    use_database = """USE {};""".format(database)
    read_data = """SELECT * FROM {} LIMIT {};""".format(table, row_limit)
    
    cursor.execute(use_database)
    cursor.execute(read_data)
    result = cursor.fetchall()
    col = cursor.column_names
    print(col)
    for row in result:
        print(row)
    
    
    cursor.close()
    connection.close()
    
    
    

    
if __name__ == "__main__":
    connection = mysql_connect("root", "Tchen226")
    # mysql_create(connection, "Company_3", "MenuItems", "Menus", "Bookings", "Orders")
    mysql_read(connection, "Company_3", "MenuItems", 5)