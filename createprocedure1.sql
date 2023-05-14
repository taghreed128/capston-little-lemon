USE LittleLemonDB;


DROP PROCEDURE GetMaxQuantity;
DROP PROCEDURE CancelOrder;
DROP PREPARE GetOrderDetail;


-- Create GetMaxQuantity procedure
CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(order_quantity) AS 'Max Quantity in Order'
FROM Orders;


-- Create CancelOrder procedure
CREATE PROCEDURE CancelOrder(IN ID INT)
DELETE FROM Orders
WHERE order_id = ID;


-- Create GetOrderDetail prepared statement
PREPARE GetOrderDetail FROM 
"SELECT order_id AS OrderID, 
        order_quantity AS Quantity, 
        total_cost AS Cost 
FROM Orders
WHERE order_id = ?"
