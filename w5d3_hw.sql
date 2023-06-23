--NOTE. Query doesn’t have to necessarily bring back this answer in one single cell, 
--however you should be able to get to this answer based on your query.

--1. List all customers who live in Texas (use JOINs)
--Output: 5 people live in Texas.
SELECT first_name, last_name, district
FROM customer

INNER JOIN address
ON customer.address_id = address.address_id

WHERE district = 'Texas';


--2. Get all payments above $6.99 with the Customer's Full Name
--Output: 1406 payments
SELECT first_name, last_name, SUM(amount), payment.customer_id
FROM payment

INNER JOIN customer
ON customer.customer_id = payment.customer_id

GROUP BY first_name, last_name, payment.customer_id
HAVING SUM(amount) > 6.99
ORDER BY payment.customer_id;


--3. Show all customers names who have made payments over $175(use subqueries)
--Output: 6 customers
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175.00
	ORDER BY SUM(amount) DESC
);


--4. List all customers that live in Nepal (use the city table)
--Output: 1 customer
SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

--5. Which staff member had the most transactions?
--Output: Jon Stephens with 7304 transactions
SELECT first_name, last_name, COUNT(payment.staff_id)
FROM staff

INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(payment.staff_id) DESC
LIMIT 1;

--6. How many movies of each rating are there?
--Output: G: 178, PG: 194, PG-13: 223, R: 195, NC-17:210
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY rating!='G', rating!='PG', rating!='PG-13', rating!='R', rating!='NC-17';


--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
--Output: 130 customers made a single payment over $6.99

SELECT first_name, last_name
FROM customer
GROUP BY customer_id
HAVING customer_id IN (
	SELECT DISTINCT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(DISTINCT customer_id) = 1
);


--8. How many free rentals did the stores give away?
--Output: 24 free rentals
SELECT *
FROM payment
GROUP BY payment_id
HAVING amount = 0.00;