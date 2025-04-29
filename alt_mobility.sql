--Total Orders and Revenue
SELECT COUNT(*) AS total_orders, SUM(order_amount) AS total_revenue 
FROM customer_orders;

-- Order Count by Status
SELECT order_status, COUNT(*) AS order_count, SUM(order_amount) AS revenue
FROM customer_orders GROUP BY order_status;

-- Monthly Order Trend
SELECT 
DATE_TRUNC('month', order_date)::date AS month,
COUNT(*) AS order_count,
SUM(order_amount) AS revenue
FROM customer_orders
GROUP BY month
ORDER BY month;

-- Repeat Customers
SELECT customer_id, COUNT(*) AS order_count FROM customer_orders
GROUP BY customer_id 
HAVING COUNT(*) > 1 
ORDER BY order_count DESC;

-- Top Customers by Revenue
SELECT customer_id, COUNT(*) AS order_count, SUM(order_amount) AS total_spent
FROM customer_orders 
GROUP BY customer_id 
ORDER BY total_spent DESC
LIMIT 10;

-- Payment Status Overview
SELECT payment_status, COUNT(*) AS count, SUM(payment_amount) AS total_amount
FROM payments 
GROUP BY payment_status;

-- Payment Method Usage
SELECT payment_method, COUNT(*) AS count, SUM(payment_amount) AS total_amount
FROM payments 
GROUP BY payment_method;

---- 8. Order Details Report (Join orders + payments)
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


-------


