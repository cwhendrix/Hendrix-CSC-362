/*
  Lab 06.3: Slab City Sport
  CSC 362 - Database Systems
  By Cooper Hendrix

  Show the name and grade of all sport climbs at the "Slab City" crag.
*/

USE red_river_climbs;

SELECT climb_name, grade_str from sport_climbs
NATURAL JOIN climbs
LEFT JOIN climb_grades ON climb_grade = grade_id
WHERE crag_name = 'Slab City';