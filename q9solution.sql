WITH total_sales_2021 AS (
    SELECT 
        ROUND(SUM(g.gross_price * s.sold_quantity) / 1000000, 2) AS overall_gross_sales_mln
    FROM fact_sales_monthly s
    LEFT JOIN fact_gross_price g
        ON s.product_code = g.product_code AND s.fiscal_year = g.fiscal_year
    WHERE s.fiscal_year = 2021
),
sales_by_channel AS (
    SELECT 
        c.channel,
        ROUND(SUM(g.gross_price * s.sold_quantity) / 1000000, 2) AS channel_sales_mln
    FROM fact_sales_monthly s
    LEFT JOIN fact_gross_price g
        ON s.product_code = g.product_code AND s.fiscal_year = g.fiscal_year
    LEFT JOIN dim_customer c
        ON s.customer_code = c.customer_code
    WHERE s.fiscal_year = 2021
    GROUP BY c.channel
)
SELECT 
    sc.channel,
    sc.channel_sales_mln,
    ROUND(sc.channel_sales_mln / ts.overall_gross_sales_mln * 100, 2) AS sales_share_pct
FROM sales_by_channel sc
CROSS JOIN total_sales_2021 ts
ORDER BY sales_share_pct DESC;
