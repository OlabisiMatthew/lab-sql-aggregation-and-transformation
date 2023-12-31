USE sakila;

-- QUESTION 1: You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MIN(length) AS "min_duration", MAX(length) AS "max_duration" FROM film
WHERE length <> 0;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.

SELECT ROUND(AVG(length/60)) as average_movie_duration_in_hours  FROM film;
SELECT ROUND(AVG(length)) as average_movie_duration_in_minutes  FROM film;

-- QUESTION 2: You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT *,
    CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' ELSE 'workday' END AS DAY_TYPE
FROM rental
LIMIT 20;

-- QUESTION 3: You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- QUESTION 4: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT CONCAT(first_name, ' ', last_name) AS full_name, LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2 : Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT COUNT(*) AS total_films FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films FROM film
GROUP BY rating; 

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 

SELECT rating, COUNT(*) AS number_of_films FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- QUESTION 2: Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 

SELECT rating, ROUND(AVG(length), 2) AS mean_duration FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- QUESTION 3: determine which last names are not repeated in the table actor.
SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
