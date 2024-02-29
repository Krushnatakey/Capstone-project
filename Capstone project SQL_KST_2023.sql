use sakila;
show tables;
select * from sakila.actor;
-- Task 1 display full name
SELECT CONCAT(first_name, " ", last_name) AS full_name FROM sakila.actor;
-- Task 2 To display the number of times each first name appears in the database.
SELECT first_name, COUNT(*) AS name_count
FROM sakila.actor
GROUP BY first_name
ORDER BY name_count DESC;
-- Display the count of actors that have uniqe first names in the database ? Display the first name of all these actors.
SELECT COUNT(DISTINCT first_name) AS unique_name_count
FROM sakila.actor;
SELECT DISTINCT first_name
FROM sakila.actor;
SELECT first_name
FROM sakila.actor
GROUP BY first_name
HAVING COUNT(*) = 1;
-- Task 3 Display the number of times each last names appears in the database.
SELECT last_name, COUNT(*) AS name_count
FROM sakila.actor
GROUP BY last_name
ORDER BY name_count DESC;
-- Display all unique last names in the database
SELECT DISTINCT last_name
FROM sakila.actor;
-- Task 4 Display the list of records for the movies with the rating "R" from. 
SELECT * FROM sakila.film WHERE rating = 'R';
-- ii. Display the list of records for the movies that are not rated "R".
SELECT * FROM sakila.film WHERE rating <> 'R';
-- Display the list of records for the movies that are sutable for audiance below 13 year of age.
SELECT * FROM sakila.film WHERE rating = 'G' OR rating = 'PG';
-- Task 5 The display list of records for the movies where the replacement cost is up to $11.
SELECT * FROM sakila.film WHERE replacement_cost <= 11;
-- ii. The display list of records for the movies where the replacement cost is between $11 and 20$.
SELECT * FROM sakila.film WHERE replacement_cost BETWEEN 11 AND 20;
-- iii. The display list of records for the movies in decending order of their replacement cost.
SELECT * FROM sakila.film ORDER BY replacement_cost DESC;
-- Task 6 Display the name of top 3 movies with the gratest number of actors
SELECT film_id, COUNT(actor_id) AS num_actors
FROM sakila.film_actor
GROUP BY film_id
ORDER BY num_actors DESC
LIMIT 3;

-- 7. Music of Queen and 'Kris Kristofferson' have seen an unlikely resurgence unitended consequence, flim starting with the letters 'K' and 'Q' have also soared in popularity. Display the titles of the movies starting with the letters 'K' and 'Q'.
SELECT title FROM sakila.film WHERE title LIKE 'K%' OR title LIKE 'Q%';
-- Task 8 The film 'Agent Truman' has been a great success. Display the names of all actors who appeared in this film.
SELECT a.first_name, a.last_name
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor a ON film_actor.actor_id = a.actor_id
WHERE film.title = 'Agent Truman';
-- Task 9 Sales have been lagging amoung young families, so managements wants to pramote family movies. identify all the movies catogorized as family films. 
SELECT * FROM sakila.film WHERE rating IN ('G', 'PG');
-- Task 10 The managements wants to observes the rental rates and rental freque (Number of time the movie disc is rented).
SELECT title, COUNT(rental_id) AS NUM_RENTALS
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY NUM_RENTALS DESC;

-- i.Display the maxium,minimum, and avrage rental rates of movies based on their ratings. The output must be sorted in decending order of the avrage rental rates.
SELECT rating, MAX(rental_rate) AS max_rental_rate, MIN(rental_rate) AS min_rental_rate, AVG(rental_rate) AS avg_rental_rate
FROM
  (SELECT rental_rate, rating FROM film) AS film_rates
GROUP BY rating
ORDER BY avg_rental_rate DESC;
-- 11.Disply the movies in decending order of their rental frequencies 
SELECT title, COUNT(rental_id) AS rental_frequency
FROM sakila.rental
JOIN sakila.inventory ON rental.inventory_id = inventory.inventory_id
JOIN sakila.film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY rental_frequency DESC;
-- Task 11: In how many film categories, the difference between the average film replacement cost ((disc - DVD/Blue Ray) and the average film rental rate is greater than $15? Display the list of all film categories identified above, along with the corresponding average film rental rate.
SELECT COUNT(*) AS NUM_CATEGORIES
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
WHERE (replacement_cost - rental_rate) > 15;

-- Task 12: Display the film catogories in which the number of movies is grater than 70.
SELECT category.name, COUNT(*) AS NUM_MOVIES
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
HAVING COUNT(*) > 70
ORDER BY NUM_MOVIES DESC;











