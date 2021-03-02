--Task 1
--1.1
SELECT customer.first_name, customer.last_name, film.title FROM customer, film, category, film_category
WHERE (film.rating = 'R' or film.rating = 'PG-13') 
AND (category.name = 'Horror' or category.name = 'Sci-Fi') 
AND (film.film_id = film_category.film_id and film_category.category_id = category.category_id)
AND film.title NOT IN (SELECT film.title from rental, inventory, film
					   WHERE customer.customer_id = rental.customer_id 
					   AND rental.inventory_id = inventory.inventory_id 
					   AND inventory.film_id = film.film_id);


--1.2
SELECT city.city, store.store_id, SUM(payment.amount)
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON payment.staff_id = staff.staff_id
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE payment.payment_date >= (SELECT MAX(payment_date) FROM payment) - INTERVAL '1 month' 
GROUP BY city.city, store.store_id

--Task2
--2.1

EXPLAIN ANALYSE SELECT customer.first_name, customer.last_name, film.title FROM customer, film, category, film_category
WHERE (film.rating = 'R' or film.rating = 'PG-13') 
AND (category.name = 'Horror' or category.name = 'Sci-Fi') 
AND (film.film_id = film_category.film_id and film_category.category_id = category.category_id)
AND film.title NOT IN (SELECT film.title from rental, inventory, film
					   WHERE customer.customer_id = rental.customer_id 
					   AND rental.inventory_id = inventory.inventory_id 
					   AND inventory.film_id = film.film_id);

-- Nested loops and sequential scans affect performance the most. We can improve the effectiveness of a query by indexing the table, for example btree.

--2.2

EXPLAIN ANALYSE SELECT city.city, store.store_id, SUM(payment.amount)
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON payment.staff_id = staff.staff_id
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE payment.payment_date >= (SELECT MAX(payment_date) FROM payment) - INTERVAL '1 month' 
GROUP BY city.city, store.store_id

-- Here we can also improve the performance by indexing the table.
