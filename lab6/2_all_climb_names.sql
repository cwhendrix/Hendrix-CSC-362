/*
  Lab 06.2: All Climb Names
  CSC 362 - Database Systems
  By Cooper Hendrix

  Show the name and location (crag name) of every climb in the database.
*/

USE red_river_climbs;

SELECT climb_name, crag_name FROM climbs;