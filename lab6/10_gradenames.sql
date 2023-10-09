/*
  Lab 06.10: Grades at Names
  CSC 362 - Database Systems
  By Cooper Hendrix

  Show the grade strings and names of all the routes at each difficulty level. If there are no routes at a given difficulty level, that level need not appear in the output.
*/

SELECT grade_str, GROUP_CONCAT(climb_name) FROM climbs
LEFT JOIN climb_grades ON climbs.climb_grade = climb_grades.grade_id
GROUP BY grade_str;