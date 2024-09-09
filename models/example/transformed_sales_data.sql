-- models/example/transformed_sales_data.sql

{{ config(materialized='table') }}

WITH raw_data AS (
    SELECT
        ORDER_ID AS order_id,
        ORDER_DATE AS order_date,
        CUSTOMER_ID AS customer_id,
        PRODUCT_ID AS product_id,
        PRODUCT_NAME AS product_name,
        QUANTITY AS quantity,
        PRICE AS price,
        ORDER_STATUS AS order_status
    FROM {{ ref('sales') }}
),

-- Extract year, month, and day from order_date
extracted_date AS (
    SELECT
        order_id,
        order_date,
        customer_id,
        product_id,
        product_name,
        quantity,
        price,
        order_status,
        EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_year,
        EXTRACT(MONTH FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_month,
        EXTRACT(DAY FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_day
    FROM raw_data
),

-- Calculate total sales amount for each order
aggregated_data AS (
    SELECT
        order_id,
        customer_id,
        order_year,
        order_month,
        order_day,
        SUM(quantity * price) AS total_sales_amount
    FROM extracted_date
    GROUP BY
        order_id,
        customer_id,
        order_year,
        order_month,
        order_day
)

SELECT * FROM aggregated_data
