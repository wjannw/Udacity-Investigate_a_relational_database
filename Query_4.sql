-- Query 4 - highest performing store

-- total amount for stores
WITH t1 AS(
	SELECT SUM(amount) AS tot_amount
	FROM payment
),
-- num of transactions and store sales by store
t2 AS(
	SELECT DISTINCT store.store_id,  COUNT(*) AS num_of_trans, ROUND(SUM(payment.amount), 0) AS store_tot
	FROM rental
	JOIN payment
	ON rental.rental_id = payment.rental_id
	JOIN staff
	ON payment.staff_id = staff.staff_id
	JOIN store
	ON staff.store_id = store.store_id
	GROUP BY 1
	ORDER BY 1
)
-- percent of total by store
SELECT t2.*, tot_amount, ROUND(store_tot/tot_amount, 2) AS percent
FROM t1, t2;


-- Query 4 part b - store location, city and country.
SELECT store.store_id, address.address, city.city, country.country
FROM store
JOIN staff
ON store.store_id = staff.store_id
JOIN address
ON staff.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id;
