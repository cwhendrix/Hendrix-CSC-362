/*
    Lab 03: Tables & Fields in SQL
    CSC 362: Database Systems
    By Cooper Hendrix

    This script creates the movie_ratings database, a database designed to store information about movie ratings.
    Sample data has been inserted into the three constituent tables.
    Later, the database is wiped and re-implemented in order to fix a major design flaw present in the original
    design (the inclusion of a multiplart field).
*/

/* Drop the existing database, if it happens to exist. */
DROP DATABASE IF EXISTS movie_ratings;

/* Create movie_ratings database! */
CREATE DATABASE movie_ratings;
USE movie_ratings;

/* Create Movies table */
CREATE TABLE movies (
    PRIMARY KEY (movie_id),
    movie_id            INT         AUTO_INCREMENT,
    movie_title         VARCHAR(32) NOT NULL,
    movie_release_date  DATE        NOT NULL,
    movie_genre         VARCHAR(64) NOT NULL
);

/* Create Consumers table */
CREATE TABLE consumers (
    PRIMARY KEY (consumer_id),
    consumer_id             INT         AUTO_INCREMENT,
    consumer_first_name     VARCHAR(32) NOT NULL,
    consumer_last_name      VARCHAR(32) NOT NULL,
    consumer_address        VARCHAR(32) NOT NULL,
    consumer_city           VARCHAR(32) NOT NULL,
    consumer_state          VARCHAR(2)  NOT NULL,
    consumer_zip            VARCHAR(5)  NOT NULL
);

/* Create Ratings table */
/* We can use consumer_id and rating_date to uniquely identify each record
   because no single consumer can make 2 ratings at the same time */
CREATE TABLE ratings (
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (consumer_id) REFERENCES consumers(consumer_id),
    PRIMARY KEY(consumer_id, rating_date),
    movie_id                INT         NOT NULL,
    consumer_id             INT         NOT NULL,
    rating_date             DATETIME    NOT NULL,
    rating_stars            INT         NOT NULL
);

/*
SHOW CREATE TABLE movies;
SHOW CREATE TABLE consumers;
SHOW CREATE TABLE ratings;
*/

/* Insert records into Movies */
INSERT INTO movies (movie_title, movie_release_date, movie_genre)
VALUES  ('The Hunt for Red October', '1990-03-02', 'Action, Adventure, Thriller'),
        ('Lady Bird', '2017-12-01', 'Comedy, Drama'),
        ('Inception', '2010-08-16', 'Action, Adventure, Science Fiction'),
        ('Monty Python and the Holy Grail', '1975-04-03', "Comedy");
/* Test */
-- SELECT * FROM movies;

/* Insert records into consumers */
INSERT INTO consumers (consumer_first_name, consumer_last_name, consumer_address, consumer_city, consumer_state, consumer_zip)
VALUES  ('Toru', 'Okada', '800 Glenridge Ave', 'Hobart', 'IN', '46343'),
        ('Kumiko', 'Okada', '864 NW Bohemia St', 'Vincetown', 'NJ', '08088'),
        ('Noboru', 'Wataya', '342 Joy Ridge St', 'Hermitage', 'TN', '37076'),
        ('May', 'Kasahara', '5 Kent Rd', 'East Haven', 'CT', '06512');
/* Test */
-- SELECT * FROM consumers;

/* Insert records into ratings */
INSERT INTO ratings (movie_id, consumer_id, rating_date, rating_stars)
VALUES  (1, 1, '2010-09-02 10:54:19', 4),
        (1, 3, '2012-08-05 15:00:01', 3),
        (1, 4, '2016-10-02 23:58:12', 1),
        (2, 3, '2017-03-27 00:12:48', 2),
        (2, 4, '2018-08-02 00:54:42', 4);
/* Test */
-- SELECT * FROM ratings;

/* Generate a report */
SELECT consumer_first_name, consumer_last_name, movie_title, rating_stars
FROM movies
NATURAL JOIN ratings
NATURAL JOIN consumers;

/******* ISSUE WITH THE DESIGN *******/
-- the movies table has a multipart field (movie_genres). 
-- we can instead implement the genres with a linking table and validation table. 
-- the linking table will be called movie_genres and the validation table will be genres.

/******* REDESIGNED TABLES *******/
/* Drop the existing database so we can recreate it, new and improved. */
DROP DATABASE IF EXISTS movie_ratings;

/* Create (new) movie_ratings database */
CREATE DATABASE movie_ratings;
USE movie_ratings;

/* Create Movies table */
CREATE TABLE movies (
    PRIMARY KEY (movie_id),
    movie_id            INT         AUTO_INCREMENT,
    movie_title         VARCHAR(32) NOT NULL,
    movie_release_date  DATE        NOT NULL
);

/* Create Genres table */
/* This is the validation table for the movie genres, and is a part of the
   solution to prevent the need for a multipart field in the movies table. */
CREATE TABLE genres (
    PRIMARY KEY (genre_id),
    genre_id            INT         AUTO_INCREMENT,
    genre_name          VARCHAR(32) NOT NULL
);

/* Create Movie Genres Table */
/* This is the linking table which will prevent the need for a multipart field
   in the movies table. */
CREATE TABLE movie_genres (
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    PRIMARY KEY (movie_id, genre_id),
    movie_id            INT         NOT NULL,
    genre_id            INT         NOT NULL
);

/* Create Consumers table */
CREATE TABLE consumers (
    PRIMARY KEY (consumer_id),
    consumer_id             INT         AUTO_INCREMENT,
    consumer_first_name     VARCHAR(32) NOT NULL,
    consumer_last_name      VARCHAR(32) NOT NULL,
    consumer_address        VARCHAR(32) NOT NULL,
    consumer_city           VARCHAR(32) NOT NULL,
    consumer_state          VARCHAR(2)  NOT NULL,
    consumer_zip            VARCHAR(5)  NOT NULL
);

/* Create Ratings table */
/* We can use consumer_id and rating_date to uniquely identify each record
   because no single consumer can make 2 ratings at the same time */
CREATE TABLE ratings (
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (consumer_id) REFERENCES consumers(consumer_id),
    PRIMARY KEY(consumer_id, rating_date),
    movie_id                INT         NOT NULL,
    consumer_id             INT         NOT NULL,
    rating_date             DATETIME    NOT NULL,
    rating_stars            INT         NOT NULL
);

/* Insert records into Movies */
INSERT INTO movies (movie_title, movie_release_date)
VALUES  ('The Hunt for Red October', '1990-03-02'),
        ('Lady Bird', '2017-12-01'),
        ('Inception', '2010-08-16'),
        ('Monty Python and the Holy Grail', '1975-04-03');
/* Test */
-- SELECT * FROM movies;

/* Insert records into Genres */
INSERT INTO genres (genre_name)
VALUES  ('Action'),
        ('Adventure'),
        ('Comedy'),
        ('Science Fiction'),
        ('Thriller'),
        ('Drama');
/* Test */
-- SELECT * FROM genres;

/* Insert records into Movie Genres */
INSERT INTO movie_genres (movie_id, genre_id)
VALUES  (1, 1),
        (1, 2),
        (1, 5),
        (2, 3),
        (2, 6),
        (3, 1),
        (3, 2),
        (3, 4),
        (4, 3);
/* Test */
-- SELECT * FROM movie_genres;

/* Insert records into consumers */
INSERT INTO consumers (consumer_first_name, consumer_last_name, consumer_address, consumer_city, consumer_state, consumer_zip)
VALUES  ('Toru', 'Okada', '800 Glenridge Ave', 'Hobart', 'IN', '46343'),
        ('Kumiko', 'Okada', '864 NW Bohemia St', 'Vincetown', 'NJ', '08088'),
        ('Noboru', 'Wataya', '342 Joy Ridge St', 'Hermitage', 'TN', '37076'),
        ('May', 'Kasahara', '5 Kent Rd', 'East Haven', 'CT', '06512');
/* Test */
-- SELECT * FROM consumers;

/* Insert records into ratings */
INSERT INTO ratings (movie_id, consumer_id, rating_date, rating_stars)
VALUES  (1, 1, '2010-09-02 10:54:19', 4),
        (1, 3, '2012-08-05 15:00:01', 3),
        (1, 4, '2016-10-02 23:58:12', 1),
        (2, 3, '2017-03-27 00:12:48', 2),
        (2, 4, '2018-08-02 00:54:42', 4);
/* Test */
-- SELECT * FROM ratings;