CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30),
  gender VARCHAR(30),
  age INT,
  address VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2),
  zip_code CHAR(5)
);

select * from customer where gender = 'Female';

select * from customer where gender = 'Male' and state = 'NJ';

select * from customer where gender = 'Male' and state = 'NJ' or state = 'OH';

select * from customer where gender = 'Female' and state = 'MD' and age < 30;