-- CREATE pizza_orders_db DATABASE
CREATE DATABASE pizza_orders_db;

-- INSERT DATA INTO DATABASE (RIGHT CLICK 'Tables', Table Data Import Wizard)

-- UPDATE COLUMN DATA TYPES
ALTER TABLE pizza_sales
MODIFY Order_Date DATE,
MODIFY Unit_Price DECIMAL(10,2),
MODIFY Total_Price DECIMAL(10,2),
MODIFY Pizza_Size VARCHAR(3),
MODIFY Pizza_Category VARCHAR(100),
MODIFY Pizza_Name VARCHAR(100)
;

-- SALES PERFORMANCE QUERIES --

-- WHAT IS THE TOTAL REVENUE GENERATED FROM PIZZA SALES?
SELECT SUM(Total_Price) AS total_revenue
FROM pizza_sales; 
-- Total revenue is $817,860.05

-- WHICH PIZZA SIZE GENERATED THE MOST REVENUE?
SELECT Pizza_Size, SUM(Total_Price) AS total_revenue_by_size
FROM pizza_sales
GROUP BY Pizza_Size
ORDER BY total_revenue_by_size DESC
LIMIT 1;
-- Large sized pizzas generated the most revenue with $375,318.70 of total revenue

-- DATE AND TIME ANALYSIS --

-- WHAT IS THE TOTAL NUMBER OF ORDERS PLACED EACH MONTH?
SELECT MONTH(Order_Date) AS month, COUNT(Order_ID) AS total_orders
FROM pizza_sales
GROUP BY MONTH(Order_Date);
-- January = 4156, February = 3892, March = 4186, April = 4067, May = 4239, June = 4025, July = 4301, August = 4094, September = 3819, October = 3797, November = 4185, December = 3859

-- WHICH DAY OF THE WEEK HAS THE HIGHEST PIZZA SALES BY TOTAL REVENUE?
SELECT DAYNAME(Order_Date) AS day, SUM(Total_Price) AS revenue
FROM pizza_sales
GROUP BY DAYNAME(Order_Date)
ORDER BY revenue DESC
LIMIT 1;
-- Friday has the highest revenue, with a total of $136,073.90

-- WHAT IS THE AVERAGE NUMBER OF PIZZAS SOLD PER ORDER?
SELECT AVG(Quantity) AS avg_pizzas_per_order
FROM pizza_sales;
-- The average number of pizzas per order is 1.0196

-- PRODUCT LEVEL INSIGHTS --

-- WHICH PIZZA CATEGORY GENERATES THE HIGHEST REVENUE? SORT FROM HIGHEST TO LOWEST.
SELECT Pizza_Category, SUM(Total_Price) AS total_revenue_per_category
FROM pizza_sales
GROUP BY Pizza_Category
ORDER BY total_revenue_per_category DESC;
-- Highest to lowest: Classic, Supreme, Chicken, Veggie

-- WHICH IS THE LEAST SOLD PIZZA CATEGORY BY TOTAL QUANTITY?
SELECT Pizza_Category, SUM(Quantity) AS total_sold
FROM pizza_sales
GROUP BY Pizza_Category
ORDER BY total_sold
LIMIT 1;
-- Chicken has the least amount of pizzas sold in quantity

-- CUSTOMER ORDER BAHAVIOR --

-- WHAT PERCENTAGE OF TOTAL SALES CAME FROM EACH PIZZA SIZE?
SELECT Pizza_Size, SUM(Total_Price) AS total_sales, ROUND(SUM(Total_Price) * 100.0 / (SELECT SUM(Total_Price) FROM pizza_sales), 2) AS percentage_of_sales
FROM pizza_sales
GROUP BY Pizza_Size
ORDER BY percentage_of_sales DESC;
-- Percentages: L - 45.89%, M - 30.49%, S - 21.77%, XL - 1.72%, XXL - 0.12%

-- DATA CLEANING CHECKS --

-- WHAT IS THE MINIMUM, MAXIMUM, AND AVERAGE UNIT PRICE FOR PIZZAS?
SELECT Order_ID, Quantity, Order_Date, Unit_Price, Total_Price, Pizza_Size, Pizza_Category, Pizza_Name, MIN(Unit_Price) OVER () AS Min_Unit_Price, MAX(Unit_Price) OVER () AS Max_Unit_Price, ROUND(AVG(Unit_Price) OVER (), 2) AS AVG_Unit_Price
FROM pizza_sales;

-- SELECT EVERYTHING QUERY
SELECT *
FROM pizza_sales;