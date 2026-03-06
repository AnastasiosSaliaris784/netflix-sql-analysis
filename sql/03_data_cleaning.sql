-- Data cleaning and preparation

USE netflix_project;

-- Remove old cleaned tables if they already exist
DROP TABLE IF EXISTS netflix_cleaned;
DROP TABLE IF EXISTS netflix_final;

-- Create cleaned table with standardized date format
CREATE TABLE netflix_cleaned AS
SELECT
    show_id,
    type,
    title,
    director,
    `cast`,
    country,
    CASE
        WHEN date_added IS NULL OR TRIM(date_added) = '' THEN NULL
        WHEN TRIM(date_added) REGEXP '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{2}$'
            THEN STR_TO_DATE(TRIM(date_added), '%d-%b-%y')
        WHEN TRIM(date_added) REGEXP '^[A-Za-z]+ [0-9]{1,2}, [0-9]{4}$'
            THEN STR_TO_DATE(TRIM(date_added), '%M %e, %Y')
        ELSE NULL
    END AS date_added,
    release_year,
    rating,
    duration,
    listed_in,
    description
FROM netflix_titles;

-- Create final cleaned table
-- Fix rows where duration values were incorrectly placed in the rating column
CREATE TABLE netflix_final AS
SELECT
    show_id,
    type,
    title,
    director,
    `cast`,
    country,
    date_added,
    release_year,
    CASE
        WHEN rating LIKE '%min%' THEN NULL
        ELSE rating
    END AS rating,
    CASE
        WHEN rating LIKE '%min%' AND duration IS NULL THEN rating
        ELSE duration
    END AS duration,
    listed_in,
    description
FROM netflix_cleaned;

-- Data quality checks
SELECT COUNT(*) AS total_rows
FROM netflix_final;

SELECT COUNT(*) AS null_date_added
FROM netflix_final
WHERE date_added IS NULL;

SELECT COUNT(*) AS misplaced_rating_values
FROM netflix_final
WHERE rating LIKE '%min%';
