select 
	last_name,
	first_name, 
	points,
    (points+10)*100 AS 'discount factor'
from customers;
select name, unit_price, unit_price*1.1 as new_price from products;
select * from customers where points>3000;
select * from customers where state<>'VA';

-- BETWEEN:
select * from orders where order_date between '2018-01-01' and '2018-12-31';

-- DISTINCT:
SELECT distinct  state FROM sql_store.customers;

-- AND:
SELECT * from order_items where order_id=6 and unit_price*quantity>30;

-- IN:
select * from products  where quantity_in_stock IN (49, 38, 72);

-- BETWEEN:
select * from customers where points between 1000 and 3000;
select * from customers where birth_date between '1990-01-01' and '2000-01-01';

-- LIKE:
select * from customers where last_name LIKE '%b%';
select * from customers where last_name LIKE 'b____y';
select * from customers where address like '%trail%' or '%avenue%';
select * from customers where address like '%trail%' or address like '%avenue%';
select * from customers where phone like '%9';

-- REGXEP:
select * from customers where last_name like '%field%';
select * from customers where last_name regexp 'field';
select * from customers where last_name regexp '^field';	-- ^ means beg of string
select * from customers where last_name regexp 'field$';	-- $ means end of string
select * from customers where last_name regexp 'field|mac|rose';  -- | is or operator
select * from customers where last_name regexp '^field|mac|rose'; -- that starts with field mac or rose
select * from customers where last_name regexp 'field$|mac|rose'; -- that ends with field or contains mac or rose
select * from customers where last_name regexp '[gim]e';	-- matches ge, ie, me in last_name
select * from customers where last_name regexp '[a-h]e'; 	-- matches ae, be, ce, ... in last_name
select * from customers where first_name regexp 'Elka|AMBUR';
select * from customers where last_name regexp 'EY$|ON$';
select * from customers where last_name regexp '^MY|SE';
select * from customers where last_name regexp 'B[RU]';

-- IS NULL
select * from customers where phone IS NULL;
select * from customers where phone IS NOT NULL;
select * from orders where shipped_date IS NULL;

-- ORDER BY:
select * from customers order by state DESC, first_name DESC;
select first_name, last_name from customers order by state desc;
select first_name, last_name, 10 as points from customers order by points, first_name;
select first_name, last_name, 10 as points from customers order by 1, 2;
-- filter order_items table by order_id 2 and sort by total_price in desc order
select *, unit_price*quantity as total_price from order_items where order_id=2 order by total_price desc;

-- LIMIT
select * from customers LIMIT 3;
select * from customers LIMIT 300;
select * from customers LIMIT 6,3;  -- 6 is the offset so first 6 rows are skipped and next 3 are shown
-- GET the top three loyal customers:
select * from customers ORDER BY points DESC LIMIT 3 ;

-- INNER JOINS:
select * from orders JOIN customers ON orders.customer_id = customers.customer_id;
select order_id, o.customer_id, first_name, last_name from orders o JOIN customers c ON o.customer_id = c.customer_id;
select order_id, oi.product_id, name, quantity, oi.unit_price from order_items oi JOIN products p ON oi.product_id = p.product_id;





-- CBD:
create table cbd(name varchar(20), dept varchar(10));
insert into cbd values
	('Shankar', 'Accounts'),
    ('Prakash', 'Finance');
insert into cbd values('Shankar', 'Accounts');
drop table cbd;

