-- Create the database
CREATE DATABASE  OnlineShop;

-- Use the OnlineShop database
USE OnlineShop;

-- Create the Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(15)
);

-- Create the Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    product_id INT,
    CONSTRAINT customer1 FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
	CONSTRAINT product1 FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Create the OrderPayments table
CREATE TABLE OrderPayments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    total_amount_paid DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Create the Discounts table
CREATE TABLE Discounts (
    discount_id INT PRIMARY KEY,
    product_id INT,
    discount_percentage DECIMAL(5, 2),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert data into the Products table
INSERT INTO Products (product_id, product_name, category, price)
VALUES 
    (1, 'Laptop', 'Electronics', 899.99),
    (2, 'Smartphone', 'Electronics', 499.99),
    (3, 'Coffee Maker', 'Appliances', 49.99),
    (4, 'Gaming Console', 'Electronics', 299.99),
    (5, 'Fitness Tracker', 'Electronics', 59.99),
    (6, 'Headphones', 'Electronics', 39.99);

-- Insert data into the Customers table
INSERT INTO Customers (customer_id, first_name, last_name, email, phone)
VALUES 
    (1, 'John', 'Doe', 'john.doe@email.com', '123-456-7890'),
    (2, 'Jane', 'Smith', 'jane.smith@email.com', '987-654-3210'),
    (3, 'Robert', 'Johnson', 'robert.johnson@email.com', '456-789-0123'),
    (4, 'Alice', 'Williams', 'alice.williams@email.com', '789-012-3456'),
    (5, 'David', 'Brown', 'david.brown@email.com', '234-567-8901'),
    (6, 'Sarah', 'Miller', 'sarah.miller@email.com', '345-678-9012'),
    (7, 'Michael', 'Jones', 'michael.jones@email.com', '567-890-1234'),
    (8, 'Emily', 'Davis', 'emily.davis@email.com', '678-901-2345');

-- Insert data into the Orders table
INSERT INTO Orders (order_id, customer_id, order_date, product_id)
VALUES 
    (1, 1, '2024-01-01', 2),
    (2, 1, '2024-01-01', 6),
    (3, 2, '2024-01-02', 1),
    (4, 3, '2024-01-02', 4),
    (5, 4, '2024-01-02', 5),
    (6, 5, '2024-01-02', 3),
    (7, 6, '2024-01-03', 6),
    (8, 6, '2024-01-04', 1),
    (9, 7, '2024-01-05', 6),
    (10, 8, '2024-01-05', 2);

-- Insert data into the OrderPayments table
INSERT INTO OrderPayments (payment_id, order_id, payment_date, payment_method, total_amount_paid)
VALUES 
    (1, 1, '2024-01-01', 'Credit Card', 899.99),
    (2, 2, '2024-01-01', 'PayPal', 1199.98),
    (3, 3, '2024-01-02', 'Cash', 99.97),
    (4, 4, '2024-01-02', 'Credit Card', 159.98),
    (5, 5, '2024-01-02', 'Debit Card', 299.97),
    (6, 6, '2024-01-02', 'PayPal', 899.99),
    (7, 7, '2024-01-03', 'Cash', 119.97),
    (8, 8, '2024-01-04', 'Credit Card', 59.98),
    (9, 9, '2024-01-05', 'Debit Card', 119.97),
    (10, 10, '2024-01-05', 'PayPal', 79.98);


-- Insert data into the Discounts table
INSERT INTO Discounts (discount_id, product_id, discount_percentage, start_date, end_date)
VALUES 
    (1, 1, 85.00, '2024-01-01', '2024-01-03'),
    (2, 1, 42.00, '2024-01-05', '2024-01-20'),
    (3, 2, 15.00, '2024-01-01', '2024-01-02'),
    (4, 3, 8.00, '2024-01-04', '2024-01-15'),
    (5, 4, 12.00, '2024-01-05', '2024-02-10'),
    (6, 5, 7.00, '2024-01-08', '2024-02-15'),
    (7, 6, 9.99, '2024-01-01', '2024-01-08'),
    (8, 1, 10.00, '2024-02-05', '2024-02-20'),
    (9, 2, 15.00, '2024-02-10', '2024-02-25'),
    (10, 4, 8.00, '2024-02-15', '2024-03-01');