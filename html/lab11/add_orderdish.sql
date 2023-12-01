DELIMITER //

CREATE OR REPLACE PROCEDURE add_orderdish(
    IN cust_id INT,
    IN dish_id INT,
    IN dish_notes VARCHAR(50)
)
BEGIN

INSERT INTO OrderDishes (OrderID, DishID, DishNotes)
VALUES  (most_recent_order_for_customer(most_recent_customer()), dish_id, dish_notes);

END;
//
DELIMITER ;
GRANT EXECUTE ON PROCEDURE robo_rest_fall_2023.add_orderdish TO 'webuser'@'localhost';