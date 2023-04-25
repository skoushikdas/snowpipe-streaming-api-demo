
CREATE TABLE STORE_SALES (
	SS_SOLD_DATE_SK FLOAT(38,0),
	SS_SOLD_TIME_SK FLOAT(38,0),
	SS_ITEM_SK FLOAT(38,0),
	SS_CUSTOMER_SK FLOAT(38,0),
	SS_CDEMO_SK FLOAT(38,0),
	SS_HDEMO_SK FLOAT(38,0),
	SS_ADDR_SK FLOAT(38,0),
	SS_STORE_SK FLOAT(38,0),
	SS_PROMO_SK FLOAT(38,0),
	SS_TICKET_NUMBER FLOAT(38,0),
	SS_QUANTITY FLOAT(38,0),
	SS_WHOLESALE_COST FLOAT(7,2),
	SS_LIST_PRICE FLOAT(7,2),
	SS_SALES_PRICE FLOAT(7,2),
	SS_EXT_DISCOUNT_AMT FLOAT(7,2),
	SS_EXT_SALES_PRICE FLOAT(7,2),
	SS_EXT_WHOLESALE_COST FLOAT(7,2),
	SS_EXT_LIST_PRICE FLOAT(7,2),
	SS_EXT_TAX FLOAT(7,2),
	SS_COUPON_AMT FLOAT(7,2),
	SS_NET_PAID FLOAT(7,2),
	SS_NET_PAID_INC_TAX FLOAT(7,2),
	SS_NET_PROFIT FLOAT(7,2)
);

set global local_infile = 1;

LOAD DATA INFILE '/var/lib/mysql-files/stores_sales_1m_1.csv'
INTO TABLE STORE_SALES
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SS_SOLD_DATE_SK ,SS_SOLD_TIME_SK ,SS_ITEM_SK ,SS_CUSTOMER_SK ,SS_CDEMO_SK ,SS_HDEMO_SK ,SS_ADDR_SK ,SS_STORE_SK ,SS_PROMO_SK ,SS_TICKET_NUMBER ,SS_QUANTITY ,SS_WHOLESALE_COST ,SS_LIST_PRICE ,SS_SALES_PRICE ,SS_EXT_DISCOUNT_AMT ,SS_EXT_SALES_PRICE ,SS_EXT_WHOLESALE_COST ,SS_EXT_LIST_PRICE ,SS_EXT_TAX ,SS_COUPON_AMT ,SS_NET_PAID ,SS_NET_PAID_INC_TAX ,SS_NET_PROFIT)
;

LOAD DATA INFILE '/var/lib/mysql-files/stores_sales_1m_2.csv'
INTO TABLE STORE_SALES
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SS_SOLD_DATE_SK ,SS_SOLD_TIME_SK ,SS_ITEM_SK ,SS_CUSTOMER_SK ,SS_CDEMO_SK ,SS_HDEMO_SK ,SS_ADDR_SK ,SS_STORE_SK ,SS_PROMO_SK ,SS_TICKET_NUMBER ,SS_QUANTITY ,SS_WHOLESALE_COST ,SS_LIST_PRICE ,SS_SALES_PRICE ,SS_EXT_DISCOUNT_AMT ,SS_EXT_SALES_PRICE ,SS_EXT_WHOLESALE_COST ,SS_EXT_LIST_PRICE ,SS_EXT_TAX ,SS_COUPON_AMT ,SS_NET_PAID ,SS_NET_PAID_INC_TAX ,SS_NET_PROFIT)
;

LOAD DATA INFILE '/var/lib/mysql-files/stores_sales_1m_3.csv'
INTO TABLE STORE_SALES
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SS_SOLD_DATE_SK ,SS_SOLD_TIME_SK ,SS_ITEM_SK ,SS_CUSTOMER_SK ,SS_CDEMO_SK ,SS_HDEMO_SK ,SS_ADDR_SK ,SS_STORE_SK ,SS_PROMO_SK ,SS_TICKET_NUMBER ,SS_QUANTITY ,SS_WHOLESALE_COST ,SS_LIST_PRICE ,SS_SALES_PRICE ,SS_EXT_DISCOUNT_AMT ,SS_EXT_SALES_PRICE ,SS_EXT_WHOLESALE_COST ,SS_EXT_LIST_PRICE ,SS_EXT_TAX ,SS_COUPON_AMT ,SS_NET_PAID ,SS_NET_PAID_INC_TAX ,SS_NET_PROFIT)
;
LOAD DATA INFILE '/var/lib/mysql-files/stores_sales_1m_4.csv'
INTO TABLE STORE_SALES
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SS_SOLD_DATE_SK ,SS_SOLD_TIME_SK ,SS_ITEM_SK ,SS_CUSTOMER_SK ,SS_CDEMO_SK ,SS_HDEMO_SK ,SS_ADDR_SK ,SS_STORE_SK ,SS_PROMO_SK ,SS_TICKET_NUMBER ,SS_QUANTITY ,SS_WHOLESALE_COST ,SS_LIST_PRICE ,SS_SALES_PRICE ,SS_EXT_DISCOUNT_AMT ,SS_EXT_SALES_PRICE ,SS_EXT_WHOLESALE_COST ,SS_EXT_LIST_PRICE ,SS_EXT_TAX ,SS_COUPON_AMT ,SS_NET_PAID ,SS_NET_PAID_INC_TAX ,SS_NET_PROFIT)
;
LOAD DATA INFILE '/var/lib/mysql-files/stores_sales_1m_5.csv'
INTO TABLE STORE_SALES
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SS_SOLD_DATE_SK ,SS_SOLD_TIME_SK ,SS_ITEM_SK ,SS_CUSTOMER_SK ,SS_CDEMO_SK ,SS_HDEMO_SK ,SS_ADDR_SK ,SS_STORE_SK ,SS_PROMO_SK ,SS_TICKET_NUMBER ,SS_QUANTITY ,SS_WHOLESALE_COST ,SS_LIST_PRICE ,SS_SALES_PRICE ,SS_EXT_DISCOUNT_AMT ,SS_EXT_SALES_PRICE ,SS_EXT_WHOLESALE_COST ,SS_EXT_LIST_PRICE ,SS_EXT_TAX ,SS_COUPON_AMT ,SS_NET_PAID ,SS_NET_PAID_INC_TAX ,SS_NET_PROFIT)
;
LOAD DATA INFILE '/var/lib/mysql-files/stores_sales_1m_6.csv'
INTO TABLE STORE_SALES
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SS_SOLD_DATE_SK ,SS_SOLD_TIME_SK ,SS_ITEM_SK ,SS_CUSTOMER_SK ,SS_CDEMO_SK ,SS_HDEMO_SK ,SS_ADDR_SK ,SS_STORE_SK ,SS_PROMO_SK ,SS_TICKET_NUMBER ,SS_QUANTITY ,SS_WHOLESALE_COST ,SS_LIST_PRICE ,SS_SALES_PRICE ,SS_EXT_DISCOUNT_AMT ,SS_EXT_SALES_PRICE ,SS_EXT_WHOLESALE_COST ,SS_EXT_LIST_PRICE ,SS_EXT_TAX ,SS_COUPON_AMT ,SS_NET_PAID ,SS_NET_PAID_INC_TAX ,SS_NET_PROFIT)
;
LOAD DATA INFILE '/var/lib/mysql-files/stores_sales_1m_7.csv'
INTO TABLE STORE_SALES
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SS_SOLD_DATE_SK ,SS_SOLD_TIME_SK ,SS_ITEM_SK ,SS_CUSTOMER_SK ,SS_CDEMO_SK ,SS_HDEMO_SK ,SS_ADDR_SK ,SS_STORE_SK ,SS_PROMO_SK ,SS_TICKET_NUMBER ,SS_QUANTITY ,SS_WHOLESALE_COST ,SS_LIST_PRICE ,SS_SALES_PRICE ,SS_EXT_DISCOUNT_AMT ,SS_EXT_SALES_PRICE ,SS_EXT_WHOLESALE_COST ,SS_EXT_LIST_PRICE ,SS_EXT_TAX ,SS_COUPON_AMT ,SS_NET_PAID ,SS_NET_PAID_INC_TAX ,SS_NET_PROFIT)
;
LOAD DATA INFILE '/var/lib/mysql-files/stores_sales_1m_8.csv'
INTO TABLE STORE_SALES
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SS_SOLD_DATE_SK ,SS_SOLD_TIME_SK ,SS_ITEM_SK ,SS_CUSTOMER_SK ,SS_CDEMO_SK ,SS_HDEMO_SK ,SS_ADDR_SK ,SS_STORE_SK ,SS_PROMO_SK ,SS_TICKET_NUMBER ,SS_QUANTITY ,SS_WHOLESALE_COST ,SS_LIST_PRICE ,SS_SALES_PRICE ,SS_EXT_DISCOUNT_AMT ,SS_EXT_SALES_PRICE ,SS_EXT_WHOLESALE_COST ,SS_EXT_LIST_PRICE ,SS_EXT_TAX ,SS_COUPON_AMT ,SS_NET_PAID ,SS_NET_PAID_INC_TAX ,SS_NET_PROFIT)
;