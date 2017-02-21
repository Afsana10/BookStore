DROP TABLE borrower;
DROP TABLE orders;
DROP TABLE book_store;
DROP TABLE customers;

CREATE TABLE book_store(
book_id NUMBER(3),
book_name VARCHAR(40),
writer VARCHAR(30),
publisher VARCHAR(30),
price NUMBER(10),
contact_office Number DEFAULT 123456
);

DESCRIBE book_store;

CREATE TABLE customers(
customer_id NUMBER(3),
customer_name VARCHAR(20),
email VARCHAR(30) NOT NULL UNIQUE,
contact NUMBER(11)
);

DESCRIBE customers;

CREATE TABLE orders(
id NUMBER(3),
book_id NUMBER(3),
customer_id NUMBER(3)
);

DESCRIBE orders;

CREATE TABLE borrower(
borrower_id NUMBER(3),
borrower_name VARCHAR(20),
age NUMBER(3) CHECK(age>0),
email VARCHAR(30),
contact VARCHAR(20),
b_book_id NUMBER(3),
start_date DATE,
end_date DATE
);

DESCRIBE borrower;

ALTER TABLE book_store ADD type VARCHAR(30);

ALTER TABLE book_store RENAME COLUMN writer to author;

ALTER TABLE book_store ADD CONSTRAINT bn_pk PRIMARY KEY (book_name);

ALTER TABLE book_store DROP CONSTRAINT bn_pk;

ALTER TABLE book_store ADD CONSTRAINT bn_pk PRIMARY KEY (book_id);

ALTER TABLE customers ADD CONSTRAINT cus_pk PRIMARY KEY (customer_id);

ALTER TABLE borrower ADD CONSTRAINT borrower_pk PRIMARY KEY (borrower_id);

ALTER TABLE borrower ADD CONSTRAINT borrower_fk FOREIGN KEY(b_book_id) REFERENCES book_store(book_id) ON DELETE CASCADE;

ALTER TABLE orders ADD CONSTRAINT order_pk PRIMARY KEY (id);

ALTER TABLE orders ADD CONSTRAINT ord_fk FOREIGN KEY(book_id) REFERENCES book_store(book_id) ON DELETE CASCADE;

ALTER TABLE orders ADD CONSTRAINT order_fk FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;


--INSERTING VALUES IN THE TABLE 'BOOK_STORE'
--------------------------------------------------------------------------------------------------------------------
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (1,'Kheya','Anisul Haque',110,'Shomoy','Novel');
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (2,'Chader Pahar','Bivutibhushon Bandapaddhay',90,'Shomoy','Adventure');
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (3,'Dead Wake','Eric Larson',230,'Ananya','History');
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (4,'Chitra','Rabindranath Tagore',200,'Angkur','Poem');
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (5,'Horokishorebabu','Horishonkor Jolodas',150,'Prothoma','Story');
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (6,'Shaymol Chhaya','Humayun Ahmed',90,'Shomoy','Novel');
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (7,'Bangabandhu in Geneva','Abdul Matin',1680,'Ananya','History');
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (8,'Sheulimala','Kazi Nazrul Islam',200,'Prothoma','Poem');
INSERT INTO book_store(book_id,book_name,author,price,publisher,type)VALUES (9,'Golpoguccho','Rabindranath Tagore',300,'Prothoma','Story');

UPDATE book_store SET price=100 WHERE book_name='Kheya';

DELETE FROM book_store WHERE book_name='Dead Wake';

SELECT * FROM book_store;

--INSERTING VALUES IN THE TABLE 'CUSTOMERS'
------------------------------------------------------------------------------------------------------------------------
INSERT INTO customers(customer_id,customer_name,email,contact)VALUES (1,'Aziz','aziz@bd.com',101);
INSERT INTO customers(customer_id,customer_name,email,contact)VALUES (2,'Aney','paul@bd.com',201);
INSERT INTO customers(customer_id,customer_name,email,contact)VALUES (3,'Prome','pr@bd.com',202);
INSERT INTO customers(customer_id,customer_name,email,contact)VALUES (4,'Mashfi','mash@bd.com',271);
INSERT INTO customers(customer_id,customer_name,email,contact)VALUES (5,'Rima','rm@bd.com',420);
INSERT INTO customers(customer_id,customer_name,email,contact)VALUES (6,'Abir','ab@bd.com',120);

SELECT * FROM customers;

--INSERTING VALUES IN THE TABLE 'ORDERS'
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO orders(id,book_id,customer_id)VALUES (1,2,5);
INSERT INTO orders(id,book_id,customer_id)VALUES (2,4,4);
INSERT INTO orders(id,book_id,customer_id)VALUES (3,2,3);
INSERT INTO orders(id,book_id,customer_id)VALUES (4,5,1);
INSERT INTO orders(id,book_id,customer_id)VALUES (5,2,5);

SELECT * FROM orders;



--CHECKING AGE OF BORROWER
----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER check_age BEFORE INSERT OR UPDATE ON borrower
FOR EACH ROW
DECLARE
   b_min CONSTANT NUMBER(3) := 18;
   b_max CONSTANT NUMBER(3) := 60;
BEGIN
  IF :new.age > b_max OR :new.age < b_min THEN
  RAISE_APPLICATION_ERROR(-20000,'Too much younger or older');
END IF;
END;
/



--INSERTING VALUES IN THE TABLE 'BORROWER'
-------------------------------------------------------------------------------------------------------------------------
INSERT INTO borrower(borrower_id,borrower_name,age,email,contact,b_book_id,start_date,end_date)VALUES (1,'Aziz',22,'aziz@bd.com',101,2,'12-JAN-2015','19-JAN-2015');
INSERT INTO borrower(borrower_id,borrower_name,age,email,contact,b_book_id,start_date,end_date)VALUES (2,'Aney',21,'paul@bd.com',201,1,'12-JUL-2015','19-JUL-2015');
INSERT INTO borrower(borrower_id,borrower_name,age,email,contact,b_book_id,start_date,end_date)VALUES (3,'Prome',22,'pr@bd.com',102,1,'13-AUG-2015','20-AUG-2015');
INSERT INTO borrower(borrower_id,borrower_name,age,email,contact,b_book_id,start_date,end_date)VALUES (4,'Mashfi',21,'mash@bd.com',271,5,'21-AUG-2015','28-AUG-2015');
INSERT INTO borrower(borrower_id,borrower_name,age,email,contact,b_book_id,start_date,end_date)VALUES (5,'Rima',20,'rm@bd.com',420,4,'24-MAY-2015','31-MAY-2015');
INSERT INTO borrower(borrower_id,borrower_name,age,email,contact,b_book_id,start_date,end_date)VALUES (6,'Rima',20,'rm@bd.com',420,6,'24-MAY-2015','31-MAY-2015');
INSERT INTO borrower(borrower_id,borrower_name,age,email,contact,b_book_id,start_date,end_date)VALUES (7,'Sakib',20,'sk@bd.com',520,4,'24-MAY-2015','31-MAY-2015');


SELECT * FROM borrower;

-- FOR FINDING SPECIFIC TYPE OF BOOKS
---------------------------------------------------------------------------------------------------------------------------
SELECT book_name AS novels, author, publisher,price FROM book_store WHERE type='Novel' order by book_name desc;
SELECT book_name AS story, author, publisher,price FROM book_store WHERE type='Story' order by book_name;
SELECT book_name AS poems, author, publisher,price FROM book_store WHERE type='Poem' order by book_name;
SELECT book_name AS history, author, publisher,price FROM book_store WHERE type='History' order by book_name;

SELECT book_name AS adventures, author, publisher,price FROM book_store WHERE book_name IN 
       (SELECT book_name FROM book_store WHERE type='Adventure');


--FOR FINDING BOOKS WRITTEN BY SPECIFIC WRITER
-------------------------------------------------------------------------------------------------------------------------
--SELECT book_name,author,price FROM book_store GROUP BY author;

--FIND WHO BORROW BOOKS FROM THE STORE
--------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT (borrower_name) FROM borrower;


--NUMBER OF BORROWED BOOKS
-----------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(b_book_id) FROM borrower;


--FIND CUSTOMERS WHO BORROWS BOOKS ALSO
-----------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT(c.customer_name) FROM customers c JOIN borrower b ON c.customer_name = b.borrower_name;

--FIND BORROWERS WHO ARE IN CUSTOMER LIST AND ALL CUSTOMERS
-----------------------------------------------------------------------------------------------------------------------------
SELECT c.customer_name FROM customers c LEFT OUTER JOIN borrower b ON c.customer_name=b.borrower_name;

--FIND WHO ARE BOTH CUSTOMERS AND BORROWERS
-------------------------------------------------------------------------------
SELECT c.customer_name FROM customers c FULL OUTER JOIN borrower b ON c.customer_name=b.borrower_name;


--FIND MOST EXPENSIVE BOOK
--------------------------------------------------------------------------
SET SERVEROUTPUT ON
DECLARE
   max_price book_store.price%type;
   m_ex_bk book_store.book_name%type;
  -- br_date borrower.start_date%type;
   --c_name customers.customer_name%type;

BEGIN
   SELECT MAX(price) INTO max_price FROM book_store;
   SELECT book_name INTO m_ex_bk FROM book_store WHERE price=max_price;
   DBMS_OUTPUT.PUT_LINE('The most expensive book is  ' || m_ex_bk);
 END;
/

--DISCOUNTS
----------------------------------------------------------------------------------
SET SERVEROUTPUT ON
DECLARE
    full_price book_store.price%type;
    bk_name book_store.book_name%type;
    discount_price book_store.price%type;
BEGIN
    bk_name := 'Bangabandhu in Geneva';

    SELECT price INTO full_price FROM book_store WHERE book_name=bk_name;

    IF 
    full_price < 100  THEN discount_price := full_price;

    ELSIF
    full_price >=100 and full_price<200 THEN discount_price := full_price - (full_price*0.05);

    ELSIF 
    full_price >= 200 and full_price <= 300 THEN discount_price :=  full_price - (full_price*0.10);
    
    ELSE
    discount_price :=  full_price - (full_price*0.15);
 
    END IF;

DBMS_OUTPUT.PUT_LINE (bk_name || ', Full Price: '||full_price||' Disounted Pice: '|| ROUND(discount_price,2));

EXCEPTION
         WHEN others THEN
	      DBMS_OUTPUT.PUT_LINE (SQLERRM);
END;
/



--FIND INFORMATION FOR SPECIFIC CUSTOMER
------------------------------------------------------------------------
DECLARE
   c_id customers.customer_id%type;
   c_name customers.customer_name%type;
   c_contact customers.contact%type;

PROCEDURE FINDS(a IN NUMBER, b OUT VARCHAR, c OUT NUMBER) IS
BEGIN
 SELECT customer_name,contact INTO b,c FROM customers WHERE customer_id=a;  
END; 

BEGIN
   c_id:=1;
   FINDS(c_id,c_name,c_contact);
   dbms_output.put_line(' STUDENT NAME : ' ||c_name||'  contact number :'||c_contact);
END;
/


--BOOKS UNDER PRICE 400 BDT
--------------------------------------------------------------
SET SERVEROUTPUT ON
DECLARE
b_name book_store.book_name%type;
b_author book_store.author%type;
b_price book_store.price%type;

CURSOR bcur is
SELECT book_name,author,price FROM book_store WHERE price<400 ;
BEGIN
OPEN bcur;
LOOP
FETCH bcur into b_name,b_author,b_price;
EXIT WHEN bcur%notfound;
dbms_output.put_line(b_name || ' ' ||b_author || ' ' ||b_price);
END LOOP;
CLOSE bcur;
END;
/

