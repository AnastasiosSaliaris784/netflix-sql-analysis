-- Advanced analysis queries for the Netflix dataset

USE netflix_project;

-- 1. Movies vs TV Shows added per year
SELECT
    YEAR(date_added) AS year_added,
    SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movies_added,
    SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS tv_shows_added
FROM netflix_final
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added;


-- 2. Most common release years
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_final
GROUP BY release_year
ORDER BY total_titles DESC
LIMIT 10;


-- 3. Longest movies on Netflix
SELECT
    title,
    duration
FROM netflix_final
WHERE type = 'Movie'
AND duration LIKE '%min%'
ORDER BY CAST(REPLACE(duration,' min','') AS UNSIGNED) DESC
LIMIT 10;


-- 4. Content age distribution
SELECT
    (YEAR(CURDATE()) - release_year) AS content_age,
    COUNT(*) AS total_titles
FROM netflix_final
GROUP BY content_age
ORDER BY content_age;
