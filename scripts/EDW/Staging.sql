-------------------------------------------------------------------
-- CUSTOMER
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.customer;
CREATE TABLE edw.customer AS (
	SELECT
		customer_id AS Customer_ID,
		TRIM(first_name) AS First_Name,
		TRIM(last_name) AS Last_Name,
		TRIM(email) AS Email,
		CASE
			WHEN activebool = TRUE THEN 'Active'
			ELSE 'Inactive'
		END AS Is_Active,
		create_date AS Create_Date,
		last_update AS Last_Update,
		store_id AS Store_ID,
		address_id AS Address_ID
	FROM staging.customer
);

-------------------------------------------------------------------
-- STORE
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.store;
CREATE TABLE edw.store AS (
	SELECT
		store_id AS Store_ID,
		last_update AS Last_Update,
		manager_staff_id AS Manager_Staff_ID,
		address_id AS Address_ID
	FROM staging.store
);

-------------------------------------------------------------------
-- ADDRESS
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.address;
CREATE TABLE edw.address AS (
	SELECT
		address_id AS Address_ID,
		TRIM(address) AS Address,
		CASE WHEN address2 IS NULL THEN 'Not Available' 
			 ELSE 'address2'
		END AS Sub_Address,
		TRIM(district) AS District,
		CASE WHEN postal_code IS NULL THEN 'Not Available'
			 ELSE 'postal_code'
		END AS Postal_Code,
		CASE WHEN phone IS NULL THEN 'Not Available'
			 ELSE 'Not Available'
		END AS Phone,
		last_update AS Last_Update,
		city_id AS City_ID
	FROM staging.address
);

-------------------------------------------------------------------
-- CITY
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.city;
CREATE TABLE edw.city AS (
	SELECT
		city_id AS City_ID,
		CASE 
			WHEN city IS NULL THEN 'Not Available'
			ELSE INITCAP(city)
		END AS City,
		last_update AS Last_Update,
		country_id AS Country_ID
	FROM staging.city
);

-------------------------------------------------------------------
-- COUNTRY
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.country;
CREATE TABLE edw.country AS (
	SELECT
		country_id AS Country_ID,
		CASE
			WHEN country IS NULL THEN 'Not Available'
			ELSE INITCAP(country)
		END AS Country,
		last_update AS Last_Update
	FROM staging.country
);

-------------------------------------------------------------------
-- STAFF
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.staff;
CREATE TABLE edw.staff AS (
	SELECT
		staff_id AS Staff_ID,
		TRIM(first_name) AS First_Name,
		TRIM(last_name) AS Last_Name,
		address_id AS Address_ID,
		TRIM(email) AS Email,
		store_id AS Store_ID,
		CASE
			WHEN active = TRUE THEN 'Active'
			ELSE 'Inactive'
		END AS Is_Active,
		SPLIT_PART(username, '.', 1) AS UserName,
		TRIM(password) AS Password,
		last_update AS Last_Update,
		CASE
			WHEN picture IS NULL THEN 'Not Available'
			ELSE picture
		END AS Picture
	FROM staging.staff
	WHERE password IS NOT NULL
);

-------------------------------------------------------------------
-- FILM
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.film;
CREATE TABLE edw.film AS (
	SELECT
		film_id AS Film_ID,
		INITCAP(TRIM(title)) AS Title,
		TRIM(description) AS Description,
		ABS(release_year) AS Release_Year,
		language_id AS Language_ID,
		CASE
			WHEN rental_duration = 0 THEN (SELECT rental_duration FROM staging.film WHERE rental_duration <> 0)
			ELSE ABS(rental_duration)
		END AS Rental_Duration,
		ABS(rental_rate) AS Rental_Rate,
		ABS(length) AS Length,
		ABS(replacement_cost) AS Replacement_cost,
		CASE
			WHEN rating = 'G' THEN 'General Audiences'
			WHEN rating = 'PG' THEN 'Parental Guidance Suggested'
			WHEN rating = 'PG-13' THEN 'Parents Strongly Cautioned'
			WHEN rating = 'R' THEN 'Restricted'
			WHEN rating = 'NC-17' THEN 'No One 17 and Under Admitted'
			ELSE 'Not Available'
		END AS Rating,
		last_update AS Last_Update
	FROM staging.film
);

-------------------------------------------------------------------
-- CATEGORY
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.category;
CREATE TABLE edw.category AS (
	SELECT
		category_id AS Category_ID,
		TRIM(name) AS Name,
		last_update AS Last_Update
	FROM staging.category
);

-------------------------------------------------------------------
-- ACTOR
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.actor;
CREATE TABLE edw.actor AS (
	SELECT
		actor_id AS Actor_ID,
		INITCAP(TRIM(first_name)) AS First_Name,
		INITCAP(TRIM(last_name)) AS Last_Name,
		last_update AS Last_Update
	FROM staging.actor
);

-------------------------------------------------------------------
-- LANGUAGE
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.language;
CREATE TABLE edw.language AS (
	SELECT
		language_id AS Language_ID,
		INITCAP(TRIM(name)) AS Name,
		last_update AS Last_Update
	FROM staging.language
);

-------------------------------------------------------------------
-- INVENTORY
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.inventory;
CREATE TABLE edw.inventory AS (
	SELECT
		inventory_id AS Inventory_ID,
		film_id AS Film_ID,
		store_id AS Store_ID
	FROM staging.inventory
);

-------------------------------------------------------------------
-- RENTAL
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.rental;
CREATE TABLE edw.rental AS (
	SELECT 
		rental_id AS Rental_ID,
		CASE
			WHEN rental_date > return_date THEN return_date
			ELSE rental_date
		END AS Rental_Date,
		inventory_id AS Inventory_ID,
		customer_id AS Customer_ID,
		CASE 
			WHEN return_date < rental_date THEN rental_date
			ELSE return_date
		END AS Return_Date,
		CASE
			WHEN return_date IS NULL THEN 'Not Returned'
			ELSE 'Returned'
		END AS Rental_Status,
		staff_id AS Staff_ID,
		last_update AS Last_Update
	FROM staging.rental
);

-------------------------------------------------------------------
-- PAYMENT
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.payment;
CREATE TABLE edw.payment AS (
	SELECT
		payment_id AS Payment_ID,
		customer_id AS Customer_ID,
		staff_id AS Staff_ID,
		rental_id AS Rental_ID,
		CASE
			WHEN amount = 0 THEN (SELECT AVG(amount) FROM staging.payment WHERE amount <> 0)
			ELSE ABS(amount)
		END AS Amount,
		payment_date AS Payment_Date
	FROM staging.payment
);

-------------------------------------------------------------------
-- FILM_ACTOR
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.film_actor;
CREATE TABLE edw.film_actor AS (
	SELECT
		actor_id AS Actor_ID,
		film_id AS Film_ID,
		last_update as Last_Update
	FROM staging.film_actor
);

-------------------------------------------------------------------
-- FILM_CATEGORY
-------------------------------------------------------------------
DROP TABLE IF EXISTS edw.film_category;
CREATE TABLE edw.film_category AS (
	SELECT
		category_id as Category_ID,
		film_id AS Film_ID,
		last_update as Last_Update
	FROM staging.film_category
);