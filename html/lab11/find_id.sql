DELIMITER //

CREATE OR REPLACE PROCEDURE find_id(
    IN fname VARCHAR(64),
    IN lname VARCHAR(64)
)
BEGIN

SELECT CustomerID FROM Customers
WHERE fname = CustomerFirstName AND lname = CustomerLastName;

END;
//
DELIMITER ;
GRANT EXECUTE ON PROCEDURE robo_rest_fall_2023.find_id TO 'webuser'@'localhost';