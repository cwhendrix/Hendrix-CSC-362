/*
  Lab 05: Carpet Database Implementation
  CSC 362 - Database Systems
  By Cooper Hendrix
*/

/* Drop the store database if it exists, then make it */
DROP DATABASE IF EXISTS store;
CREATE DATABASE store;
USE store;

/* Create validation tables Countries, Styles, Materials */
CREATE TABLE carpet_countries (
    PRIMARY KEY (carpet_country),
    carpet_country      VARCHAR(32)
);

CREATE TABLE carpet_styles (
    PRIMARY KEY (carpet_style),
    carpet_style        VARCHAR(32)
);

CREATE TABLE carpet_materials (
    PRIMARY KEY (carpet_material),
    carpet_material     VARCHAR(32)
);

/* Create carpets table! :) */
CREATE TABLE carpets (
    PRIMARY KEY (carpet_id),
    FOREIGN KEY (carpet_country) REFERENCES carpet_countries(carpet_country),
    FOREIGN KEY (carpet_style) REFERENCES carpet_styles(carpet_style),
    FOREIGN KEY (carpet_material) REFERENCES carpet_materials(carpet_material),
    carpet_id       INT         AUTO_INCREMENT,
    carpet_country  VARCHAR(32) NOT NULL,
    carpet_style    VARCHAR(32) NOT NULL,
    carpet_year     VARCHAR(4)  NOT NULL,
    carpet_material VARCHAR(32) NOT NULL,
    carpet_lengthft INT         NOT NULL,
    carpet_widthft  INT         NOT NULL,
    carpet_acq_date DATE        NOT NULL,
    carpet_purchase FLOAT       NOT NULL,
    carpet_markup   FLOAT       NOT NULL,
    carpet_active   BOOLEAN     NOT NULL
);
--SHOW CREATE TABLE carpets;

/* Create customers table :) */
CREATE TABLE customers (
    PRIMARY KEY (customer_id),
    customer_id         INT         AUTO_INCREMENT,
    customer_firstname  VARCHAR(32) NOT NULL,
    customer_lastname   VARCHAR(32) NOT NULL,
    customer_address    VARCHAR(32) NOT NULL,
    customer_city       VARCHAR(32) NOT NULL,
    customer_state      VARCHAR(2)  NOT NULL,
    customer_zip        VARCHAR(5)  NOT NULL,
    customer_phone      VARCHAR(32) NOT NULL,
    customer_active     BOOLEAN     NOT NULL
);
--SHOW CREATE TABLE customers;

/* Create table sales */
CREATE TABLE sales (
    PRIMARY KEY(carpet_id, customer_id, sell_date),
    FOREIGN KEY (carpet_id) REFERENCES carpets(carpet_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    carpet_id       INT         NOT NULL,
    customer_id     INT         NOT NULL,
    sell_date       DATETIME    NOT NULL,
    sale_price      FLOAT       NOT NULL,
    sale_return_date DATETIME
);
--SHOW CREATE TABLE sales;

/* Create returns table */
CREATE TABLE returns (
    PRIMARY KEY(carpet_id, customer_id, rental_date),
    FOREIGN KEY (carpet_id) REFERENCES carpets(carpet_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    carpet_id       INT         NOT NULL,
    customer_id     INT         NOT NULL,
    rental_date     DATETIME    NOT NULL,
    rental_due_date DATETIME    NOT NULL,
    rental_return   DATETIME
);
-- SHOW CREATE TABLE returns;

/* Put in values :) */
INSERT INTO carpet_countries (carpet_country)
VALUES  ('Iran'),
        ('India'),
        ('Turkey');

INSERT INTO carpet_styles (carpet_style)
VALUES  ('Ushak'),
        ('Tabriz'),
        ('Agra');

INSERT INTO carpet_materials (carpet_material)
VALUES  ('Wool'),
        ('Silk');

INSERT INTO carpets (carpet_country, carpet_style, carpet_year, carpet_material, carpet_lengthft, carpet_widthft, carpet_acq_date, carpet_purchase, carpet_markup, carpet_active)
VALUES  ('Turkey', 'Ushak', '1925', 'Wool', 5, 7, '2017-04-06', 625, 100, TRUE),
        ('Iran', 'Tabriz', '1910', 'Silk', 10, 14, '2017-04-06', 28000, 75, TRUE);