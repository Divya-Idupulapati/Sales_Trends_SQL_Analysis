SELECT  
    mc.product_code,
    dp.product,
    mc.manufacturing_cost
FROM fact_manufacturing_cost mc
JOIN dim_product dp USING (product_code)
WHERE mc.manufacturing_cost = (
    SELECT MAX(manufacturing_cost)
    FROM fact_manufacturing_cost
)

UNION

SELECT  
    mc.product_code,
    dp.product,
    mc.manufacturing_cost
FROM fact_manufacturing_cost mc
JOIN dim_product dp USING (product_code)
WHERE mc.manufacturing_cost = (
    SELECT MIN(manufacturing_cost)
    FROM fact_manufacturing_cost
);


