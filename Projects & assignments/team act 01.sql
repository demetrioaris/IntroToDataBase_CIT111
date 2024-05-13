use bike;

-- What is the total revenue generated from bike sales,
-- broken down by bike category?

SELECT 
    YEAR(o.shipped_date) AS Year,
    MONTH(o.shipped_date) AS Month,
    category.category_name,
    SUM(oi.quantity * p.list_price) AS total_revenue
FROM 
    cust_order o
JOIN 
    cust_order_item oi ON o.order_id = oi.order_id
JOIN 
    product p ON oi.product_id = p.product_id
JOIN 
    category ON p.category_id = category.category_id
WHERE 
    YEAR(o.shipped_date) = 2016
GROUP BY 
    Year, Month, category.category_name;
    