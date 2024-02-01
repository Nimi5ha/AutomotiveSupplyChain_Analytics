select * from supplier
order by 4 

--select*
--from customer
--order by 3

--which is the first CarModel sold?
select Top 1 CarModel, SupplierName from dbo.supplier
order by OrderDate ,ShipDate 

--which city have the most order?
select Count(*) as Orders,customer.City
from supplier
join customer on customer.OrderID = Supplier.OrderID
group by customer.City 
order by Orders desc

--what are top 3 Prices of order?
SELECT TOP 3 CarPrice FROM supplier
ORDER By CarPrice desc


--which city have the best customer for advertisment?
select sum(supplier.CarPrice) as total_price,City from customer
join supplier on customer.OrderID= supplier.OrderID
group by City
order by total_price desc

--which best customer has spend the most money and on which product?
select Top 1 customer.CustomerID ,customer.CustomerName,sum(supplier.CarPrice) as total
from customer
join supplier on customer.OrderID= supplier.OrderID
group by customer.CustomerID , customer.CustomerName
order by total desc


--Find out most popular profession for each city. we determine most  popular profession with highest amount of purchases. write query that returns 
--each city along with top professions.
with popular_profession as
(
	select Max(supplier.Sales) as purchases,customer.City as city , customer.JobTitle, 
	ROW_NUMBER() over(partition by customer.city order by count(supplier.Quantity)desc) as RowNo
	from customer
	join supplier on customer.OrderID=supplier.OrderID
	group by customer.City, customer.JobTitle
)
select  * from popular_profession where RowNo <= 1 
order by city ,purchases desc

--KPI
--Total Sales
select sum(sales) from supplier

--total orders
select count(distinct orderid) as total_orders from supplier

--Avg orders per value
Select Sum(sales)/count(distinct orderid) as avg_order from supplier

--Total cars sold
select sum(quantity) from supplier

--avg cars per orders
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct orderid) as decimal(10,2))  as decimal(10,2))from supplier


--Daily trend for total orders
select DATENAME(DW,OrderDate) as order_day, Count( OrderID) as total_orders from supplier
group by DATENAME(DW,OrderDate)
order by total_orders desc

--monthly order trend
select DATENAME(month,OrderDate) as Month_name, COUNT(Distinct OrderID) as total_order from supplier
group by  DATENAME(month,OrderDate)
order by total_order desc

--Customerfeedback
SELECT Customerfeedback, COUNT(DISTINCT state) as state_count
FROM customer
GROUP BY Customerfeedback


