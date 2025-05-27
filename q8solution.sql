SELECT
    CASE 
        WHEN MONTH(date) BETWEEN 9 AND 11 THEN 'Q1'
        WHEN MONTH(date) IN (12, 1, 2) THEN 'Q2'
        WHEN MONTH(date) BETWEEN 3 AND 5 THEN 'Q3'
        ELSE 'Q4'
    END AS sales_quarter,
    SUM(sold_quantity) AS total_units_sold
FROM fact_sales_monthly
WHERE fiscal_year = 2020
GROUP BY sales_quarter
ORDER BY total_units_sold DESC;
