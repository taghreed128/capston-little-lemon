USE LittleLemonDB;


-- Create new procedure AddBooking
DROP PROCEDURE AddBooking;
DELIMITER &&
CREATE PROCEDURE AddBooking(IN booking_date DATE, IN table_num INT, IN customer_id INT)
INSERT INTO Bookings 
VALUES (6,
         booking_date,
         table_num,
         customer_id,
         1
) &&
DELIMITER ;


-- Below Statement For PROCEDURE testing
-- CALL AddBooking('2012-10-13', 5, 2);
-- SELECT * FROM Bookings;



-- Create procedure UpdateBooking
DROP PROCEDURE UpdateBooking;
DELIMITER &&
CREATE PROCEDURE UpdateBooking(IN id INT, IN date DATE) 
UPDATE Bookings
SET booking_date = date
WHERE booking_id = id &&
DELIMITER ;


-- Below Statement For PROCEDURE testing
-- CALL UpdateBooking(2,'2022-11-15');
-- SELECT * FROM Bookings;





-- Create procedure CancelBooking
DROP PROCEDURE CancelBooking;
DELIMITER &&
CREATE PROCEDURE CancelBooking(IN id INT)
DELETE FROM Bookings
WHERE booking_id = id &&
DELIMITER ;


-- Below Statement For PROCEDURE testing
-- CALL CancelBooking(6);
-- SELECT * FROM Bookings;
