-- CRUD Operations

--1 Add a new customer to the database
INSERT INTO customers (name, email, phone_number, address) VALUES 
('Dele Linus', 'sirdele@gmail.com', '(234) 81450-48825', '12 Famakin Olajiire, Fashina, Osun State, 22010')

--2 Update the stock quantity of a product after a purchase.
UPDATE
    products
SET
    stock_quantity = stock_quantity - COALESCE((
        SELECT
            SUM(oi.quantity)
        FROM
            order_items oi
        WHERE
            oi.product_id = products.product_id
            AND oi.order_id = 10
    ), 0)
WHERE
    products.product_id IN (
        SELECT DISTINCT(product_id)
        FROM order_items
        WHERE order_id = 10
    )
    AND stock_quantity >= COALESCE((
        SELECT
            SUM(oi.quantity)
        FROM order_items oi
        WHERE oi.product_id = products.product_id
          AND oi.order_id = 10
    ), 0);


--3 Delete an order from the database. (say in case of a wrong entry or returned order)
-- Assuming it is a case of returned order, return the products before deleting the order
UPDATE
    products
SET
    stock_quantity = stock_quantity + COALESCE((
        SELECT
            SUM(oi.quantity)
        FROM
            order_items oi
        WHERE
            oi.product_id = products.product_id
            AND oi.order_id = 10
    ), 0)
WHERE
    products.product_id IN (
        SELECT DISTINCT(product_id)
        FROM order_items
        WHERE order_id = 10
    );
   
DELETE FROM orders WHERE order_id = 10; -- it will be deleted IN ordered_items AS well since it was CASCADED during definition

--4 Retrieve all orders made by a specific customer.
SELECT c.name, o.* FROM orders o JOIN customers c ON o.customer_id = c.customer_id WHERE c.name = 'Brian Clark'; 
