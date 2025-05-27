
WITH cte1 AS(
SELECT customer_code, pre_invoice_discount_pct 
FROM fact_pre_invoice_deductions 
WHERE pre_invoice_discount_pct >=
	(Select AVG(pre_invoice_discount_pct) avg_d FROM fact_pre_invoice_deductions WHERE fiscal_year =2021)
)

SELECT 
	c.customer_code,
    c.customer,
    round(cte1.pre_invoice_discount_pct,4) as average_discount_percentage
FROM dim_customer c
LEFT JOIN cte1
USING (customer_code)
WHERE c.market = "India"
ORDER BY average_discount_percentage desc
LIMIT 5
