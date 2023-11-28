DELIMITER //

CREATE OR REPLACE PROCEDURE add_orderdish(
    IN order_id INT,
    IN dish_id INT,
    IN dish_notes VARCHAR(50)
)
BEGIN
INSERT INTO OrderDishes (OrderID, DishID, DishNotes)
VALUES  (order_id, dish_id, dish_notes);
END;
//
DELIMITER ;
GRANT EXECUTE ON PROCEDURE robo_rest_fall_2023.add_orderdish TO 'webuser'@'localhost';