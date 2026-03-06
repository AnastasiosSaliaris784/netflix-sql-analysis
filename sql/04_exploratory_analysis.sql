-- Exploratory data analysis on the final cleaned Netflix dataset

USE netflix_project;

-- 1. Total number of titles
SELECT COUNT(*) AS total_titles
FROM netflix_final;

-- 2. Movies vs TV Shows
SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_final
GROUP BY type;

-- 3. Content added per year
SELECT
    YEAR(date_added) AS year_added,
    COUNT(*) AS titles_added
FROM netflix_final
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added;

-- 4. Top 10 producing countries
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_final
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- 5. Rating distribution
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_final
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC;

-- 6. Average movie duration
SELECT
    AVG(CAST(REPLACE(duration, ' min', '') AS UNSIGNED)) AS avg_movie_minutes
FROM netflix_final
WHERE type = 'Movie'
  AND duration LIKE '%min%';

-- 7. Average TV show seasons
SELECT
    AVG(
        CAST(
            REPLACE(REPLACE(duration, ' Seasons', ''), ' Season', '')
            AS UNSIGNED
        )
    ) AS avg_tv_seasons
FROM netflix_final
WHERE type = 'TV Show'
  AND duration LIKE '%Season%';

-- 8. Top 10 directors by number of titles
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_final
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

-- 9. Top 10 genre categories
SELECT
    listed_in,
    COUNT(*) AS total_titles
FROM netflix_final
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;
