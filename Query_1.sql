-- Query 1 - top spending customers

-- total_spend by customer
WITH t1 AS(
	SELECT customer_id, SUM(amount) AS total_spend
	FROM payment
	GROUP BY 1
	ORDER BY 2 DESC
),
-- total num of customers
t2 AS(
	SELECT COUNT(*) AS total_num_of_customers
	FROM customer
)
-- total spend by categories
SELECT
	CASE WHEN total_spend < 100 THEN 'Less than 100'
	WHEN total_spend >= 100 AND total_spend < 150 THEN 'Between 100 and 150'
	WHEN total_spend >=150 AND total_spend < 200 THEN 'Between 150 and 200'
	ELSE 'Greater than 200'
	END AS total_spend,
	COUNT(customer_id) AS num_of_customers,
	t2.total_num_of_customers,
	CAST(COUNT(customer_id) AS FLOAT)/t2.total_num_of_customers*100 AS percentage_of_total_customers
FROM t1, t2
GROUP BY 1, 3
ORDER BY 2 ASC;




-- Query 1a - top 2 customers
WITH t1 AS(
	SELECT customer.customer_id AS "Customer ID", CONCAT(customer.first_name, ' ', customer.last_name) AS "Full name", SUM(payment.amount) AS total_spend
	FROM payment
	JOIN rental
	ON payment.rental_id = rental.rental_id
	JOIN customer
	ON rental.customer_id = customer.customer_id
	GROUP BY 1
	ORDER BY 2 DESC
)
SELECT *
FROM t1
WHERE total_spend > 200;
