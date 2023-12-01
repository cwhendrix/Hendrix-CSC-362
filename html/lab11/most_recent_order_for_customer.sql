
-- USAGE as prepared statement
-- SELECT most_recent_order_for_customer(?);
CREATE OR REPLACE FUNCTION most_recent_order_for_customer(cust_id INT)
RETURNS INT
RETURN (
    SELECT order_id 
      FROM orders WHERE CustomerID = cust_id
     ORDER BY OrderSubmissionTime DESC
     LIMIT 1
);
GRANT EXECUTE ON PROCEDURE robo_rest_fall_2023.most_recent_order_for_customer TO 'webuser'@'localhost';