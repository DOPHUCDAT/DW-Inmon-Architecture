-------------------------------------------------------------------
-- CUSTOMER
-------------------------------------------------------------------
ALTER TABLE edw.customer
ADD CONSTRAINT Customer_ID PRIMARY KEY (Customer_ID);

ALTER TABLE edw.customer
ADD CONSTRAINT Store_ID FOREIGN KEY (Store_ID) REFERENCES edw.store(Store_ID);

ALTER TABLE edw.customer
ADD CONSTRAINT Address_ID FOREIGN KEY (Address_ID) REFERENCES edw.address(Address_ID);

-------------------------------------------------------------------
-- STORE
-------------------------------------------------------------------
ALTER TABLE edw.store
ADD CONSTRAINT Store_ID PRIMARY KEY (Store_ID);

ALTER TABLE edw.store
ADD CONSTRAINT Address_ID FOREIGN KEY (Address_ID) REFERENCES edw.address(Address_ID);

-------------------------------------------------------------------
-- ADDRESS
-------------------------------------------------------------------
ALTER TABLE edw.address
ADD CONSTRAINT Address_ID PRIMARY KEY (Address_ID);

ALTER TABLE edw.address
ADD CONSTRAINT City_ID FOREIGN KEY (City_ID) REFERENCES edw.city(City_ID);

-------------------------------------------------------------------
-- CITY
-------------------------------------------------------------------
ALTER TABLE edw.city
ADD CONSTRAINT City_ID PRIMARY KEY (City_ID);

ALTER TABLE edw.city
ADD CONSTRAINT Country_ID FOREIGN KEY (Country_ID) REFERENCES edw.country(Country_ID);

-------------------------------------------------------------------
-- COUNTRY
-------------------------------------------------------------------
ALTER TABLE edw.country
ADD CONSTRAINT Country_ID PRIMARY KEY (Country_ID);

-------------------------------------------------------------------
-- STAFF
-------------------------------------------------------------------
ALTER TABLE edw.staff
ADD CONSTRAINT Staff_ID PRIMARY KEY (Staff_ID);

ALTER TABLE edw.staff
ADD CONSTRAINT Address_ID FOREIGN KEY (Address_ID) REFERENCES edw.address(Address_ID);

ALTER TABLE edw.staff
ADD CONSTRAINT Store_ID FOREIGN KEY (Store_ID) REFERENCES edw.store(Store_ID);

-------------------------------------------------------------------
-- FILM
-------------------------------------------------------------------
ALTER TABLE edw.film
ADD CONSTRAINT Film_ID PRIMARY KEY (Film_ID);

ALTER TABLE edw.film
ADD CONSTRAINT Language_ID FOREIGN KEY (Language_ID) REFERENCES edw.language(Language_ID);

-------------------------------------------------------------------
-- CATEGORY
-------------------------------------------------------------------
ALTER TABLE edw.category
ADD CONSTRAINT Category_ID PRIMARY KEY (Category_ID);

-------------------------------------------------------------------
-- ACTOR
-------------------------------------------------------------------
ALTER TABLE edw.actor
ADD CONSTRAINT Actor_ID PRIMARY KEY (Actor_ID);

-------------------------------------------------------------------
-- LANGUAGE
-------------------------------------------------------------------
ALTER TABLE edw.language
ADD CONSTRAINT Language_ID PRIMARY KEY (Language_ID);

-------------------------------------------------------------------
-- INVENTORY
-------------------------------------------------------------------
ALTER TABLE edw.inventory
ADD CONSTRAINT Inventory_ID PRIMARY KEY (Inventory_ID);

ALTER TABLE edw.inventory
ADD CONSTRAINT Film_ID FOREIGN KEY (Film_ID) REFERENCES edw.film(Film_ID);

ALTER TABLE edw.inventory
ADD CONSTRAINT Store_ID FOREIGN KEY (Store_ID) REFERENCES edw.store(Store_ID);

-------------------------------------------------------------------
-- RENTAL
-------------------------------------------------------------------
ALTER TABLE edw.rental
ADD CONSTRAINT Rental_ID PRIMARY KEY (Rental_ID);

ALTER TABLE edw.rental
ADD CONSTRAINT Inventory_ID FOREIGN KEY (Inventory_ID) REFERENCES edw.inventory(Inventory_ID);

ALTER TABLE edw.rental
ADD CONSTRAINT Staff_ID FOREIGN KEY (Staff_ID) REFERENCES edw.staff(Staff_ID);

ALTER TABLE edw.rental
ADD CONSTRAINT Customer_ID FOREIGN KEY (Customer_ID) REFERENCES edw.customer(Customer_ID);

-------------------------------------------------------------------
-- PAYMENT
-------------------------------------------------------------------
ALTER TABLE edw.payment
ADD CONSTRAINT Payment_ID PRIMARY KEY (Payment_ID);

ALTER TABLE edw.payment
ADD CONSTRAINT Customer_ID FOREIGN KEY (Customer_ID) REFERENCES edw.customer(Customer_ID);

-------------------------------------------------------------------
-- FILM_ACTOR
-------------------------------------------------------------------
ALTER TABLE edw.film_actor
ADD CONSTRAINT Actore_ID FOREIGN KEY (Actor_ID) REFERENCES edw.actor(Actor_ID);

ALTER TABLE edw.film_actor
ADD CONSTRAINT Film_ID FOREIGN KEY (Film_ID) REFERENCES edw.film(Film_ID);

-------------------------------------------------------------------
-- FILM_CATEGORY
-------------------------------------------------------------------
ALTER TABLE edw.film_category
ADD CONSTRAINT Film_ID FOREIGN KEY (Film_ID) REFERENCES edw.film(Film_ID);

ALTER TABLE edw.film_category
ADD CONSTRAINT Category_ID FOREIGN KEY (Category_ID) REFERENCES edw.category(Category_ID);