 --DML QUERIES

 --SELECT ALL PRODUCT WITH BRAND ?Cacti Plus?
SELECT * from product
where brand='Cacti Plus'

-- Count of total products with product category =? Skin Care?
select COUNT (*) category from product
where category ='Skin Care'

-- Count of total products with MRP more than 100
select COUNT (*) from product
where mrp >100


-- Count of total products with product category = ?Skin Care? and MRP more than 100
select COUNT (*) from product
where category= 'Skin Care' and mrp > 100

-- Brandwise product count
select product.brand, count (product.product_id) from product	
group by brand

--Brandwise as well as Active/Inactive Status wise product count
select product.brand,
	sum(case when active = 'Y' then 1 else 0 end) as active,
	sum(case when active = 'N' then 1 else 0 end) as inactive,
	COUNT(*) AS totals
from product
group by brand

--Display all columns with Product category in Skin Care or Hair Care
select * from product
where category = 'Skin Care' or category = 'Hair Care'

--Display   all   columns   with   Product   category=?Skin   Care?   and Brand=?Pondy?, and MRP more than 100
SELECT * FROM   product
WHERE  mrp > 100
       AND ( category = 'Skin Care'
             AND brand = 'Pondy' );

--Brandwise product count
SELECT product.brand,
       Count (product.product_id)
FROM   product
GROUP  BY brand

--Brandwise as well as Active/Inactive Status wise product count
SELECT product.brand,
       Sum(CASE
             WHEN active = 'Y' THEN 1
             ELSE 0
           END) AS active,
       Sum(CASE
             WHEN active = 'N' THEN 1
             ELSE 0
           END) AS inactive,
       Count(*) AS totals
FROM   product
GROUP  BY brand

--Display all columns with Product category in Skin Care or Hair Care
SELECT *
FROM   product
WHERE  category = 'Skin Care' OR category = 'Hair Care'

--Display   all   columns   with   Product   category=?Skin   Care?   and Brand=?Pondy?, and MRP more than 100
SELECT * FROM   product
WHERE  mrp > 100
       AND ( category = 'Skin Care' AND brand = 'Pondy' );

--Display all product names only with names starting from letter P
SELECT * FROM   product
WHERE  product_name LIKE 'P%'

--Display  all product  names only with names Having letters ?Bar?  in Between
SELECT * FROM   product
WHERE  product_name LIKE '%Bar%'

SELECT *
FROM   sales

--Sales of those products which have been sold in more than two quantity in a bill
SELECT * FROM   sales
WHERE  qty > 2

--Sales of those products which have been sold in more than two quantity throughout the bill
SELECT product_id,
       Sum(qty) quantity
FROM   sales
GROUP  BY product_id
HAVING Sum(qty) > 2


-- Create a new table with columns username and birthday, and dump data from dates file. Convert it to .csv format if required.
Create table userBirthdate(
username varchar(30),
birthday date
);

BULK INSERT dbo.userBirthdate
FROM 'C:\Users\sadik\Desktop\dates.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR ='\n'
)

select COUNT(username) from userBirthdate
where birthday IN (
  select birthday FROM userBirthdate
  group by birthday
  having COUNT(birthday) > 1
)

--find no of people sharing Birth month
select COUNT(username) from userBirthdate where birthday IN( select birthday from dbo.userBirthdate group by birthday having count(birthday)> 1)

--find no of people sharing Weekday
select COUNT(username), DATENAME(weekday, GETDATE()) as WEEKDAY from userBirthdate

--Find the current age of all people
select *, DATEDIFF(year, birthday, GETDATE()) Age from userBirthdate