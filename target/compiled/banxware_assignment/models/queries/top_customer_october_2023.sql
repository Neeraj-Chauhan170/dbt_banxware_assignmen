-- queries/top_customer_october_2023.sql

SELECT 
    customer_id,
    COUNT(order_id) AS order_volume
FROM HOME_ASSIGNMENT.PUBLIC.transformed_sales_data
WHERE order_year = 2023
AND order_month = 10
GROUP BY customer_id
ORDER BY order_volume DESC
LIMIT 1