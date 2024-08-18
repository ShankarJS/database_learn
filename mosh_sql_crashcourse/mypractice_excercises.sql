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

-- SELF JOINS:
use sql_hr;
select * from employees e JOIN employees m ON e.reports_to = m.employee_id;
select e.employee_id, e.first_name, m.first_name as Manager from employees e JOIN employees m ON e.reports_to = m.employee_id;

-- Joining multiple tables:
use sql_store;
select o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status from orders o join customers c on o.customer_id = c.customer_id join order_statuses os on o.status = os.order_status_id;
-- Join payment with client and payment_method
use sql_invoicing;
select p.date, p.invoice_id, p.amount, c.name, pm.name from payments p join clients c on p.client_id = c.client_id join payment_methods pm on p.payment_method = pm.payment_method_id;

-- Compound join conditions:
select * from order_items oi JOIN order_item_notes oin 
	ON oi.order_Id = oin.order_Id
    AND oi.product_id = oin.product_id;
    
-- Implicit JOIN syntax:
select * from orders o, customers c where o.customer_id = c.customer_id;
-- In above query remember to use where clause else it will be a cross join, also it is similar to:
select * from orders o join customers c on o.customer_id = c.customer_id;

-- OUTER JOIN:
select c.customer_id, c.first_name, o.order_id from customers c LEFT JOIN orders o on c.customer_id = o.customer_id order by c.customer_id;
select c.customer_id, c.first_name, o.order_id from orders o RIGHT JOIN customers c on c.customer_id = o.customer_id order by c.customer_id;
select p.product_id, p.name, oi.quantity from products p left join order_items oi on p.product_id = oi.product_id;

-- Outer Joins between multiple tables:
select c.customer_id, c.first_name, o.order_id, sh.name as Shipper from customers c left join orders o on c.customer_id = o.customer_id left join shippers sh on o.shipper_id = sh.shipper_id order by c.customer_id;
select o.order_id, o.order_date, c.first_name as customer, sh.name as shipper, os.name as status from orders o join customers c on o.customer_id = c.customer_id left join shippers sh on o.shipper_id = sh.shipper_id join order_statuses os ON o.status = os.order_status_id;

-- Self outer join
use sql_hr;
select e.employee_id, e.first_name, m.first_name as manager from employees e left join employees m on e.reports_to = m.employee_id;

-- The USING Clause
use sql_store;
select o.order_id, c.first_name from orders o join customers c on o.customer_id = c.customer_id; 
-- above query can be replaced with:
select o.order_id, c.first_name, sh.name AS Shipper from orders o join customers c using (customer_id); 
select o.order_id, c.first_name, sh.name AS Shipper from orders o join customers c using (customer_id) left join shippers sh using (shipper_id);
-- using keyword for composite keys:
select * from order_items oi JOIN order_item_notes oin USING (order_id, product_id); 
use sql_invoicing;
select p.date, c.name as client, p.amount, pm.name as payment_method from payments p join clients c using (client_id) join payment_methods pm on p.payment_method = pm.payment_method_id;

-- Done till Using Clause 2:13:37 next is natural joins

-- Natural Joins:
select o.order_id, c.first_name from orders o natural join customers c;

-- Cross Joins:
select c.first_name as customers, p.name as product from customers c cross Join products p order by c.first_name;
-- Above is explicit syntax, Alternate syntax for cross join:
select c.first_name as customers, p.name as product from customers c, products p order by c.first_name;

-- Unions
select order_id, order_date, 'Active' AS status from orders where order_date >= '2019-01-01'
UNION
select order_id, order_date, 'Archived' AS status from orders where order_date < '2019-01-01';
select first_name from customers UNION select name from shippers;
SELECT customer_id, first_name, points, 'Bronze' as type from customers where points<2000 union 
SELECT customer_id, first_name, points, 'Silver' as type from customers where points BETWEEN 2000 and 3000 union
SELECT customer_id, first_name, points, 'Gold' as type from customers where points > 3000 order by first_name;

-- INSERTING A SINGLE ROW:
INSERT INTO CUSTOMERS VALUES(DEFAULT, 'John', 'Smith', '1990-01-01', NULL, 'address', 'city', 'CA', DEFAULT);  
-- Alternate way:
INSERT INTO CUSTOMERS(first_name, last_name, birth_date, address, city, state) VALUES('John', 'Smith', '1990-01-01', 'address', 'city', 'CA');

-- INSERTING MULTIPLE ROWS:
INSERT INTO SHIPPERS (name) values ('shipper1'), ('shipper2'), ('shipper3');
INSERT INTO PRODUCTS (name, quantity_in_stock, unit_price) values ('Product1', 10, 1.95), ('Product2', 11, 1.95), ('Product3', 12, 1.95);

-- INSERTING HIERARCHICAL ROWS:
INSERT INTO orders (customer_id, order_date, status) values(1, '2019-01-02', 1);
INSERT INTO order_items values (LAST_INSERT_ID(), 1, 1, 2.95), (last_insert_id(), 2, 1, 3.95);






-- CBD:
create table cbd(name varchar(20), dept varchar(10));
insert into cbd values
	('Shankar', 'Accounts'),
    ('Prakash', 'Finance');
insert into cbd values('Shankar', 'Accounts');
drop table cbd;

