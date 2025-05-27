SELECT 
    segment, 
    COUNT(DISTINCT product) AS total_unique_products
FROM dim_product
GROUP BY segment
ORDER BY total_unique_products DESC;
