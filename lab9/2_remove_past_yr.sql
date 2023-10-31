/*
  Lab 09.2: Remove Past Year
  CSC 362 - Database Systems
  By Cooper Hendrix

  Remove all routes from the database which were equipped in the past year.
*/

USE red_river_climbs;

SELECT * FROM developed_climbs WHERE developed_date > DATEADD(year,-1,GETDATE());