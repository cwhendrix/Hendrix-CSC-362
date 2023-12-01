-- USAGE as prepared statement
-- SELECT most_recent_order_for_customer(?);
CREATE OR REPLACE FUNCTION most_recent_customer()
RETURNS INT
RETURN (
    SELECT CustomerID 
      FROM orders
     ORDER BY OrderSubmissionTime DESC
     LIMIT 1
);
GRANT EXECUTE ON PROCEDURE robo_rest_fall_2023.most_recent_customer TO 'webuser'@'localhost';