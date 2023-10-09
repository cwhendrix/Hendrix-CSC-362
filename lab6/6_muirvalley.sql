/*
  Lab 06.6: Muir Valley Grades
  CSC 362 - Database Systems
  By Cooper Hendrix

  What climbing grades can be found on land owned by "John and Elizabeth Muir"?
*/

USE red_river_climbs;

SELECT grade_str FROM owners
NATURAL JOIN regions
NATURAL JOIN crags
NATURAL JOIN climbs
LEFT JOIN climb_grades ON climb_grade = grade_id
WHERE owner_name = "John and Elizabeth Muir";