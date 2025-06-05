# Mint-Classics-Inventory-Analysis

My approach to this analysis was structured around the business problem:

“Can we close a warehouse and still maintain timely customer service?”

Here’s how I tackled it:

1. Understanding the Schema
I began by exploring the structure of the Mint Classics database, identifying key tables such as products, orderdetails, orders, and warehouses. I used DESCRIBE and SELECT queries to examine relationships and data quality.

2. Exploratory Queries
I developed a set of exploratory SQL queries to examine:

Inventory levels by warehouse

Sales volumes by product

Inventory vs. sales mismatches

Slow-moving or unsold products

3. Proxy Measures
Because the schema didn’t directly link orders to warehouses, I used product location (via warehouseCode) and order details as a proxy for identifying warehouse activity.

4. Insights and Recommendations
Based on query results, I could:

Identify underutilized warehouses

Flag products with high stock but no sales

Suggest consolidating slow-moving items to fewer locations

5. Clean Code and Documentation
I structured my SQL script with clear comments, grouped queries logically, and named all output columns meaningfully so others could interpret my analysis easily.

# Files Included

`README.md`: Project summary and documentation

`queries.sql`: All SQL code used



