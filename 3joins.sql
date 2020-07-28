USE sql_purchases;
DROP TABLE IF exists sql_purchases.customer_summary;



CREATE TABLE customer_summary
SELECT 	c.customerid,
		c.avg_invoice_amt,
        c.total_invoice_amt,
		c.invoice_count,
        c.total_units,
        c_country.country
FROM customer c 
LEFT JOIN customer_country c_country
ON c.customerid = c_country.customerid
ORDER BY total_invoice_amt DESC, avg_invoice_amt DESC;

SELECT * FROM customer_summary
-- generally customers from the UK spend more 
	-- and on average per invoice