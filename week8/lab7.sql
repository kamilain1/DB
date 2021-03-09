CREATE OR REPLACE FUNCTION retrievecustomers(start_id integer, end_id integer)
RETURNS TABLE (customer_id integer, store_id smallint, first_name character varying(45),
			   last_name character varying(45), email character varying(50), address_id smallint, 
			   activebool boolean, create_date date, last_update timestamp without time zone, active integer)
LANGUAGE plpgsql
AS $$ 
BEGIN
	IF start_id >= 0 AND start_id < 600 THEN
		RETURN QUERY (SELECT * FROM customer 
			  WHERE (customer.customer_id >= start_id) AND (customer.customer_id <= end_id)
			  ORDER BY customer.address_id);		
	ELSE
		RAISE EXCEPTION 'Error. Incorrect input';
	END IF;
END;
$$
	
SELECT * FROM retrievecustomers(6, 12);