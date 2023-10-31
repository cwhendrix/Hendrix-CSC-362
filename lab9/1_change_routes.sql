/*
  Lab 09.1: Change 5.10 Routes
  CSC 362 - Database Systems
  By Cooper Hendrix

  Change all routes graded "5.10" to grade "5.10a". The statement should use "5.10" and "5.10a" directly, not grade_ids.
*/

USE red_river_climbs;

SELECT * FROM climb_grades
WHERE grade_id = 11;

UPDATE climb_grades
  SET  grade_str = "5.10a"
WHERE  grade_id = 11;

SELECT * FROM climb_grades
WHERE grade_id = 11;