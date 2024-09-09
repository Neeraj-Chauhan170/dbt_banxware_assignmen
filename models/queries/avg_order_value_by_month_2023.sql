-- queries/avg_order_value_by_month_2023.sql

SELECT 
    order_month,
    AVG(total_sales_amount) AS avg_order_value
FROM {{ ref('transformed_sales_data') }}
WHERE order_year = 2023
GROUP BY order_month
ORDER BY order_month