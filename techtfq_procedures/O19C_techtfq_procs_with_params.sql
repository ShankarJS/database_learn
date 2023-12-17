insert into products (product_code,product_name,price,quantity_remaining,quantity_sold)
	values ('P2', 'Airpods Pro', 279, 10, 90);
insert into products (product_code,product_name,price,quantity_remaining,quantity_sold)
	values ('P3', 'MacBook Pro16', 5000, 2, 48);
insert into products (product_code,product_name,price,quantity_remaining,quantity_sold)
	values ('P4', 'iPad Air', 650, 1, 9);
    
/* For every given product and the quantity,
	1) Check if product is available based on the required Quantity.
	2) If available then modify the database tables accordingly.
 */
 
create or replace PROCEDURE pr_buy_products(p_product_name varchar, p_quantity int)
as
    v_cnt int;
    v_product_code varchar(20);
    v_price int;
begin
    select count(1)
    into v_cnt
    from products
    where product_name = p_product_name 
    and quantity_remaining >= p_quantity;
    
    if v_cnt>0 
    then
        select product_code, price
        into v_product_code, v_price
        from products
        where product_name = p_product_name
        and quantity_remaining >= p_quantity;
        
        insert into sales(order_date, product_code, quantity_ordered, sale_price)
            values (current_date, v_product_code, p_quantity, (v_price*p_quantity));
        
        update products 
        set quantity_remaining = (quantity_remaining - p_quantity), 
        quantity_sold = (quantity_sold + p_quantity) 
        where product_code = v_product_code;
        
        dbms_output.put_line('Product sold!');
    else
        dbms_output.put_line('Insufficient quantity');
    end if;
end;

exec pr_buy_products('Airpods Pro', 2);
        
 
 