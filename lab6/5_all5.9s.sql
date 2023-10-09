/*
  Lab 06.5: All 5.9s
  CSC 362 - Database Systems
  By Cooper Hendrix

  Shown the name, grade, length, crag, and region of every climb graded "5.9".
*/

USE red_river_climbs;

SELECT climb_name, grade_str, climb_len_ft, crag_name, region_name FROM climbs
LEFT JOIN climb_grades ON climb_grade = grade_id
NATURAL JOIN crags
WHERE grade_str = 5.9;
