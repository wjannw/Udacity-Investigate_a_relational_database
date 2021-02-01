-- Query 2 - most popular categories
SELECT category.name AS category_name, COUNT(rental.*) AS num_of_times_rented
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN film
ON film_category.film_id = film.film_id
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY 1
ORDER BY 2 DESC;
