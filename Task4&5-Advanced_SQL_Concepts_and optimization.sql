--1 Joins:
-- Write queries using INNER JOIN, LEFT JOIN, and FULL JOIN to retrieve data across multiple tables. 
-- INNER JOIN
SELECT
	c.name, c.address, c.phone_number,
	o.order_id, o.order_date,
	oi.order_item_id, oi.quantity, oi.price,
	p.product_id, p.product_name
FROM
	customers c
JOIN orders o ON
	(C.customer_id = O.customer_id)
JOIN order_items oi ON
	(o.order_id = oi.order_id)
JOIN products p ON
	(oi.product_id = p.product_id)
ORDER BY
	c.customer_id;

-- LEFT JOIN
SELECT
	c.customer_id, c.name, p.product_name 
FROM
	customers c
LEFT JOIN orders o ON
	(C.customer_id = O.customer_id)
LEFT JOIN order_items oi ON
	(o.order_id = oi.order_id)
LEFT JOIN products p ON
	(oi.product_id = p.product_id)
	
-- FULL JOIN

SELECT
	c.customer_id, c.name, p.product_id, p.product_name 
FROM
	customers c
FULL JOIN orders o ON
	(C.customer_id = O.customer_id)
FULL JOIN order_items oi ON
	(o.order_id = oi.order_id)
FULL JOIN products p ON
	(oi.product_id = p.product_id);

--Window Functions:
--Use RANK() to rank customers based on their total spending.

WITH total_spending_cte AS (
SELECT
	o.customer_id,
	SUM(o.total_amount) AS total_spending
FROM
	orders o
GROUP BY
	o.customer_id
ORDER BY
	o.customer_id)

SELECT
	*,
	RANK() OVER (
	ORDER BY total_spending DESC)
FROM
	total_spending_cte;


--Use ROW_NUMBER() to assign a unique number to each order for a customer.

SELECT
	o.*, ROW_NUMBER() OVER (PARTITION BY o.customer_id
ORDER BY o.order_date) AS customer_order_number
FROM orders o;


--CTEs and Subqueries:
--Use a Common Table Expression (CTE) to calculate the total revenue per customer, then find the customers with revenue greater than $500.
WITH total_revenue_per_customer AS (
	SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spending_in_dollar
	FROM orders o
	JOIN customers c ON (o.customer_id = c.customer_id)
	GROUP BY c.customer_id, c.name)
		
		SELECT * FROM total_revenue_per_customer WHERE
		total_spending_in_dollar > 500 ORDER BY customer_id;
		
	
	

--Write a subquery to find the product with the highest price.
SELECT p.* FROM products p WHERE p.price = (
	SELECT max(p2.price) FROM products p2);


--Indexing:
--Create indexes on frequently queried fields (e.g., customer_id, product_id) and demonstrate their impact on query performance.
	
-- Before
EXPLAIN ANALYZE SELECT
	c.customer_id, c.name, p.product_name 
FROM
	customers c
LEFT JOIN orders o ON
	(C.customer_id = O.customer_id)
LEFT JOIN order_items oi ON
	(o.order_id = oi.order_id)
LEFT JOIN products p ON
	(oi.product_id = p.product_id);
--Add indexes to foreign keys to optimize query performance.
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_order_items_order_id ON Order_Items(order_id);
CREATE INDEX idx_order_items_product_id ON Order_Items(product_id);

-- After
EXPLAIN ANALYZE SELECT
	c.customer_id, c.name, p.product_name 
FROM
	customers c
LEFT JOIN orders o ON
	(C.customer_id = O.customer_id)
LEFT JOIN order_items oi ON
	(o.order_id = oi.order_id)
LEFT JOIN products p ON
	(oi.product_id = p.product_id);



-- Optimization:
--Analyze query performance using EXPLAIN or EXPLAIN ANALYZE.
EXPLAIN ANALYZE SELECT
	c.* FROM customers c WHERE c.name LIKE 'Dele%';




--Optimize slow queries by adjusting indexes, reordering joins, or rewriting the query.
CREATE INDEX idx_cutomer_name ON customers(name);

EXPLAIN ANALYZE SELECT
	c.customer_id, c.name, p.product_name 
FROM
	customers c
LEFT JOIN orders o ON
	(C.customer_id = O.customer_id)
LEFT JOIN order_items oi ON
	(o.order_id = oi.order_id)
LEFT JOIN products p ON
	(oi.product_id = p.product_id) WHERE c.name = 'Dele Linus';

