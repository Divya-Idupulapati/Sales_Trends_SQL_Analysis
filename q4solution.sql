with cte1 as (
SELECT
	p.segment,
    count(distinct(s.product_code)) as unique_product_2020 
FROM fact_sales_monthly s
LEFT JOIN
dim_product p
USING(product_code)
WHERE fiscal_year = 2020
GROUP BY fiscal_year, p.segment),

cte2 as (
SELECT
	p.segment,
    count(distinct(s.product_code)) as unique_product_2021 
FROM fact_sales_monthly s
LEFT JOIN
dim_product p
USING(product_code)
WHERE fiscal_year = 2021
GROUP BY fiscal_year, p.segment)

SELECT 
	cte1.segment,
	cte1.unique_product_2020,
	cte2.unique_product_2021,
    unique_product_2021 - unique_product_2020 as difference
FROM cte1 join cte2 
USING(segment)
ORDER BY difference desc
;