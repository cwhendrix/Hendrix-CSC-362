DELIMITER //

CREATE OR REPLACE PROCEDURE add_customer(
    IN cust_fname VARCHAR(64),
    IN cust_lname VARCHAR(64),
    IN cust_email VARCHAR(64),
    IN cust_lat FLOAT,
    IN cust_long FLOAT,
    IN dish_1_id INT,
    IN dish_1_quant INT
)
BEGIN
    DECLARE DishQuantityCounter INT;

INSERT INTO Customers (CustomerFirstName, CustomerLastName, CustomerEmail, CustomerDefaultLat, CustomerDefaultLong)
VALUES  (cust_fname, cust_lname, cust_email, cust_lat, cust_long);

CALL add_order(LAST_INSERT_ID(), cust_lat, cust_long);

-- 
SET DishQuantityCounter = 1;
REPEAT 
    INSERT INTO OrderDishes (DishID, OrderID, DishNotes) 
    VALUES (LAST_INSERT_ID(), dish_1_id, "FirstOrderDishNotes");
    SET DishQuantityCounter = DishQuantityCounter + 1;
UNTIL DishQuantityCounter > dish_1_quant END REPEAT;
-- 




END;
//
DELIMITER ;
GRANT EXECUTE ON PROCEDURE robo_rest_fall_2023.add_customer TO 'webuser'@'localhost';