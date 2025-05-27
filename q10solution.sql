WITH ranked_products AS (
    SELECT 
        dp.division,
        dp.product_code,
        dp.product,
        SUM(fs.sold_quantity) AS total_units_sold,
        DENSE_RANK() OVER (
            PARTITION BY dp.division 
            ORDER BY SUM(fs.sold_quantity) DESC
        ) AS sales_rank
    FROM dim_product dp
    LEFT JOIN fact_sales_monthly fs
        ON dp.product_code = fs.product_code
    WHERE fs.fiscal_year = 2021
    GROUP BY dp.division, dp.product_code, dp.product
)

SELECT *
FROM ranked_products
WHERE sales_rank <= 3;
