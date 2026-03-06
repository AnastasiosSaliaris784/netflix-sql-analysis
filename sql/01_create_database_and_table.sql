-- Create database
CREATE DATABASE netflix_project;

-- Use database
USE netflix_project;

-- Create raw table
CREATE TABLE netflix_titles (
    show_id VARCHAR(10),
    type VARCHAR(10),
    title VARCHAR(255),
    director VARCHAR(255),
    `cast` TEXT,
    country VARCHAR(255),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(50),
    listed_in VARCHAR(255),
    description TEXT
);
