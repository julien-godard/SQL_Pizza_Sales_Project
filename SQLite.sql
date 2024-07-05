-- This is a small SQL exploratory data analysis project using a "Pizza Sales" dataset to demonstrate knowledge of SQL concepts.
-- Made by Julien Godard - Thank you for your time.

-- Dataset Source: https://www.kaggle.com/datasets/nextmillionaire/pizza-sales-dataset
-- Editing done on https://sqliteonline.com/



-- We will be answering some business questions for a pizzeria!

-- Checking for any missing values in key fields

SELECT COUNT(*) AS missing_values
FROM pizza_sales
WHERE pizza_name_id ISNULL OR quantity ISNULL OR unit_price ISNULL or pizza_category ISNULL OR pizza_name ISNULL;

-- Identifying the number of different pizzas

SELECT COUNT(DISTINCT pizza_name)
FROM pizza_sales;



-- What are our top 10 most purchased pizzas?

SELECT pizza_name, pizza_category, SUM(quantity) AS total_bought
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_bought DESC
LIMIT 10;

-- How many of our veggie pizzas have we sold as small and medium sizes?

SELECT pizza_name, pizza_size, SUM(quantity) AS total_bought
FROM pizza_sales
WHERE pizza_category = 'Veggie' AND (pizza_size = 'S' OR pizza_size = 'M')
GROUP BY pizza_size, pizza_name
ORDER BY total_bought DESC;

-- What are our least popular classic pizza ingredient combinations?

SELECT pizza_name, pizza_ingredients, SUM(quantity) AS total_bought
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY total_bought ASC;

-- What is our average order value?

SELECT CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS avg_order_value
FROM pizza_sales;

-- How many large (higher than £30) orders have we had compared to small (less than £15) orders?

SELECT CASE
			WHEN total_price > 30.00 THEN 'Large'
  			WHEN total_price < 15.00 THEN 'Small'
    		ELSE 'Medium'
       END AS order_size,
COUNT(DISTINCT order_id) as orders_placed
FROM pizza_sales
WHERE order_size = 'Large' OR order_size = 'Small'
GROUP BY order_size
ORDER BY orders_placed DESC;