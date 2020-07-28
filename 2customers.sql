USE sql_purchases;
drop table if exists sql_purchases.customer;
drop table if exists sql_purchases.customer_country;

-- CREATE TABLE customers
-- 	FROM purchase_data

CREATE TABLE `customer`
SELECT customerid, 
		count(invoiceno) as invoice_count, 
		sum(quantity) AS total_units,
        round(avg(unitprice * quantity),2) as avg_invoice_amt,
        round(sum(unitprice * quantity),2) as total_invoice_amt
FROM purchase_data 
GROUP BY customerid
ORDER BY customerid;

create table `customer_country`
select distinct customerid, country
FROM purchase_data
ORDER BY customerid;



