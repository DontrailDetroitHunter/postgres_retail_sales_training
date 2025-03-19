# Retail Sales Analysis PostgreSQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE TABLE retail_sales;

CREATE TABLE retail_sales
			(
				transactions_id	INT PRIMARY KEY,
				sale_date DATE,	
				sale_time TIME,	
				customer_id INT,	
				gender VARCHAR(15),	
				age INT,	
				category VARCHAR(20),	
				quantity INT,	
				price_per_unit FLOAT,	
				cogs FLOAT,	
				total_sale FLOAT
			);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Business Key Problems & Answers

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM retail_sales
where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
where category = 'Clothing'
	and
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND 
	quantity >= 4
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category,
	   sum(total_sale) as total_sales,
	   count(*) as total_orders
FROM
	retail_sales
group by category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales where total_sale >= 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
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
	1 asc
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT
	customer_id,
	sum(total_sale) as top_five_total_sales
	--rank () over(partition by sum(total_sale) order by customer_id desc) as rank
FROM 
	retail_sales
group by customer_id
order by 2 desc limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
	category,
	count(distinct customer_id) as unique_customer_count
FROM
	retail_sales
group
	by
	1
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```
-- Projects has ended -- 
## Findings --

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## My Purpose
This is a training exercise for me to get an understanding of what would be required of me on the job once I get hired. My goal was to see, try, fill
in the gaps of knowledge I lacked, and learn by doing. As a new Data Analyst, coming from Coding Dojo in pursuit of being a Python SWE, I found that Python
is bigger in the data field. I took a specific course in Udemy for Data Analysts; and got my certificate, now I am using exercises like this and others, just like it for simulated
on-the-job training to exhibit I know the basics.

## Things I learned
Question 10 gave me experience in how to use a case statement to create a Postgres version of an if statement.
Also in question 9, I'd only used distinct directly after the count. --(select distinct total_sale as an example.)-- In this scenario it was 
--(count(distinct customer_id)-- I also was able to work on my problem-solving skills. I wrote the question and then I attempted to solve the questions
on my own if I couldn't succeed. I learned that if you don't comprehend the question right, you can achieve what you're trying to do but, be completely wrong.
Question 7 was very important to me, because it reiterated how to extract years and date time.








This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. 

Email: hunterdontrail@yahoo.com 




Thank you for your support, and I look forward to connecting with you!
