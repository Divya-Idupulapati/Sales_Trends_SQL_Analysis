SELECT 
    EXTRACT(MONTH FROM s.date) AS month,
    EXTRACT(YEAR FROM s.date) AS year,
    ROUND(SUM(s.sold_quantity * g.gross_price), 2) AS gross_sales_amount
FROM fact_sales_monthly s
LEFT JOIN fact_gross_price g
    ON s.fiscal_year = g.fiscal_year AND s.product_code = g.product_code
LEFT JOIN dim_customer c
    ON s.customer_code = c.customer_code
WHERE c.customer = 'Atliq Exclusive'
GROUP BY year, month
ORDER BY year, month;
