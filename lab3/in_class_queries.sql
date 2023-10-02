/*
    In Class Queries
    CSC 362: Database Systems
    By Cooper Hendrix

    Queries written in class on 10-2-2023
*/

USE movie_ratings;

/* Show all movies in database */
SELECT movie_title
    FROM movies;

/* Show all anonymous star ratings for each movie title */
SELECT movie_title, rating
    FROM movies 
        NATURAL JOIN ratings;

SELECT movie_title, rating
    FROM movies
        INNER JOIN ratings
        USING (movie_id);

SELECT movie_title, rating
    FROM movies
        INNER JOIN ratings
        ON movies.movie_id = ratings.movie_id;

/* Show every person on the database and any movies they've rated, if any */
SELECT consumer_first_name, consumer_last_name, movie_title
    FROM consumers
        LEFT OUTER JOIN ratings
        USING (consumer_id)
        LEFT OUTER JOIN movies
        USING (movie_id);

/* Number of times each movie has been reviewed */
SELECT movie_title AS 'Movie Title', COUNT(rating_id) AS '# Ratings'
    FROM movies
        INNER JOIN ratings
        USING (movie_id)
GROUP BY movie_id;

/* Show all users with more than 2 ratings */
SELECT customer_firstname, customer_lastname, COUNT(rating)
    FROM consumers 
        INNER JOIN ratings
        USING (consumer_id)
GROUP BY (consumer_id)
HAVING COUNT(rating) > 2;

/* Show 3 reviewers with the most reviews */
SELECT customer_firstname, customer_lastname, COUNT(rating)
    FROM consumers 
        INNER JOIN ratings
        USING (consumer_id)
GROUP BY (consumer_id)
ORDER BY COUNT(rating) DESC
LIMIT 3;
