USE OnlineShop;


-- Retrieve the count of orders for each payment method, excluding cards of banks
SELECT payment_method, COUNT(order_id) AS Quantity_of_orders
FROM OrderPayments AS p
WHERE payment_method NOT LIKE '%Card'
GROUP BY payment_method
ORDER BY Quantity_of_orders DESC


--Retrieve distinct customer details and order dates for orders placed between '2024-01-02' and '2024-01-04'
SELECT DISTINCT CONCAT(first_name,' ', last_name) AS fullname, email, o.order_date
FROM Orders AS o
FULL JOIN Customers AS c
ON o.customer_id = c.customer_id
WHERE order_date BETWEEN '2024-01-02' AND '2024-01-04'
ORDER BY o.order_date ASC;

--- ALL code below created to combine data from 'Orders' and 'Orders_new' using UNION
SELECT * INTO Orders_new
FROM Orders 
WHERE 1= 0

SELECT *
FROM Orders_new

INSERT INTO Orders_new (order_id, customer_id, order_date, product_id)
VALUES 
    (7, 6, '2024-01-03', 6),
    (9, 7, '2024-01-05', 6),
    (10, 8, '2024-01-05', 2),
	(11, 3, '2024-02-03', 2),
	(12, 6, '2024-02-06', 7),
	(13, 8, '2024-02-08', 6);

SELECT *
FROM Orders AS o
UNION
SELECT *
FROM Orders_new

--Select rows from 'Orders_new' where order_id does not exist in 'Orders'
SELECT *
FROM Orders_new AS new
WHERE new.order_id NOT IN (SELECT order_id FROM Orders)

-- Calculate the total revenue for the top 3 products with a total price greater than 100
WITH CTE AS
(
    SELECT order_id, customer_id, order_date, product_id
    FROM Orders
    UNION
    SELECT order_id, customer_id, order_date, product_id
    FROM Orders_new
)
SELECT TOP 3 product_name, SUM(price) AS Revenue
FROM CTE as c
INNER JOIN Products AS p
on c.product_id = p.product_id
GROUP BY product_name
HAVING SUM(price)> 100
ORDER BY Revenue DESC;

-- Calculate total price considering discounts for orders within specified date ranges
SELECT order_id, ROUND((Price - PRICE*discount_percentage/100),2) AS Total_price
FROM (Orders AS o
INNER JOIN Products AS p
on o.product_id = p.product_id)
INNER JOIN Discounts AS d
on p.product_id = d.product_id
WHERE order_date between start_date AND end_date

-- Retrieve all columns from the Products table and calculate the maximum price per category using window function
SELECT *, MAX(price) OVER(PARTITION BY category) AS max_per_category
FROM Products

-- Retrieve all columns from the Products table and add a column for the maximum price in each product's category using a subquery
SELECT p1.*, (SELECT MAX(price) FROM Products as p2 WHERE p2.category = p1.category) AS max_price_in_category
FROM Products as p1;