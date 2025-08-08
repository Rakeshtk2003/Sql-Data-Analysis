CREATE DATABASE Ecommerce_DB;
USE Ecommerce_DB;

-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(30),
    state VARCHAR(30)
);

-- Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2)
);

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Customers
INSERT INTO Customers VALUES
(1, 'Ravi Kumar', 'ravi@example.com', 'Mumbai', 'Maharashtra'),
(2, 'Anita Sharma', 'anita@example.com', 'Chennai', 'Tamil Nadu'),
(3, 'Karan Singh', 'karan@example.com', 'Bengaluru', 'Karnataka');

-- Insert Products
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Headphones', 'Electronics', 2000.00),
(103, 'Coffee Maker', 'Home Appliances', 3500.00),
(104, 'Office Chair', 'Furniture', 7000.00);

-- Insert Orders
INSERT INTO Orders VALUES
(1001, 1, 101, 1, '2025-08-01'),
(1002, 1, 102, 2, '2025-08-02'),
(1003, 2, 103, 1, '2025-08-03'),
(1004, 3, 104, 1, '2025-08-03'),
(1005, 2, 101, 1, '2025-08-04');

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

-- Basic SELECT & WHERE
SELECT customer_name, city, state
FROM Customers
WHERE state = 'Maharashtra';

-- OrderBy
SELECT product_name, price
FROM Products
ORDER BY price DESC;

-- GROUPBY
SELECT category, SUM(price * quantity) AS total_sales
FROM Orders
JOIN Products ON Orders.product_id = Products.product_id
GROUP BY category;

-- INNERJOIN
SELECT Orders.order_id, Customers.customer_name, Products.product_name, Orders.quantity
FROM Orders
INNER JOIN Customers ON Orders.customer_id = Customers.customer_id
INNER JOIN Products ON Orders.product_id = Products.product_id;

-- SUBQUERY
SELECT product_name, price
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

-- VIEW
CREATE VIEW SalesSummary AS
SELECT Customers.customer_name, Products.product_name, Orders.quantity, (Products.price * Orders.quantity) AS total_amount
FROM Orders
JOIN Customers ON Orders.customer_id = Customers.customer_id
JOIN Products ON Orders.product_id = Products.product_id;

-- INDEX
CREATE INDEX idx_customer_id ON Orders(customer_id);