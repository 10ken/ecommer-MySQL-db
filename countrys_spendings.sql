USE sql_purchases;
DROP TABLE IF EXISTS sql_purchases.spending;
DROP TABLE IF EXISTS sql_purchases.quantities;
DROP TABLE IF EXISTS sql_purchases.total_spending;
DROP TABLE IF EXISTS sql_purchases.country_spendings;
DROP TABLE IF EXISTS sql_purchases.freq_stockcode;
DROP TABLE IF EXISTS sql_purchases.stockcode_product;
DROP TABLE IF EXISTS sql_purchases.stockcode_freq_descrip;
DROP TABLE IF EXISTS sql_purchases.final_table;





CREATE TABLE `spending`
	SELECT country, (quantity* unitprice) AS spending
    FROM purchase_data;

CREATE TABLE `total_spending`
	SELECT country, SUM(spending) AS total_spending
    From spending
    GROUP BY country
    ORDER BY country;
    
CREATE TABLE `quantities`
	SELECT country, 
		SUM(quantity) AS total_quant
    FROM purchase_data
    GROUP BY country
    ORDER BY country;
    
CREATE TABLE `country_spendings`
	SELECT quantities.country, total_quant, round(total_spending,2),
			round(total_spending/total_quant, 2) AS avg_unitprice
    FROM quantities, total_spending
    ORDER BY total_spending desc, avg_unitprice desc;
    
-- sorted a countries total spending and average dollar per item in decending order.
    

select count(distinct stockcode) as unique_stockcodes from purchase_data;
-- total of 2372 unique stockcode.

CREATE TABLE `freq_stockcode`
	SELECT count(*) AS freq, stockcode
	FROM purchase_data
	GROUP BY stockcode
	ORDER BY stockcode DESC;
-- stockcode 85123A is most frequently bought

CREATE TABLE `stockcode_product` 
	SELECT DISTINCT stockcode, description 
    FROM purchase_data ORDER BY stockcode DESC;

CREATE TABLE `stockcode_freq_descrip`
	SELECT freq, freq_stockcode.stockcode, description
	FROM freq_stockcode, purchase_data
	ORDER BY freq DESC;
 
-- The stockcode that performed the best is 
	-- represented by a wide range of products
    
CREATE TABLE `final_table`
SELECT country, ROUND(sum(quantity*unitprice),2) AS spendings
FROM purchase_data
WHERE stockcode = '85123A'
GROUP BY country
ORDER BY spendings DESC;

SELECT *
FROM  final_table;
