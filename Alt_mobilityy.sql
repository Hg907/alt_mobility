----Order and Sales Analysis----

--1. Order Count by Status
SELECT order_status, COUNT(*) AS order_count, SUM(order_amount) AS revenue
FROM customer_orders GROUP BY order_status;

--2.Revenue trends
SELECT COUNT(*) AS total_orders, SUM(order_amount) AS total_revenue 
FROM customer_orders;

--3.Monthly performance
SELECT
    TO_CHAR(orders.order_date, 'YYYY-MM') AS month,
COUNT(DISTINCT orders.order_id) AS total_orders,
SUM(orders.order_amount) AS total_order_amount,
COUNT(DISTINCT payments.payment_id) FILTER (WHERE payments.payment_status = 'completed') AS completed_payments,
SUM(payments.payment_amount) FILTER (WHERE payments.payment_status = 'completed') AS total_payment_received
FROM customer_orders AS orders
LEFT JOIN payments
ON orders.order_id = payments.order_id
GROUP BY TO_CHAR(orders.order_date, 'YYYY-MM')
ORDER BY month;

----Customer Analysis----

--1. Unique vs repeat customers
SELECT
COUNT(*) FILTER (WHERE order_count = 1) AS unique_customers,
COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers
FROM (
SELECT customer_id, COUNT(*) AS order_count
FROM customer_orders
GROUP BY customer_id
) AS customer_order_counts;

--2. Ordering behavior
SELECT 
customer_id,
COUNT(*) AS total_orders,
SUM(order_amount) AS total_spent
FROM customer_orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 5;

--.3 Repeat Customers
SELECT customer_id, COUNT(*) AS order_count FROM customer_orders
GROUP BY customer_id 
HAVING COUNT(*) > 1 
ORDER BY order_count DESC;

---Payment Status Analysis----

-- 1. Payment Status Overview
SELECT payment_status, COUNT(*) AS count, SUM(payment_amount) AS total_amount
FROM payments 
GROUP BY payment_status;

--2. Payment Method Usage
SELECT payment_method, COUNT(*) AS count, SUM(payment_amount) AS total_amount
FROM payments 
GROUP BY payment_method;

----Comprehensive Order Report----
----1. Order Details Report (Join orders + payments)
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_amount,
    o.order_status,
    p.payment_id,
    p.payment_date,
    p.payment_amount,
    p.payment_method,
    p.payment_status
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id;


-------thank you sir------


