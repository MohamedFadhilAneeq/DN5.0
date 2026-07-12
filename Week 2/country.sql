-- Create the schema and switch to it
CREATE SCHEMA ormlearn;
USE ormlearn;

-- Create the country table
CREATE TABLE country(co_code varchar(2) primary key, co_name varchar(50));

-- Insert sample data
INSERT INTO country VALUES ('IN', 'India');
INSERT INTO country VALUES ('US', 'United States of America');