/*
    Lab 03: Tables & Fields in SQL
    CSC 362: Database Systems
    By Cooper Hendrix
*/

/* Drop the existing database, if it happens to exist. */
DROP IF EXISTS movie_ratings;

/* Create movie_ratings database! */
CREATE DATABASE movie_ratings;
USE movie_ratings;

/* Create Movies table */
CREATE TABLE movies (
    PRIMARY KEY (movie_id),
    movie_id            INT         AUTO_INCREMENT,
    movie_title         VARCHAR(32) NOT NULL,
    movie_release_date  DATE        NOT NULL,
    movie_genre         VARCHAR(32) NOT NULL
)

/* Create Consumers table */
CREATE TABLE consumers (
    PRIMARY KEY (consumer_id),
    consumer_id             INT         AUTO_INCREMENT,
    consumer_first_name     VARCHAR(32) NOT NULL,
    consumer_last_name      VARCHAR(32) NOT NULL,
    consumer_address        VARCHAR(32) NOT NULL,
    consumer_city           VARCHAR(32) NOT NULL,
    consumer_state          VARCHAR(2)  NOT NULL,
    consumer_zip            INT         NOT NULL
)

/* Create Ratings table */
CREATE TABLE ratings (
    
)