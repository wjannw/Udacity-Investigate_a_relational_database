-- Query 3 - return status

-- return date less rental date difference
WITH t1 AS(
	SELECT *, DATE_PART('day', return_date - rental_date) AS diff
	FROM rental
),
-- create return status
t2 AS(
	SELECT f.rental_duration, diff,
		CASE
			WHEN diff < f.rental_duration THEN 'returned early'
			WHEN diff = f.rental_duration THEN 'returned on time'
			ELSE 'LATE'
		END AS return_status
	FROM film f
	JOIN inventory i
	ON f.film_id = i.film_id
	JOIN t1
	ON t1.inventory_id = i.inventory_id)
-- count per return status
SELECT return_status, COUNT(*) AS num_of_films
FROM t2
GROUP BY 1;
