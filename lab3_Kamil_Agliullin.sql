--Exercise 1
--1
SELECT * FROM country WHERE country_id>=12 AND country_id <= 17;

--2
SELECT a.* FROM city 
     LEFT JOIN address a on city.city_id = a.city_id
	 WHERE upper (city.city) LIKE 'A%';

--3
SELECT first_name, last_name, c.city FROM customer
     LEFT JOIN address a on customer.address_id = a.address.id 
	 LEFT JOIN city c on a.city_id = c.city_id;
	  
--4
SELECT * FROM customer
     WHERE customer_id in (SELECT distinct customer_id FROM payment WHERE amount > 11)

--5
SELECT first_name, COUNT(first_name)
FROM customer
GROUP BY first_name 
HAVING COUNT(first_name)>1

--Exercise 2

--1
CREATE VIEW country_list AS
    SELECT *
    FROM country
    WHERE country_id>=16;

CREATE VIEW film_year_list AS
    SELECT *
    FROM film
    WHERE release_year > 1976;
	
--2
CREATE OR REPLACE FUNCTION trig_function() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
   NEW.amount = OLD.amount + 1;
END;

$$

CREATE TRIGGER adder
BEFORE INSERT ON payment
    FOR EACH ROW EXECUTE PROCEDURE trig_function();


	 
	 
       
	 
	 
