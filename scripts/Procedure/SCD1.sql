CREATE OR REPLACE PROCEDURE sp_scd_type1()
LANGUAGE plpgsql
AS $$
BEGIN
    -------------------------------------------------------------------
    -- CATEGORY
    -------------------------------------------------------------------
    INSERT INTO edw.category (category_id, name, last_update)
    SELECT category_id, name, last_update
    FROM staging.category
    ON CONFLICT (category_id) DO UPDATE
    SET name        = EXCLUDED.name,
        last_update = now();

    -------------------------------------------------------------------
    -- FILM
    -------------------------------------------------------------------
    INSERT INTO edw.film (
        film_id, title, description, release_year, language_id,
        rental_duration, rental_rate, length, replacement_cost, rating,
        last_update
    )
    SELECT film_id, title, description, release_year, language_id,
           rental_duration, rental_rate, length, replacement_cost, rating,
           last_update
    FROM staging.film
    ON CONFLICT (film_id) DO UPDATE
    SET title            = EXCLUDED.title,
        description      = EXCLUDED.description,
        release_year     = EXCLUDED.release_year,
        language_id      = EXCLUDED.language_id,
        rental_duration  = EXCLUDED.rental_duration,
        rental_rate      = EXCLUDED.rental_rate,
        length           = EXCLUDED.length,
        replacement_cost = EXCLUDED.replacement_cost,
        rating           = EXCLUDED.rating,
        last_update      = now();

    -------------------------------------------------------------------
    -- LANGUAGE
    -------------------------------------------------------------------
    INSERT INTO edw.language (language_id, name, last_update)
    SELECT language_id, name, last_update
    FROM language
    ON CONFLICT (language_id) DO UPDATE
    SET name        = EXCLUDED.name,
        last_update = now();

    -------------------------------------------------------------------
    -- ACTOR
    -------------------------------------------------------------------
    INSERT INTO edw.actor (actor_id, first_name, last_name, last_update)
    SELECT actor_id, first_name, last_name, last_update
    FROM staging.actor
    ON CONFLICT (actor_id) DO UPDATE
    SET first_name  = EXCLUDED.first_name,
        last_name   = EXCLUDED.last_name,
        last_update = now();

    -------------------------------------------------------------------
    -- STAFF
    -------------------------------------------------------------------
    INSERT INTO edw.staff (
        staff_id, first_name, last_name, address_id, email, store_id,
        active, username, password, picture, last_update
    )
    SELECT staff_id, first_name, last_name, address_id, email, store_id,
           active, username, password, picture, last_update
    FROM staging.staff
    ON CONFLICT (staff_id) DO UPDATE
    SET first_name  = EXCLUDED.first_name,
        last_name   = EXCLUDED.last_name,
        address_id  = EXCLUDED.address_id,
        email       = EXCLUDED.email,
        store_id    = EXCLUDED.store_id,
        active      = EXCLUDED.active,
        username    = EXCLUDED.username,
        password    = EXCLUDED.password,
        picture     = EXCLUDED.picture,
        last_update = now();

    -------------------------------------------------------------------
    -- CUSTOMER
    -------------------------------------------------------------------
    INSERT INTO edw.customer (
        customer_id, store_id, first_name, last_name, email,
        address_id, activebool, create_date, active, last_update
    )
    SELECT customer_id, store_id, first_name, last_name, email,
           address_id, activebool, create_date, active, last_update
    FROM staging.customer
    ON CONFLICT (customer_id) DO UPDATE
    SET store_id    = EXCLUDED.store_id,
        first_name  = EXCLUDED.first_name,
        last_name   = EXCLUDED.last_name,
        email       = EXCLUDED.email,
        address_id  = EXCLUDED.address_id,
        activebool  = EXCLUDED.activebool,
        create_date = EXCLUDED.create_date,
        active      = EXCLUDED.active,
        last_update = now();

    -------------------------------------------------------------------
    -- ADDRESS
    -------------------------------------------------------------------
    INSERT INTO edw.address (
        address_id, address, address2, district,
        city_id, postal_code, phone, last_update
    )
    SELECT address_id, address, address2, district,
           city_id, postal_code, phone, last_update
    FROM staging.address
    ON CONFLICT (address_id) DO UPDATE
    SET address     = EXCLUDED.address,
        address2    = EXCLUDED.address2,
        district    = EXCLUDED.district,
        city_id     = EXCLUDED.city_id,
        postal_code = EXCLUDED.postal_code,
        phone       = EXCLUDED.phone,
        last_update = now();

    -------------------------------------------------------------------
    -- CITY
    -------------------------------------------------------------------
    INSERT INTO edw.city (city_id, city, country_id, last_update)
    SELECT city_id, city, country_id, last_update
    FROM staging.city
    ON CONFLICT (city_id) DO UPDATE
    SET city        = EXCLUDED.city,
        country_id  = EXCLUDED.country_id,
        last_update = now();

    -------------------------------------------------------------------
    -- COUNTRY
    -------------------------------------------------------------------
    INSERT INTO edw.country (country_id, country, last_update)
    SELECT country_id, country, last_update
    FROM staging.country
    ON CONFLICT (country_id) DO UPDATE
    SET country     = EXCLUDED.country,
        last_update = now();

    -------------------------------------------------------------------
    -- STORE
    -------------------------------------------------------------------
    INSERT INTO edw.store (store_id, manager_staff_id, address_id, last_update)
    SELECT store_id, manager_staff_id, address_id, last_update
    FROM staging.store
    ON CONFLICT (store_id) DO UPDATE
    SET manager_staff_id = EXCLUDED.manager_staff_id,
        address_id       = EXCLUDED.address_id,
        last_update      = now();
    -------------------------------------------------------------------
    -- FILM_CATEGORY
    -------------------------------------------------------------------
    INSERT INTO film_category (film_id, category_id, last_update)
    SELECT film_id, category_id, last_update
    FROM staging.film_category
    ON CONFLICT (film_id, category_id) DO UPDATE
    SET last_update = now();

    -------------------------------------------------------------------
    -- FILM_ACTOR
    -------------------------------------------------------------------
    INSERT INTO film_actor (film_id, actor_id, last_update)
    SELECT film_id, actor_id, last_update
    FROM film_actor
    ON CONFLICT (film_id, actor_id) DO UPDATE
    SET last_update = now();

    -------------------------------------------------------------------
    -- INVENTORY
    -------------------------------------------------------------------
    INSERT INTO edw.inventory (inventory_id, film_id, store_id, last_update)
    SELECT inventory_id, film_id, store_id, last_update
    FROM staging.inventory
    ON CONFLICT (inventory_id) DO UPDATE
    SET film_id     = EXCLUDED.film_id,
        store_id    = EXCLUDED.store_id,
        last_update = now();

    -------------------------------------------------------------------
    -- RENTAL
    -------------------------------------------------------------------
    INSERT INTO edw.rental (
        rental_id, rental_date, inventory_id,
        customer_id, return_date, staff_id, last_update
    )
    SELECT rental_id, rental_date, inventory_id,
           customer_id, return_date, staff_id, last_update
    FROM staging.rental
    ON CONFLICT (rental_id) DO UPDATE
    SET rental_date = EXCLUDED.rental_date,
        inventory_id = EXCLUDED.inventory_id,
        customer_id  = EXCLUDED.customer_id,
        return_date  = EXCLUDED.return_date,
        staff_id     = EXCLUDED.staff_id,
        last_update  = now();

    -------------------------------------------------------------------
    -- PAYMENT
    -------------------------------------------------------------------
    INSERT INTO edw.payment (
        payment_id, customer_id, staff_id, rental_id,
        amount, payment_date
    )
    SELECT payment_id, customer_id, staff_id, rental_id,
           amount, payment_date
    FROM staging.payment
    ON CONFLICT (payment_id) DO UPDATE
    SET customer_id  = EXCLUDED.customer_id,
        staff_id     = EXCLUDED.staff_id,
        rental_id    = EXCLUDED.rental_id,
        amount       = EXCLUDED.amount,
        payment_date = EXCLUDED.payment_date;

END;
$$;
