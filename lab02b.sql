/*
  Lab 02: School Database
  CSC 362 Database Systems
  By Cooper Hendrix
*/

/* Create the database (dropping the previous version if necessary */
DROP DATABASE IF EXISTS school;

CREATE DATABASE school;

USE school;

/* Create Insturctors table */
CREATE TABLE instructors (
    PRIMARY KEY (instructor_id),
    instructor_id       INT AUTO_INCREMENT,
    inst_first_name     VARCHAR(20),
    inst_last_name      VARCHAR(20),
    campus_phone        VARCHAR(20)
);

/* Add values*/
INSERT INTO instructors (inst_first_name, inst_last_name, campus_phone)
VALUES  ('Kira', 'Bentley', '363-9948'),
        ('Timothy', 'Ennis', '527-4992'),
        ('Shannon', 'Black', '336-5992'),
        ('Estela', 'Rosales', '322-6992');

/* Display all rows */
SELECT * FROM instructors;
