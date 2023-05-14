USE LittleLemonDB;


-- Add data to the Staffs table (Foreign key constraint)
INSERT INTO Staffs
VALUES 
(1, 'Tyler', 'Chen', 'Full-time', 40000, 'Manager');


-- Add data to the Customers table (Foreign key constraint)
INSERT INTO Customers
VALUES
(1,'James','Guo','0900-000-000'),
(2,'Charley','Jones','0911-111-111'),
(3,'Amy','MccAa','0922-222-222');



-- Add data to the Bookings table
INSERT INTO Bookings (booking_id, booking_date, table_num, customer_id, staff_id)
VALUES 
(1, '2022-10-10', 5, 1, 1),
(2, '2022-11-12', 3, 3, 1),
(3, '2022-10-11', 2, 2, 1),
(4, '2022-10-13', 2, 1, 1);



-- To create the Checkbooking procedure
DROP PROCEDURE CheckBooking;
DELIMITER &&
CREATE PROCEDURE CheckBooking(IN book_date DATE, IN table_num INT)
IF table_num IN (SELECT table_num FROM Bookings) THEN 
    SELECT CONCAT('Table ', CAST(table_num AS CHAR), ' is already booked')
    FROM Bookings;
ELSE 
    INSERT INTO Bookings
    VALUES ((SELECT COUNT(*) FROM Bookings) + 1, book_date, table_num, 1, 1);
END IF &&
DELIMITER ;


-- To create AddValidBooking procedure
DROP PROCEDURE AddValidBooking;
DELIMITER &&
CREATE PROCEDURE AddValidBooking(IN book_date DATE, IN table_num INT)
BEGIN
    START TRANSACTION;
    IF table_num IN (SELECT table_num FROM Bookings) THEN 
        ROLLBACK;
        SELECT CONCAT('Table ', CAST(table_num AS CHAR), ' is already booked - booking cancelled')
        FROM Bookings;
    ELSE 
        INSERT INTO Bookings
        VALUES ((SELECT COUNT(*) FROM Bookings) + 1, book_date, table_num, 1, 1);
        COMMIT;
    END IF &&
END
DELIMITER ;
