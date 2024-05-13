use bike;

-- What is the total revenue generated from bike sales,
-- broken down by bike category?
SELECT
    category.category_name,
    SUM(cust_order_item.quantity * product.list_price) AS total_revenue
FROM
	cust_order_item
JOIN
	product ON cust_order_item.product_id = product.product_id
JOIN 
	category ON product.category_id = category.category_id
GROUP BY
	category.category_name