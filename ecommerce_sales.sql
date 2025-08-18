-- SQL Project: E-Commerce Sales Analysis
 CREATE DATABASE Myproject;
 USE MyProject;
/* Create Customers table */
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

/* Create Products table */
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

/* Create Orders table */
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

/* Create Payments table */
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

/* Insert Customers */
INSERT INTO Customers VALUES
(1, 'Ram', 'ram@email.com', 'New York', 'USA'),
(2, 'Bunny', 'bunny@email.com', 'London', 'UK'),
(3, 'Chandu', 'chandu@email.com', 'Delhi', 'India');

/* Insert Products */
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 800.00),
(102, 'Smartphone', 'Electronics', 600.00),
(103, 'Headphones', 'Accessories', 50.00),
(104, 'Shoes', 'Fashion', 120.00);

/* Insert Orders */
INSERT INTO Orders VALUES
(1001, 1, 101, '2025-01-05', 1),
(1002, 2, 102, '2025-01-10', 2),
(1003, 3, 103, '2025-01-12', 3),
(1004, 1, 104, '2025-02-01', 1);

/* Insert Payments */
INSERT INTO Payments VALUES
(5001, 1001, 'Credit Card', 800.00),
(5002, 1002, 'PayPal', 1200.00),
(5003, 1003, 'UPI', 150.00),
(5004, 1004, 'Credit Card', 120.00);

/* Queries */

/* Top 5 Best-Selling Products*/
SELECT p.product_name, SUM(o.quantity) AS total_sold FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

/* Monthly Revenue */
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(amount) AS revenue
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

/* Top Spending Customers */
SELECT c.customer_name, SUM(p.amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

/* Payment Method Analysis */
SELECT payment_method, COUNT(*) AS usage_count, SUM(amount) AS total_amount
FROM Payments
GROUP BY payment_method
ORDER BY total_amount DESC;
