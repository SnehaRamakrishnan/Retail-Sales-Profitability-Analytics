-- ============================================================
-- Retail Sales & Profitability Analytics
-- Database: MySQL
-- ============================================================

-- Create database
CREATE DATABASE IF NOT EXISTS retail_sales_analysis;

USE retail_sales_analysis;


-- ============================================================
-- 1. Create Sales Table
-- ============================================================

CREATE TABLE IF NOT EXISTS sales_data (
    row_id INT,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(150),
    segment VARCHAR(50),
    country_region VARCHAR(100),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(12,4),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,4)
);


-- ============================================================
-- 2. Data Validation
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM sales_data;

SELECT COUNT(DISTINCT row_id) AS unique_rows
FROM sales_data;

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM sales_data;

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM sales_data;


-- ============================================================
-- 3. Overall Business KPIs
-- ============================================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM sales_data;


-- ============================================================
-- 4. Monthly Sales & Profit
-- ============================================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_data
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;


-- ============================================================
-- 5. Sales & Profit by Category
-- ============================================================

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM sales_data
GROUP BY category
ORDER BY total_sales DESC;


-- ============================================================
-- 6. Sales & Profit by Sub-Category
-- ============================================================

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM sales_data
GROUP BY sub_category
ORDER BY total_sales DESC;


-- ============================================================
-- 7. Sales & Profit by Region
-- ============================================================

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;


-- ============================================================
-- 8. Sales & Profit by Customer Segment
-- ============================================================

SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM sales_data
GROUP BY segment
ORDER BY total_sales DESC;


-- ============================================================
-- 9. Discount vs Profitability
-- ============================================================

SELECT
    discount,
    COUNT(*) AS order_lines,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM sales_data
GROUP BY discount
ORDER BY discount;


-- ============================================================
-- 10. Top 10 Products by Sales
-- ============================================================

SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_data
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


-- ============================================================
-- 11. Loss-Making Products
-- ============================================================

SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_data
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 10;


-- ============================================================
-- 12. State-Level Performance
-- ============================================================

SELECT
    state_province,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM sales_data
GROUP BY state_province
ORDER BY total_sales DESC;


-- ============================================================
-- 13. Yearly Performance
-- ============================================================

SELECT
    YEAR(order_date) AS year,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM sales_data
GROUP BY YEAR(order_date)
ORDER BY year;
