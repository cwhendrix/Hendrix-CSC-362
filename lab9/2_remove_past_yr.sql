/*
  Lab 09.2: Remove Past Year
  CSC 362 - Database Systems
  By Cooper Hendrix

  Remove all routes from the database which were equipped in the past year.
*/

USE red_river_climbs;

DELIMITER //

CREATE OR REPLACE PROCEDURE remove_past_yr()
BEGIN
  SET FOREIGN_KEY_CHECKS = FALSE;
  DELETE climbs FROM climbs
    INNER JOIN developed_climbs
    USING (climb_id)
WHERE developed_climbs.developed_date > DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
SET FOREIGN_KEY_CHECKS = TRUE;
END //

DELIMITER ;

CALL remove_past_yr();