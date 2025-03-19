-- SQL Retail Sales Analysis - P1

-- Create Table

CREATE TABLE retail_sales
			(
				transactions_id	INT PRIMARY KEY,
				sale_date DATE,	
				sale_time TIME,	
				customer_id INT,	
				gender VARCHAR(15),	
				age INT,	
				category VARCHAR(20),	
				quantiy INT,	
				price_per_unit FLOAT,	
				cogs FLOAT,	
				total_sale FLOAT
			);

SELECT COUNT (*)
FROM RETAIL_SALES;

SELECT  * FROM RETAIL_SALES;
-- cleaning data process. check if data has any null values anywhere --
SELECT * FROM RETAIL_SALES
WHERE 
	transactions_id is null
	or
	sale_date IS NULL
	or
	sale_time is null
	or
	customer_id is null
	or
	gender IS NULL
	or
	age is null
	or
	category IS NULL
	or
	quantity is null
	or
	price_per_unit IS NULL
	or
	cogs is null
	or
	total_sale is null;
-- alter table to correct quantiy to quantity --
alter table retail_sales
rename column quantiy to quantity;

select * from retail_sales;

-- DELETE DATA WHERE IS NULL --
DELETE FROM RETAIL_SALES
WHERE 
	transactions_id is null
	or
	sale_date IS NULL
	or
	sale_time is null
	or
	customer_id is null
	or
	gender IS NULL
	or
	age is null
	or
	category IS NULL
	or
	quantity is null
	or
	price_per_unit IS NULL
	or
	cogs is null
	or
	total_sale is null;

-- DATA EXPLOERATION --

-- HOW MANY SALES DO WE HAVE?

SELECT COUNT (*)AS total_sale from retail_sales;

-- how many customers do we have? --  1987


-- how many unique customers do we have -- 155

SELECT COUNT ( distinct customer_id) AS total_sale FROM retail_sales;


SELECT DISTINCT category FROM retail_sales;
-- 3 --

-- ELECTRONICS, CLOTHING, BEAUTY --
-----------------------------------------------------------------------

-- Data Analysis & Business Key Problems & Answers --

-- 1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**: --\

SELECT * FROM retail_sales
where sale_date = '2022-11-05';

/*2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10
 in the month of Nov-2022 */

SELECT *
FROM retail_sales
where category = 'Clothing'
	and
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND 
	quantity >= 4;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
	   sum(total_sale) as total_sales,
	   count(*) as total_orders
FROM
	retail_sales
group by category;


-- 4.write a SQL query to find the average age of customers who purchased items from the 'Beauty' category --
select * from retail_sales;
select 
	round(avg(age),2) as avg_age
from 
	retail_sales
where 
	category = 'Beauty';

-- 5.Write a SQl query to find all transactions where the total_sales is greater than 1000 --

SELECT * FROM retail_sales
where total_sale >= 1000;
	
-- Write a query to find the total number of transactions (transaction_id) made by each gender in each category --

SELECT 
	category,
	gender,
	count(*) as total_transaction
FROM 
	retail_sales
group
	by
	category,
	gender
order
	by
	1 asc;

--7. Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year. --
select 
	year,
	month,
	"Average Sale"
from
(
SELECT 
	EXTRACT(YEAR FROM SALE_DATE) AS year,
	EXTRACT(MONTH FROM SALE_DATE) AS month,
	avg(total_sale) as "Average Sale",
	rank() over(partition by EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM 
	retail_sales
group 
	by
	1,2) as t1
where rank = 1;
--ORDER
	--BY
--	1,3 desc;

--8. Write a SQL query to find top 5 customers based on the heighest total sales -- 
SELECT
	customer_id,
	sum(total_sale) as top_five_total_sales
	--rank () over(partition by sum(total_sale) order by customer_id desc) as rank
FROM 
	retail_sales
group by customer_id
order by 2 desc limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category --

SELECT 
	category,
	count(distinct customer_id) as unique_customer_count
FROM
	retail_sales
group
	by
	1;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <=,Afternoon Between 12 & 17, Evening >17) --
select * from retail_sales
---------------------------
with hourly_sale
as
(
SELECT *,
	case
		when EXTRACT(HOUR FROM sale_time) < 12 then 'Morning'
		when EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 then 'Afternoon'
		else 'Evening'
	end as shift
FROM retail_sales)
select 
	shift,
	count(*) as total_orders
from
	hourly_sale
group
	by 
	shift

-- Projoects had ended --



