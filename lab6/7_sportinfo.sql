/*
  Lab 06.7: Sport Info
  CSC 362 - Database Systems
  By Cooper Hendrix

  Show the climb name, number of bolts, and the nicknames (climber_handle) for all climbers in the FA party for every sport climb in the database. Each climb should have only one row in the output.
*/

USE red_river_climbs;

SELECT climb_name, climb_bolts, climber_handle FROM climbers
NATURAL JOIN first_ascents
NATURAL JOIN climbs
LEFT JOIN sport_climbs ON first_ascents.climb_id = sport_climbs.climb_id
WHERE climb_bolts IS NOT NULL;