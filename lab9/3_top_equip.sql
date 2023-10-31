/*
  Lab 09.3: Top Equippers
  CSC 362 - Database Systems
  By Cooper Hendrix

  Produce a list of the top three route equippers in the database, and the number of routes they have helped to establish. 
  The output should contain only the top three equippers, in decreasing order by number of routes.
*/

SELECT climber_first_name, climber_last_name, COUNT(climb_id) FROM climbers
  LEFT JOIN developed_climbs USING (climber_id)
  GROUP BY climber_id
  ORDER BY COUNT(climb_id) DESC
  LIMIT 3;