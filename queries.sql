-- Objective: Analyze inventory and sales data to support a decision to reduce or reorganize inventory and potentially close a warehouse.

-- 1. Preview a sample of products and their inventory levels

SELECT 
    productCode, 
    productName, 
    productLine, 
    quantityInStock, 
    buyPrice, 
    MSRP
FROM products
LIMIT 20;


-- 2. Summary of inventory stored in each warehouse
-- This shows how many products and total units are in each warehouse

SELECT 
    w.warehouseCode,
    w.warehouseName,
    COUNT(p.productCode) AS total_products,
    SUM(p.quantityInStock) AS total_inventory
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY total_inventory DESC;


-- 3. Compare inventory levels with total units sold (per product)
-- Useful for checking if current stock is aligned with demand

SELECT 
    p.productCode,
    p.productName,
    p.quantityInStock,
    IFNULL(SUM(od.quantityOrdered), 0) AS total_quantity_sold
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
ORDER BY total_quantity_sold DESC;


-- 4. Identify products with inventory but no recorded sales
-- These may be candidates for discontinuation

SELECT 
    p.productCode,
    p.productName,
    p.quantityInStock,
    IFNULL(SUM(od.quantityOrdered), 0) AS total_quantity_sold
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock
HAVING total_quantity_sold = 0
ORDER BY quantityInStock DESC;


-- 5. Total quantity of products ordered from each warehouse
-- Helps identify which warehouses are responsible for fulfilling the most orders

SELECT 
    w.warehouseCode,
    w.warehouseName,
    SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY total_quantity_ordered DESC;


-- 6. Average time (in hours) from order placement to shipment
-- Supports recommendations around maintaining 24-hour delivery goal

SELECT 
    AVG(TIMESTAMPDIFF(HOUR, orderDate, shippedDate)) AS avg_hours_to_ship
FROM orders
WHERE shippedDate IS NOT NULL;


-- 7. Inventory and sales breakdown by product line
-- Helps understand which product categories are contributing most to sales

SELECT 
    p.productLine,
    COUNT(p.productCode) AS num_products,
    SUM(p.quantityInStock) AS total_inventory,
    IFNULL(SUM(od.quantityOrdered), 0) AS total_quantity_sold
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY total_quantity_sold DESC;
