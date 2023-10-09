/*
  Lab 06.9: Grade Count
  CSC 362 - Database Systems
  By Cooper Hendrix

  Show the number of routes at each difficulty level in the database. If there are no routes at a given difficulty level, the output should explicitly show 0.
*/
SELECT grade_str, COUNT(climb_grade) FROM climb_grades
LEFT JOIN climbs ON climb_grades.grade_id = climbs.climb_grade
GROUP BY grade_str;