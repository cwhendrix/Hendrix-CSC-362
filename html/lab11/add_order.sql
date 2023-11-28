DELIMITER //

CREATE OR REPLACE PROCEDURE add_order(
    IN cust_id INT,
    IN location_lat FLOAT,
    IN location_long FLOAT
)
BEGIN
INSERT INTO Orders (FranchiseID, CustomerID, DeliveryLocationLat, DeliveryLocationLon)
VALUES  (1, cust_id, location_lat, location_long);
END;
//
DELIMITER ;