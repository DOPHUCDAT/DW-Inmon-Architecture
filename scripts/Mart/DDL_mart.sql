-------------------------------------------------------------------
-- CUSTOMER
-------------------------------------------------------------------
DROP TABLE IF EXISTS mart.dim_customer;
CREATE TABLE mart.dim_customer AS (
	SELECT
		customer_id,
		first_name || ' ' || last_name as full_name,
		email,
		is_active
	FROM edw.customer
);

-------------------------------------------------------------------
-- STAFF
-------------------------------------------------------------------
DROP TABLE IF EXISTS mart.dim_staff;
CREATE TABLE mart.dim_staff AS (
	SELECT
		staff_id,
		first_name || ' ' || last_name as full_name,
		email,
		is_active
	FROM edw.staff
);

-------------------------------------------------------------------
-- INVENTORY
-------------------------------------------------------------------
DROP TABLE IF EXISTS mart.dim_inventory;
CREATE TABLE mart.dim_inventory AS (
	SELECT
		inventory_id,
		film_id
	FROM edw.inventory
);

-------------------------------------------------------------------
-- FILM
-------------------------------------------------------------------
DROP TABLE IF EXISTS mart.dim_film;
CREATE TABLE mart.dim_film AS (
	SELECT
		film_id,
		language_id,
		title,
		release_year,
		rental_duration,
		rental_rate,
		length,
		replacement_cost,
		rating
	FROM edw.film
);

-------------------------------------------------------------------
-- LANGUAGE
-------------------------------------------------------------------
DROP TABLE IF EXISTS mart.dim_language;
CREATE TABLE mart.dim_language AS (
	SELECT 
		language_id,
		name
	FROM edw.language
);

-------------------------------------------------------------------
-- RENTAL
-------------------------------------------------------------------
DROP TABLE IF EXISTS mart.fact_rental;
CREATE TABLE mart.fact_rental AS (
	SELECT 
		rental_id,
		inventory_id,
		staff_id,
		customer_id,
		rental_date,
		return_date,
		rental_status
	FROM edw.rental
);

-------------------------------------------------------------------
-- PAYMENT
-------------------------------------------------------------------
DROP TABLE IF EXISTS mart.fact_payment;
CREATE TABLE mart.fact_payment AS (
	SELECT
		payment_id,
		staff_id,
		customer_id,
		rental_id,
		amount,
		payment_date
	FROM edw.payment
);
