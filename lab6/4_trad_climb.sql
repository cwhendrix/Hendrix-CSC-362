/*
  Lab 06.4: Traditional Climbs
  CSC 362 - Database Systems
  By Cooper Hendrix

  Show the name and grade of every traditional (trad) climb in the database.
*/

USE red_river_climbs;

SELECT climb_name, grade_str from trad_climbs
NATURAL JOIN climbs
LEFT JOIN climb_grades ON climb_grade = grade_id;