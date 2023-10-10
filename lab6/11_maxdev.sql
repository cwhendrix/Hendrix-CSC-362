/*
  Lab 06.11: Maximum Developed Grades
  CSC 362 - Database Systems
  By Cooper Hendrix

  Show the maximum grade established by each developer. Each developer should appear only once.
*/
/*
CREATE VIEW max_ids AS
SELECT climber_first_name, climber_last_name, MAX(grade_id) AS max_grade
  FROM climbers
       NATURAL JOIN developed_climbs
       NATURAL JOIN climbs
       LEFT JOIN climb_grades ON climbs.climb_grade = climb_grades.grade_id
 GROUP BY climber_id;
*/

 SELECT climber_first_name, climber_last_name, grade_str
   FROM (SELECT climber_first_name, climber_last_name, MAX(grade_id) AS max_grade
  FROM climbers
       NATURAL JOIN developed_climbs
       NATURAL JOIN climbs
       LEFT JOIN climb_grades ON climbs.climb_grade = climb_grades.grade_id
 GROUP BY climber_id
) AS max_ids
        LEFT JOIN climb_grades ON max_ids.max_grade = climb_grades.grade_id;