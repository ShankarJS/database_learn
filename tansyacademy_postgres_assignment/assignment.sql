CREATE TABLE BOOK(
	book_id serial primary key,
	title varchar(255) NOT NULL,
	genre varchar(100) check (genre IN ('Fiction', 'Non-Fiction', 'Educational', 'Biography')),
	publicationDate Date Default CURRENT_DATE,
	isbn int unique,
	author_id int,
	foreign key(author_id) references author(author_id)
);

CREATE TABLE CUSTOMER(
	customer_id serial primary key,
	name varchar(255) NOT NULL unique,
	email varchar NOT NULL unique
);

CREATE TABLE SALE(
	saleId serial primary key,
	saleDate Date NOT NULL DEFAULT CURRENT_DATE,
	quantity int not null DEFAULT 1,
	totalPrice float NOT NULL,
	customer_id int,
	book_id int,
	foreign key(customer_id) references customer(customer_id),
	foreign key(book_id) references book(book_id)
);

select * from author;
select * from book;
select * from customer;
select * from sale;

create index book_genre_idx ON book(genre);
create index customer_name_idx ON customer(name);

-- DML ASSIGNMENT1 - BOOK STORE:
INSERT INTO AUTHOR(name, email) VALUES('Jane Doe', 'jane.doe@email.com');

INSERT INTO BOOK(ISBN, title, genre, publicationdate) VALUES
	('1234567890', 'Book One', 'Fiction', '2023-01-01'),
	('0987654321', 'Book Two', 'Non-Fiction', '2023-02-01'),
	('1122334455', 'Book Three', 'Educational', '2023-03-01');
	
INSERT INTO BOOK(ISBN, title, genre, publicationdate) VALUES
	('1234567891', 'Hello Java', 'Fiction', '2023-01-01'),
	('1234567892', 'Database Fundamentals', 'Non-Fiction', '2023-02-01'),
	('1234567893', 'Database Fundamentals', 'Educational', '2023-03-01');
	
Update book 
set genre = 'Educational'
where title = 'Database Fundamentals';

insert into sale(saledate, quantity, totalprice, customer_id, book_id) values
('2023-01-23', '101', '234', '1', '4'),
('2022-12-21', '102', '543', '2', '4'),
('2022-11-12', '3', '654', '3', '5');

insert into sale(saledate, quantity, totalprice, customer_id, book_id) values
('2023-01-23', '11', '234', '1', '4'),
('2022-12-21', '12', '543', '2', '4'),
('2022-11-12', '13', '654', '3', '5');

insert into customer(name, email) values('Saurabh Tiwari', 'saurabh@gmail.com'),
('Shubham Singh', 'shubham@gmail.com'),
('Aman Vora', 'aman@gmail.com'),
('Bhushan Talekar', 'bhushan@gmail.com');

Update Sale
set totalPrice = totalPrice + (totalprice*10/100)
where saledate < '2023-01-01';

Delete from Sale where quantity<10;

TRUNCATE TABLE SALE;
DELETE FROM SALE;

SELECT b.book_id, count(1)
FROM BOOK b JOIN SALE s 
ON b.book_id = s.book_id
group by b.book_id
having sum(s.quantity)>100;

ALTER TABLE Book 
drop constraint book_genre_check;

ALTER TABLE Book
add constraint book_genre_check check (genre IN ('Fiction', 'Non-Fiction', 'Educational', 'Biography', 'Bestseller'));

UPDATE BOOK
SET genre = 'Bestseller'
FROM BOOK b INNER JOIN SALE s 
ON b.book_id = s.book_id
where s.quantity > 100;

--b) Subquery Insert: Insert a new sale into the SALE table with the isbn of the most recently published book.
INSERT INTO SALE() values(
	(SELECT book_id from Book order by publicationdate desc limit 1),
	
);



	


