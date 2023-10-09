/*
  Lab 06.8: Miller Fork Developers
  CSC 362 - Database Systems
  By Cooper Hendrix

  Show the first and last names (as separate columns) of everyone who has developed a climb in the 'Miller Fork' Region. Each name should only be shown once.
*/

SELECT climber_first_name, climber_last_name FROM climbers
LEFT JOIN developed_climbs ON climbers.climber_id = developed_climbs.climber_id
LEFT JOIN climbs ON developed_climbs.climb_id = climbs.climb_id
LEFT JOIN crags ON climbs.crag_name = crags.crag_name
WHERE region_name = 'Miller Fork'
GROUP BY climber_first_name;