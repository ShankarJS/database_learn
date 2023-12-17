CREATE TABLE products (
    product_code NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    price NUMBER,
    quantity_remaining NUMBER,
    quantity_sold NUMBER
);

INSERT INTO products (product_code, product_name, price, quantity_remaining, quantity_sold)
VALUES (11, 'iPhone 13 Pro Max', 1000, 5, 195);

CREATE TABLE sales (
    order_id NUMBER PRIMARY KEY,
    order_date DATE,
    product_code NUMBER,
    quantity_ordered NUMBER,
    sales_price NUMBER
);

INSERT INTO sales (order_id, order_date, product_code, quantity_ordered, sales_price)
VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 11, 100, 20000);

INSERT INTO sales (order_id, order_date, product_code, quantity_ordered, sales_price)
VALUES (2, TO_DATE('2023-02-15', 'YYYY-MM-DD'), 11, 50, 60000);

INSERT INTO sales (order_id, order_date, product_code, quantity_ordered, sales_price)
VALUES (3, TO_DATE('2023-03-20', 'YYYY-MM-DD'), 11, 45, 540000);

select * from products;
select * from sales;

CREATE OR REPLACE PROCEDURE pr_buy_products
as
    v_product_code varchar(20);
    v_price float;
begin
    select product_code, price
    into v_product_code, v_price
    from products
    where product_name = 'iPhone 13 Pro Max';
    
    insert into sales(order_id, order_date, product_code, quantity_ordered, sales_price)
    values ((v_product_code*3), current_date, v_product_code, 1, (v_price*1));
    
    update products
    set quantity_remaining = (quantity_remaining-1),
        quantity_sold = (quantity_sold+1)
    where product_code = v_product_code;
    
    dbms_output.put_line('Product Sold!');
end;

exec pr_buy_products;
    