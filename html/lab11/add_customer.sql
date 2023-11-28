DELIMITER //

CREATE OR REPLACE PROCEDURE add_customer(
    IN cust_fname VARCHAR(64),
    IN cust_lname VARCHAR(64),
    IN cust_email VARCHAR(64),
    IN cust_lat FLOAT,
    IN cust_long FLOAT
)
BEGIN

INSERT INTO Customers (CustomerFirstName, CustomerLastName, CustomerEmail, CustomerDefaultLat, CustomerDefaultLong)
VALUES  (cust_fname, cust_lname, cust_email, cust_lat, cust_long);

END;
//
DELIMITER ;
GRANT EXECUTE ON PROCEDURE robo_rest_fall_2023.add_customer TO 'webuser'@'localhost';