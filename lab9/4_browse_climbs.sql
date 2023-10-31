/*
  Lab 09.4: Browse Climbs
  CSC 362 - Database Systems
  By Cooper Hendrix

  Write SQL code which will produce the output table seen on the browse climbs page.
*/
CREATE TEMPORARY TABLE proto AS 
SELECT climbs.climb_name, 
       climb_grades.grade_str, 
       climbs.climb_len_ft, 
       climbs.crag_name, 
       climbers.climber_first_name AS 'FirstNameFA', 
       climbers.climber_last_name AS 'LastNameFA', 
       developed_climbs.climber_id AS 'developed_id'
FROM climbs
LEFT JOIN climb_grades
  ON climbs.climb_grade = climb_grades.grade_id
LEFT JOIN first_ascents
  USING (climb_id)
LEFT JOIN developed_climbs
  USING (climb_id)
LEFT JOIN climbers
  ON first_ascents.climber_id = climbers.climber_id;

SELECT proto.climb_name AS 'Name', 
       proto.grade_str AS 'Grade', 
       COALESCE(proto.climb_len_ft, '') AS "Length (ft)", 
       proto.crag_name AS 'Crag', 
       COALESCE(GROUP_CONCAT(DISTINCT CONCAT(proto.FirstNameFA, " ", proto.LastNameFA)), '') AS "First ascent by", 
       COALESCE(GROUP_CONCAT(DISTINCT CONCAT(climbers.climber_first_name, " ", climbers.climber_last_name)), '') AS "Equipped by" 
FROM proto
LEFT JOIN climbers
  ON proto.developed_id = climbers.climber_id
GROUP BY proto.climb_name;

DROP TABLE proto;