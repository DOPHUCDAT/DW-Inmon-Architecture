-------------------------------------------------------------------
-- CUSTOMER
-------------------------------------------------------------------
ALTER TABLE mart.dim_customer
ADD CONSTRAINT Customer_ID PRIMARY KEY (Customer_ID);

-------------------------------------------------------------------
-- STAFF
-------------------------------------------------------------------
ALTER TABLE mart.dim_staff
ADD CONSTRAINT Staff_ID PRIMARY KEY (Staff_ID);

-------------------------------------------------------------------
-- FILM
-------------------------------------------------------------------
ALTER TABLE mart.dim_film
ADD CONSTRAINT Film_ID PRIMARY KEY (Film_ID);

ALTER TABLE mart.dim_film
ADD CONSTRAINT Language_ID FOREIGN KEY (Language_ID) REFERENCES mart.dim_language(Language_ID);

-------------------------------------------------------------------
-- INVENTORY
-------------------------------------------------------------------
ALTER TABLE mart.dim_inventory
ADD CONSTRAINT Inventory_ID PRIMARY KEY (Inventory_ID);

ALTER TABLE mart.dim_inventory
ADD CONSTRAINT Film_ID FOREIGN KEY (Film_ID) REFERENCES mart.dim_film(Film_ID);

-------------------------------------------------------------------
-- LANGUAGE
-------------------------------------------------------------------
ALTER TABLE mart.dim_language
ADD CONSTRAINT Language_ID PRIMARY KEY (Language_ID);

-------------------------------------------------------------------
-- RENTAL
-------------------------------------------------------------------
ALTER TABLE mart.fact_rental
ADD CONSTRAINT Rental_ID PRIMARY KEY (Rental_ID);

ALTER TABLE mart.fact_rental
ADD CONSTRAINT Inventory_ID FOREIGN KEY (Inventory_ID) REFERENCES mart.dim_inventory(Inventory_ID);

ALTER TABLE mart.fact_rental
ADD CONSTRAINT Staff_ID FOREIGN KEY (Staff_ID) REFERENCES mart.dim_staff(Staff_ID);

ALTER TABLE mart.fact_rental
ADD CONSTRAINT Customer_ID FOREIGN KEY (Customer_ID) REFERENCES mart.dim_customer(Customer_ID);

-------------------------------------------------------------------
-- PAYMENT
-------------------------------------------------------------------
ALTER TABLE mart.fact_payment
ADD CONSTRAINT Payment_ID PRIMARY KEY (Payment_ID);

ALTER TABLE mart.fact_payment
ADD CONSTRAINT Customer_ID FOREIGN KEY (Customer_ID) REFERENCES mart.dim_customer(Customer_ID);

ALTER TABLE mart.fact_payment
ADD CONSTRAINT Rental_ID FOREIGN KEY (Rental_ID) REFERENCES mart.fact_rental(Rental_ID);

ALTER TABLE mart.fact_payment
ADD CONSTRAINT Staff_ID FOREIGN KEY (Staff_ID) REFERENCES mart.dim_staff(Staff_ID);
