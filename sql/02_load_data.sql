-- Load Netflix dataset into MySQL
-- Dataset source:
-- https://www.kaggle.com/datasets/rahulvyasm/netflix-movies-and-tv-shows

USE netflix_project;

-- Load CSV file into the raw table
LOAD DATA LOCAL INFILE 'PATH_TO_YOUR_FILE/netflix_titles.csv'
INTO TABLE netflix_titles
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Verify that the data loaded correctly
SELECT COUNT(*) AS total_rows
FROM netflix_titles;
