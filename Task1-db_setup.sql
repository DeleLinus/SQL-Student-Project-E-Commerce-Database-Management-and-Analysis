-- Create the database and tables using appropriate data types and constraints (e.g., primary and foreign keys, NOT NULL)
CREATE DATABASE altschool_ecommerce_db;

CREATE TABLE IF NOT EXISTS Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity int NOT NULL DEFAULT 0
    );
    
CREATE TABLE IF NOT EXISTS Orders (
	order_id SERIAL PRIMARY KEY, 
	customer_id INT NOT NULL,
	order_date TIMESTAMP NOT NULL,
	total_amount NUMERIC(10, 2) NOT NULL, 
	CONSTRAINT fk_order_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE	CASCADE
	);

CREATE TABLE IF NOT EXISTS Order_Items (
	order_item_id SERIAL PRIMARY KEY, 
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL DEFAULT 1,
	price NUMERIC NOT NULL,
	CONSTRAINT fk_order_items_order_id FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_order_items_product_id FOREIGN KEY (product_id) REFERENCES Products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
	);

-- Populate the tables 

INSERT INTO customers (name, email, phone_number, address) VALUES 
('George Garcia', 'dawnreyes@example.com', '(463) 580-7077', '6998 Nicholas View, Johnville, VA, 29072'),
('Lisa Sheppard MD', 'alexis74@example.org', '(818) 578-9284', '400 Gonzalez Isle, Christinaview, NV, 16907'),
('Laurie Hammond', 'melissa91@example.com', '(314) 830-4295', '857 Scott Highway, Carterton, WI, 23456'),
('Brian Clark', 'nicole58@example.net', '(385) 860-8970', '51957 White Drive, Bradfordtown, MH, 35922'),
('Kenneth Armstrong', 'schmidtmelissa@example.org', '(725) 293-4495', '1836 Joseph Mall Apt. 050, New Ashleymouth, IA, 01467'),
('Natalie Dunn', 'renee93@example.net', '(566) 650-9599', '686 Jerome Burgs Suite 585, West Kathyshire, LA, 75979'),
('Robert Rose', 'schneidertyler@example.net', '(337) 292-1534', '5590 Alison Prairie Suite 256, New Teresamouth, OH, 51192'),
('Michael Saunders', 'martinbrian@example.org', '(353) 221-2294', '71767 Fernandez Radial, Lake Melaniemouth, SC, 94325'),
('Erica Woodward', 'ereilly@example.org', '(276) 592-3449', '720 Durham Turnpike, Adkinsbury, IA, 32782'),
('Lisa Horn', 'jeremy30@example.com', '(811) 900-0826', 'Unit 2150 Box 1546, DPO, AE, 32307');

INSERT INTO products (product_name,category,price,stock_quantity) VALUES 
    ('Wireless Earbuds', 'Electronics', 51.79, 14), ('Office Chair', 'Furniture', 93.37, 15), ('Wall Mirror', 'Home Decor', 90.88, 25),
    ('Men’s Running Shoes', 'Footwear', 85.29, 15), ('LED Desk Lamp', 'Lighting', 74.57, 40), ('Acrylic Paint Set', 'Art Supplies', 54.42, 31),
    ('Bluetooth Speaker', 'Electronics', 23.46, 32), ('Laptop Backpack', 'Accessories', 85.80, 30), ('Smartwatch', 'Wearables', 75.61, 47),
    ('Yoga Mat', 'Fitness', 91.79, 31), ('Electric Kettle', 'Kitchen Appliances', 45.25, 20), ('Gaming Keyboard', 'Electronics', 69.99, 18),
    ('Wooden Coffee Table', 'Furniture', 120.50, 12), ('Cotton Bedsheet Set', 'Home Decor', 35.40, 50), ('Digital Camera', 'Electronics', 199.99, 10),
    ('Women’s Handbag', 'Accessories', 89.99, 25), ('Mountain Bike', 'Outdoor Gear', 299.99, 8), ('Portable Power Bank', 'Electronics', 39.99, 35),
    ('Winter Jacket', 'Clothing', 125.00, 22), ('Noise-Cancelling Headphones', 'Electronics', 149.99, 15);

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES 
   	   (10, '2024-09-30 17:17:50', 269.97), (4, '2024-04-05 13:10:49', 832.87), (8, '2024-11-25 20:42:38', 348.55),
       (6, '2024-01-06 11:32:16', 391.65), (2, '2024-08-26 16:38:36', 299.98), (9, '2024-03-22 23:10:14', 683.23),
       (7, '2024-05-16 06:35:17', 1350.37), (3, '2024-04-18 08:43:49', 1272.82), (1, '2024-05-25 20:55:56', 578.66),
       (5, '2024-04-23 19:47:44', 346.91),  (5, '2024-10-17 18:03:40', 299.98), (4, '2024-08-13 14:38:22', 780.6),
       (7, '2024-12-03 08:07:12', 275.37), (8, '2024-04-30 08:10:26', 132.72), (6, '2024-08-14 15:19:27', 92.17),
       (3, '2024-02-05 10:29:41', 703.54), (1, '2024-04-18 03:12:30', 1107.94), (2, '2024-01-07 01:51:16', 315.36), 
       (5, '2024-03-14 05:58:27', 145.16), (4, '2024-03-15 12:35:52', 99.67);
   

      
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES 
    (1, 16, 3, 89.99), (2, 2, 3, 93.37), (2, 14, 1, 35.4), (2, 8, 3, 85.8), (2, 18, 2, 39.99), (2, 16, 2, 89.99), (3, 19, 1, 125.0),
    (3, 18, 3, 39.99), (3, 1, 2, 51.79), (4, 2, 1, 93.37), (4, 5, 1, 74.57), (4, 5, 3, 74.57), (5, 20, 2, 149.99), (6, 5, 3, 74.57),
    (6, 13, 2, 120.5), (6, 7, 2, 23.46), (6, 8, 2, 85.8), (7, 18, 1, 39.99), (7, 17, 3, 299.99), (7, 9, 3, 75.61), (7, 10, 2, 91.79),
    (8, 5, 2, 74.57), (8, 17, 3, 299.99), (8, 5, 3, 74.57), (9, 9, 3, 75.61), (9, 9, 3, 75.61), (9, 19, 1, 125.0), (10, 17, 1, 299.99),
    (10, 7, 2, 23.46), (11, 20, 2, 149.99), (12, 9, 3, 75.61), (12, 20, 2, 149.99), (12, 5, 1, 74.57), (12, 7, 3, 23.46), (12, 6, 2, 54.42),
    (13, 10, 3, 91.79), (14, 7, 2, 23.46), (14, 8, 1, 85.8), (15, 7, 2, 23.46), (15, 11, 1, 45.25), (16, 20, 3, 149.99), (16, 12, 1, 69.99),
    (16, 10, 2, 91.79), (17, 8, 3, 85.8), (17, 18, 2, 39.99), (17, 4, 2, 85.29), (17, 17, 2, 299.99), (18, 10, 3, 91.79), (18, 18, 1, 39.99),
    (19, 2, 1, 93.37), (19, 1, 1, 51.79), (20, 11, 1, 45.25), (20, 6, 1, 54.42);

   
   
   
   
   
 