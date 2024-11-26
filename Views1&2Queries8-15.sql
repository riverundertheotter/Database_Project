CREATE TABLE COMPANY (
  c_id INTEGER PRIMARY KEY,
  c_name TEXT NOT NULL
);
  
CREATE TABLE ADDRESS (
  address_id  INTEGER PRIMARY KEY,
  zip         INTEGER NOT NULL,
  city        TEXT    NOT NULL,
  state       CHAR(2) NOT NULL,
  line1       TEXT    NOT NULL,
  line2       TEXT
);
  
CREATE TABLE COMPANY_AFFILIATE (
  personal_id INTEGER PRIMARY KEY,
  fname       TEXT    NOT NULL,
  lname       TEXT    NOT NULL,
  age         INTEGER NOT NULL,
  gender      CHAR(1)
    CHECK (gender IN ('M', 'F', 'O')),
  address_id INTEGER NOT NULL,
  FOREIGN KEY (address_id) REFERENCES ADDRESS(address_id)
);

CREATE TABLE DEPARTMENT (
  dep_id      INTEGER PRIMARY KEY,
  dep_name    TEXT    NOT NULL
);

CREATE TABLE EMPLOYEE (

  personal_id INTEGER PRIMARY KEY,
  rank_title  TEXT    NOT NULL,
  dep_id      INTEGER NOT NULL,
  
  FOREIGN KEY (personal_id) REFERENCES COMPANY_AFFILIATE(personal_id),
  FOREIGN KEY (dep_id)      REFERENCES DEPARTMENT(dep_id)
);

CREATE TABLE POTENTIAL_EMPLOYEE (
  personal_id INTEGER PRIMARY KEY,
  FOREIGN KEY (personal_id) REFERENCES COMPANY_AFFILIATE(personal_id)
  
);

CREATE TABLE CUSTOMER (
  personal_id               INTEGER PRIMARY KEY,
  preferred_salesperson_id  INTEGER NOT NULL,
  
  FOREIGN KEY (personal_id)               REFERENCES COMPANY_AFFILIATE(personal_id),
  FOREIGN KEY (preferred_salesperson_id)  REFERENCES EMPLOYEE(personal_id)
);

CREATE TABLE MANAGES (
  emp_id INTEGER NOT NULL,
  sup_id INTEGER NOT NULL,
  CHECK (emp_id != sup_id), -- check that employee is not managing themself
  FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(personal_id),
  FOREIGN KEY (sup_id) REFERENCES EMPLOYEE(personal_id),
  PRIMARY KEY (emp_id, sup_id)
);

CREATE TABLE PHONE_NUMBER (
  personal_id INTEGER NOT NULL,
  phone_num   INTEGER PRIMARY KEY,
  FOREIGN KEY (personal_id) REFERENCES COMPANY_AFFILIATE(personal_id)
);

CREATE TABLE EMAIL (
  email_addr  TEXT NOT NULL,
  personal_id INTEGER NOT NULL,
  PRIMARY KEY (email_addr(255)),
  FOREIGN KEY (personal_id) REFERENCES COMPANY_AFFILIATE(personal_id)
);

CREATE TABLE SALARY (
  emp_id          INTEGER NOT NULL,
  transaction_num INTEGER NOT NULL,
  pay_date        DATE    NOT NULL,
  amount          INTEGER NOT NULL,
  
  FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(personal_id),
  PRIMARY KEY (emp_id, transaction_num)
);

CREATE TABLE JOB_POS (
  job_id          INTEGER PRIMARY KEY,
  job_desc        TEXT    NOT NULL,
  post_date       DATE    NOT NULL,
  d_id            INTEGER NOT NULL,
  
  FOREIGN KEY (d_id) REFERENCES DEPARTMENT(dep_id)
);

CREATE TABLE APPLICATION (
  app_id          INTEGER PRIMARY KEY,
  personal_id     INTEGER NOT NULL,
  job_id          INTEGER NOT NULL,
  FOREIGN KEY (personal_id) REFERENCES COMPANY_AFFILIATE(personal_id),
  FOREIGN KEY (job_id) REFERENCES JOB_POS(job_id)
);

CREATE TABLE INTERVIEW (      -- personal_id, round_num, and app_id should be primary key
  time          DATETIME  NOT NULL,
  personal_id   INTEGER   NOT NULL,
  grade         INTEGER   NOT NULL,
  CHECK (grade <= 100 AND grade >= 0),
  app_id        INTEGER   NOT NULL,
  round_num     INTEGER   NOT NULL,
  CHECK (round_num > 0),
  -- removed this since we have the personal_id in the APPLICATION relation.
  -- FOREIGN KEY (personal_id) REFERENCES APPLICATION(personal_id),
  FOREIGN KEY (app_id)    REFERENCES APPLICATION(app_id),
  PRIMARY KEY (personal_id, round_num, app_id)
);

CREATE TABLE INTERVIEWERS
(
  personal_id     INTEGER NOT NULL,
  round_num       INTEGER NOT NULL,
  app_id          INTEGER NOT NULL,
  interviewer_id  INTEGER NOT NULL,
  
  FOREIGN KEY (interviewer_id) REFERENCES EMPLOYEE(personal_id),
  PRIMARY KEY (interviewer_id, app_id, round_num)
);

CREATE TABLE SHIFT(
  emp_id          INTEGER   NOT NULL,
  d_id            INTEGER   NOT NULL,
  shift_start     TIMESTAMP NOT NULL,
  shift_end       TIMESTAMP NOT NULL,
  
  FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(personal_id),
  FOREIGN KEY (d_id) REFERENCES DEPARTMENT(dep_id),
  
  PRIMARY KEY (emp_id, d_id)
);

CREATE TABLE SITE(
  site_id         INTEGER   PRIMARY KEY,
  site_name       TEXT      NOT NULL,
  site_location   TEXT      NOT NULL
);

CREATE TABLE SITE_EMPLOYEE(
  site_id         INTEGER   NOT NULL,
  emp_id          INTEGER   NOT NULL,
  
  FOREIGN KEY (site_id) REFERENCES SITE(site_id),
  FOREIGN KEY (emp_id)  REFERENCES EMPLOYEE(personal_id),
  PRIMARY KEY (site_id, emp_id)
);

CREATE TABLE VENDOR(
  vendor_id       INTEGER PRIMARY KEY,
  credit_rating   INTEGER NOT NULL, 
  name            TEXT    NOT NULL,
  acct_num        INTEGER NOT NULL,
  web_url         TEXT    NOT NULL,
  address_id      INTEGER NOT NULL,
  FOREIGN KEY (address_id) REFERENCES ADDRESS(address_id)
);

CREATE TABLE PART(
  part_id         INTEGER PRIMARY KEY,
  price           INTEGER NOT NULL,
  vendor_id       INTEGER NOT NULL,
  name            TEXT    NOT NULL,
  weight          INTEGER NOT NULL,
  
  FOREIGN KEY (vendor_id) REFERENCES VENDOR(vendor_id)
);

CREATE TABLE PRODUCT(
  prod_id         INTEGER PRIMARY KEY,
  list_price      INTEGER NOT NULL,
  size            INTEGER NOT NULL,
  product_type    TEXT    NOT NULL,
  style           TEXT    NOT NULL,
  weight          INTEGER NOT NULL
);

CREATE TABLE REQUIRED_PARTS(
  prod_id         INTEGER NOT NULL,
  part_id         INTEGER NOT NULL,
  
  FOREIGN KEY (prod_id) REFERENCES PRODUCT(prod_id),
  FOREIGN KEY (part_id) REFERENCES PART(part_id),
  
  PRIMARY KEY (prod_id, part_id)
);

CREATE TABLE SALE (
  sale_id         INTEGER   PRIMARY KEY,
  sale_time       TIMESTAMP NOT NULL,
  site_id         INTEGER NOT NULL,
  salesperson_id  INTEGER NOT NULL,
  customer_id     INTEGER NOT NULL,
  prod_id         INTEGER NOT NULL,
  
  FOREIGN KEY (site_id)         REFERENCES SITE(site_id),
  FOREIGN KEY (salesperson_id)  REFERENCES EMPLOYEE(personal_id),
  FOREIGN KEY (customer_id)     REFERENCES CUSTOMER(personal_id),
  FOREIGN KEY (prod_id)         REFERENCES PRODUCT(prod_id)
);

-- populate section starts HERE

-- Department population

INSERT INTO DEPARTMENT (dep_id, dep_name)
VALUES (1, 'Sales'),
(2, 'Engineering'),
(3, 'HR'),
(4, 'Marketing');

-- 4 

INSERT INTO ADDRESS (address_id, city, state, zip, line1, line2)
VALUES (23002, 'City', 'TX', 12345, '2319 Johnson Lane', NULL);
INSERT INTO ADDRESS (address_id, city, state, zip, line1, line2)
VALUES (19002, 'City', 'TX', 12325, '5432 W. Nemo Street', NULL);
INSERT INTO ADDRESS (address_id, city, state, zip, line1, line2)
VALUES (17330, 'Town', 'TX', 12125, '4002 Red Street', NULL);
INSERT INTO ADDRESS (address_id, city, state, zip, line1, line2)
VALUES (18211, 'City', 'TX', 12322, '3321 Blue Street', NULL);
INSERT INTO ADDRESS (address_id, city, state, zip, line1, line2)
VALUES (24098, 'Town', 'FL', 78201, '9091 Green Way', NULL);
INSERT INTO ADDRESS (address_id, city, state, zip, line1, line2)
VALUES (10101, 'Town', 'FL', 78201, '9091 Green Way', NULL);

-- Company Affiliate (Employees, P_Employees, and Customers)

    -- EMPLOYEE(s)

INSERT INTO COMPANY_AFFILIATE (personal_id, fname, lname, age, gender, address_id)
VALUES (23002, 'James', 'Smith', 28, 'M', 23002);
INSERT INTO EMPLOYEE (personal_id, rank_title, dep_id)
VALUES (23002, 'Junior Sales Associate', 1);

INSERT INTO COMPANY_AFFILIATE (personal_id, fname, lname, age, gender, address_id)
VALUES (19002, 'Mary', 'Johnson', 32, 'F', 19002);
INSERT INTO EMPLOYEE (personal_id, rank_title, dep_id)
VALUES (19002, 'Sales Representative', 1);

INSERT INTO COMPANY_AFFILIATE (personal_id, fname, lname, age, gender, address_id)
VALUES (17330, 'Robert', 'Williams', 46, 'M', 17330);
INSERT INTO EMPLOYEE (personal_id, rank_title, dep_id)
VALUES (17330, 'Sales Supervisor', 1);

INSERT INTO COMPANY_AFFILIATE (personal_id, fname, lname, age, gender, address_id)
VALUES (18211, 'Patricia', 'Brown', 48, 'F', 18211);
INSERT INTO EMPLOYEE (personal_id, rank_title, dep_id)
VALUES (18211, 'Regional Sales Manager', 1);

INSERT INTO COMPANY_AFFILIATE (personal_id, fname, lname, age, gender, address_id)
VALUES (15223, 'Michael', 'Brown', 50, 'M', 18211);
INSERT INTO EMPLOYEE (personal_id, rank_title, dep_id)
VALUES (15223, 'Chief Sales Officer', 1);

INSERT INTO COMPANY_AFFILIATE (personal_id, fname, lname, age, gender, address_id)
VALUES (25001, 'John', 'Doe', 29, 'M', 10101);
INSERT INTO EMPLOYEE (personal_id, rank_title, dep_id)
VALUES (25001, 'Sales Representative', 1);

    -- POTENTIAL_EMPLOYEE(s)
    
INSERT INTO COMPANY_AFFILIATE (personal_id, fname, lname, age, gender, address_id)
VALUES (24098, 'Linda', 'Garcia', 22, 'F', 24098);
INSERT INTO POTENTIAL_EMPLOYEE (personal_id) VALUES (24098);

    -- Customers

INSERT INTO COMPANY_AFFILIATE (personal_id, fname, lname, age, gender, address_id)
VALUES (10000, 'Josh', 'White', 51, 'M', 18211);
INSERT INTO CUSTOMER (personal_id, preferred_salesperson_id) VALUES (10000, 15223);

-- phone_number population

-- Populate PHONE_NUMBER for all company affiliates
INSERT INTO PHONE_NUMBER (personal_id, phone_num) VALUES (23002, '1234567890'); -- James Smith
INSERT INTO PHONE_NUMBER (personal_id, phone_num) VALUES (19002, '1234567891'); -- Mary Johnson
INSERT INTO PHONE_NUMBER (personal_id, phone_num) VALUES (17330, '1234567892'); -- Robert Williams
INSERT INTO PHONE_NUMBER (personal_id, phone_num) VALUES (18211, '1234567893'); -- Patricia Brown
INSERT INTO PHONE_NUMBER (personal_id, phone_num) VALUES (15223, '1234567894'); -- Michael Brown
INSERT INTO PHONE_NUMBER (personal_id, phone_num) VALUES (24098, '1234567895'); -- Linda Garcia
INSERT INTO PHONE_NUMBER (personal_id, phone_num) VALUES (25001, '1234567896'); -- John Doe
INSERT INTO PHONE_NUMBER (personal_id, phone_num) VALUES (10000, '1234567897'); -- Josh White


-- Salary population

-- Populate SALARY for EMPLOYEES
INSERT INTO SALARY (emp_id, transaction_num, pay_date, amount)
VALUES
(23002, 1, '2024-01-15', 3200),
(23002, 2, '2024-02-15', 3300),
(23002, 3, '2024-03-15', 3100),

(19002, 1, '2024-01-15', 5200),
(19002, 2, '2024-02-15', 5000),
(19002, 3, '2024-03-15', 5100),

(17330, 1, '2024-01-15', 7400),
(17330, 2, '2024-02-15', 7600),
(17330, 3, '2024-03-15', 7500),

(18211, 1, '2024-01-15', 10200),
(18211, 2, '2024-02-15', 10100),
(18211, 3, '2024-03-15', 10300),

(15223, 1, '2024-01-15', 15000),
(15223, 2, '2024-02-15', 15100),
(15223, 3, '2024-03-15', 14900),

(25001, 1, '2024-01-15', 4800),
(25001, 2, '2024-02-15', 4700),
(25001, 3, '2024-03-15', 4900);


INSERT INTO JOB_POS (job_id, job_desc, post_date, d_id)
VALUES (1001, 'Sales Associate 2024', '2024-08-14', 1);

INSERT INTO JOB_POS (job_id, job_desc, post_date, d_id)
VALUES (2001, 'Junior Engineer 2011', '2011-01-10', 2);

INSERT INTO JOB_POS (job_id, job_desc, post_date, d_id)
VALUES (12345, 'Chief Technology Officer', '2010-09-13', 2);

-- values to test query 7

INSERT INTO JOB_POS (job_id, job_desc, post_date, d_id) VALUES
    (1002, 'Sales Manager', '2010-12-15', 1),
    (3001, 'HR Specialist', '2011-02-15', 3),
    (4001, 'Marketing Intern', '2012-03-01', 4);

  
-- Application Population

INSERT INTO APPLICATION (app_id, personal_id, job_id)
VALUES (24098, 24098, 1001); -- POTENTIAL EMPLOYEE Linda Garcia

INSERT INTO APPLICATION (app_id, personal_id, job_id)
VALUES (240982, 24098, 12345); -- POTENTIAL EMPLOYEE Linda Garcia (to test that query 8 does not include potential employees)

INSERT INTO APPLICATION (app_id, personal_id, job_id)
VALUES (18211, 18211, 12345);

INSERT INTO APPLICATION (app_id, personal_id, job_id)
VALUES (15223, 15223, 12345);

INSERT INTO APPLICATION (app_id, personal_id, job_id)
VALUES (10001, 25001, 12345);

INSERT INTO APPLICATION (app_id, personal_id, job_id)
VALUES (10002, 24098, 12345);

INSERT INTO APPLICATION (app_id, personal_id, job_id)
VALUES (10003, 19002, 12345);


-- Interview Population

INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-01 10:00:00', 25001, 60, 10001, 1);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-02 10:00:00', 25001, 62, 10001, 2);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-03 10:00:00', 25001, 65, 10001, 3);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-04 10:00:00', 25001, 68, 10001, 4);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-05 10:00:00', 25001, 69, 10001, 5);

INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-01 09:00:00', 24098, 95, 10002, 1);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-02 09:00:00', 24098, 87, 10002, 2);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-03 09:00:00', 24098, 83, 10002, 3);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-04 09:00:00', 24098, 75, 10002, 4);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-05 09:00:00', 24098, 90, 10002, 5);

INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-01 10:30:00', 19002, 65, 10003, 1);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-02 10:30:00', 19002, 60, 10003, 2);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-03 10:30:00', 19002, 58, 10003, 3);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-04 10:30:00', 19002, 59, 10003, 4);
INSERT INTO INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES ('2024-01-05 10:30:00', 19002, 63, 10003, 5);


-- Interviewer Population

INSERT INTO INTERVIEWERS (personal_id, round_num, app_id, interviewer_id)
VALUES (24098, 1, 24098, 17330);
INSERT INTO INTERVIEWERS (personal_id, round_num, app_id, interviewer_id)
VALUES (24098, 2, 24098, 17330);
INSERT INTO INTERVIEWERS (personal_id, round_num, app_id, interviewer_id)
VALUES (24098, 3, 24098, 17330);
INSERT INTO INTERVIEWERS (personal_id, round_num, app_id, interviewer_id)
VALUES (24098, 3, 24098, 15223);

-- Product Population

INSERT INTO PRODUCT (prod_id, list_price, size, product_type, style, weight)
VALUES (1, 100, 2, 'Electronics', 'Smart Device', 2);
INSERT INTO PRODUCT (prod_id, list_price, size, product_type, style, weight)
VALUES (2, 10, 1, 'Accessories', 'Bracelet', 1);

-- Vendor Population
INSERT INTO VENDOR (vendor_id, credit_rating, name, acct_num, web_url, address_id)
VALUES (1, 100, 'Metal Parts Inc.', 10101, 'www.metalsupplier.net', 23002);

INSERT INTO VENDOR (vendor_id, credit_rating, name, acct_num, web_url, address_id)
VALUES (20, 100, 'Cups Inc.', 99990, 'www.cupsforcheap.net', 23002);

INSERT INTO VENDOR (vendor_id, credit_rating, name, acct_num, web_url, address_id)
VALUES (21, 100, 'Cups Limited.', 99991, 'www.cupslimited.org', 23002);

INSERT INTO VENDOR (vendor_id, credit_rating, name, acct_num, web_url, address_id)
VALUES (22, 100, 'Cups - A Cup Company.', 99991, 'www.cup.ru.com', 23002);


-- Part Population
INSERT INTO PART (part_id, price, vendor_id, name, weight)
VALUES 
(1, 30, 1, "metal component #1", 9),
(2, 50, 1, "metal component #2", 9),
(3, 70, 1, "metal component #3", 9),
(4, 20, 20, "Cup", 3),
(6, 5, 22, "Cup", 1),
(5, 10, 21, "Cup", 2);
       
-- Required_parts Population

INSERT INTO REQUIRED_PARTS (prod_id, part_id)
VALUES (1, 1);
INSERT INTO REQUIRED_PARTS (prod_id, part_id)
VALUES (2, 2);
INSERT INTO REQUIRED_PARTS (prod_id, part_id)
VALUES (1, 3);


-- Site Population

INSERT INTO SITE (site_id, site_name, site_location)
VALUES (1, 'Spruce Mills', 'Spruce Mills Mall');

-- Sale Population

INSERT INTO SALE (sale_id, sale_time, site_id, salesperson_id, customer_id, prod_id)
VALUES (1, '2022-11-07 17:30:00.000000', 1, 15223, 10000, 1);

INSERT INTO SALE (sale_id, sale_time, site_id, salesperson_id, customer_id, prod_id)
VALUES (2, '2022-11-07 17:30:00.000000', 1, 15223, 10000, 2);

INSERT INTO SALE (sale_id, sale_time, site_id, salesperson_id, customer_id, prod_id)
VALUES (3, '2022-11-07 17:30:00.000000', 1, 15223, 10000, 1);

-- Shift Population

INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (23002, 1, '2024-01-01 08:00:00', '2024-01-01 16:00:00');

INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (19002, 1, '2024-01-02 08:00:00', '2024-01-02 16:00:00');
INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (19002, 3, '2024-01-03 08:00:00', '2024-01-03 16:00:00');

INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (17330, 1, '2024-01-04 08:00:00', '2024-01-04 16:00:00');
INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (17330, 2, '2024-01-05 08:00:00', '2024-01-05 16:00:00');
INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (17330, 4, '2024-01-06 08:00:00', '2024-01-06 16:00:00');

INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (18211, 1, '2024-01-07 08:00:00', '2024-01-07 16:00:00');
INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (18211, 2, '2024-01-08 08:00:00', '2024-01-08 16:00:00');
INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (18211, 3, '2024-01-09 08:00:00', '2024-01-09 16:00:00');
INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (18211, 4, '2024-01-10 08:00:00', '2024-01-10 16:00:00');

INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (15223, 2, '2024-01-11 08:00:00', '2024-01-11 16:00:00');
INSERT INTO SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES (15223, 3, '2024-01-12 08:00:00', '2024-01-12 16:00:00');

-- EMAIL Population

INSERT INTO EMAIL (personal_id, email_addr) VALUES (23002, 'jamess@email.com');
INSERT INTO EMAIL (personal_id, email_addr) VALUES (19002, 'maryj@email.com');
INSERT INTO EMAIL (personal_id, email_addr) VALUES (17330, 'robertw@email.com');
INSERT INTO EMAIL (personal_id, email_addr) VALUES (18211, 'patriciab@email.com');
INSERT INTO EMAIL (personal_id, email_addr) VALUES (15223, 'michaelb@email.com');
INSERT INTO EMAIL (personal_id, email_addr) VALUES (25001, 'johnd@email.com');
INSERT INTO EMAIL (personal_id, email_addr) VALUES (24098, 'lindag@email.com');

-- SELECT * FROM EMPLOYEE JOIN COMPANY_AFFILIATE WHERE EMPLOYEE.personal_id = COMPANY_AFFILIATE.personal_id;

-- view creation:
-- View1
CREATE VIEW View1 AS
SELECT 
  emp_id AS Employee_ID,                                                        -- select the emp_id from SALARY under the column Employee_ID
  CONCAT(COMPANY_AFFILIATE.fname, ' ', COMPANY_AFFILIATE.lname) AS Name,        -- select the fname and lname from COMPANY_AFFILIATE,
                                                                                -- concatenated as '[fname] [lname]' under the column Name
  CONCAT('$',ROUND(AVG(monthly_total), 2)) AS Monthly_Salary                    -- select the monthly_total (defined below)
                                                                                -- take the average of all of them, then round to the second decimal place
                                                                                -- then add a '$' before by using CONCAT. store result in column Monthly_Salary.
FROM (
  SELECT                                                                        -- select from the table MonthlySalaries defined below
    emp_id,                                                                       -- select the emp ID from SALARY
    SUBSTRING(pay_date, 1, 7) AS pay_month,                                       -- get the Year and Month, (YYYY-MM), as pay_month from paydate in SALARY.
    SUM(amount) AS monthly_total                                                  -- get the total sum of amount as monthly_total.
                                                                                    -- this will make it so that all paychecks in a month are summed and grouped together. 
  FROM SALARY 
  GROUP BY emp_id, SUBSTRING(pay_date, 1, 7)                                        -- group data by YYYY-MM and emp_id for this table
) MonthlySalaries
JOIN COMPANY_AFFILIATE ON MonthlySalaries.emp_id = COMPANY_AFFILIATE.personal_id      -- join MonthlySalaries and COMPANY_AFFILIATE on personal_id (emp_id)
GROUP BY emp_id;

-- View2

CREATE VIEW View2 AS
SELECT
  CONCAT(COMPANY_AFFILIATE.fname, ' ', COMPANY_AFFILIATE.lname) AS Name,        -- Concatenate fname and lname as Name from COMPANY_AFFILIATE
  APPLICATION.personal_id AS Applicant_ID,                                      -- Get the personal_id from APPLICATION as Applicant_ID
  JOB_POS.job_desc AS Job_Position,                                             -- Get the job_desc (name) from Job_Position
  COUNT(INTERVIEW.round_num) AS Rounds_Passed                                   -- Count the number of INTERVIEW rounds as Rounds_Passed
FROM INTERVIEW                                                                  -- From TABLE INTERVIEW, joining
JOIN APPLICATION ON INTERVIEW.app_id = APPLICATION.app_id                           -- with APPLICATION on app_id
JOIN JOB_POS ON APPLICATION.job_id = JOB_POS.job_id                                 -- with JOB_POS on job_id
JOIN COMPANY_AFFILIATE ON APPLICATION.personal_id = COMPANY_AFFILIATE.personal_id   -- with COMPANY_AFFILIATE on personal_id
WHERE INTERVIEW.grade >= 60                                                     -- restrict the output where the grade of the interview is >= 60 (pass)
GROUP BY APPLICATION.personal_id, JOB_POS.job_desc;                             -- group output by personal_id, job_desc

-- view testing

SELECT * FROM View1;
SELECT * FROM View2;

-- queries

-- #7

-- SELECT 
--   DEPARTMENT.dep_id AS Department_ID,
--   DEPARTMENT.dep_name AS Department_Name
-- FROM DEPARTMENT
-- LEFT JOIN 
--   JOB_POS ON DEPARTMENT.dep_id = JOB_POS.d_id AND JOB_POS.post_date BETWEEN '2011-01-01' AND '2011-02-01'
-- WHERE JOB_POS.job_id IS NULL;

-- #8

SELECT
  CONCAT(COMPANY_AFFILIATE.fname, ' ', COMPANY_AFFILIATE.lname) AS Employee_Name,     -- concatenate fname and lname from COMPANY_AFFILIATE
  EMPLOYEE.personal_id AS Employee_ID,                                                -- get personal_id as Employee_ID from EMPLOYEE table
  EMPLOYEE.dep_id AS Department_ID                                                    -- get dep_id as Department_ID from DEPARTMENT
FROM EMPLOYEE                                                                         -- from EMPLOYEE table, joined with
                                                                                      -- (restricts query to employees only)
JOIN COMPANY_AFFILIATE ON EMPLOYEE.personal_id = COMPANY_AFFILIATE.personal_id          -- COMPANY_AFFILIATE on personal_id
JOIN APPLICATION ON EMPLOYEE.personal_id = APPLICATION.personal_id                      -- APPLICATION on personal_id
WHERE APPLICATION.job_id = 12345;                                                     -- restrict to only job_id 12345

-- #9

SELECT
  PRODUCT.product_type AS Product,                          -- get the product_type as Product
  COUNT(SALE.sale_id) AS Total_Sales                        -- Count the entries of sale_id as Total_Sales
FROM SALE JOIN PRODUCT ON SALE.prod_id = PRODUCT.prod_id    -- JOIN with PRODUCT on prod_id
GROUP BY PRODUCT.product_type                               -- group by product_type
ORDER BY Total_Sales DESC                                   -- Order the entries by Total_Sales in descending order
LIMIT 1;                                                    -- Only display top entry

-- #10

SELECT 
  PRODUCT.product_type AS Product,                                -- Get product_type as Product
  SUM(PRODUCT.list_price - PART.price) AS Net_Profit              -- Get the sum of all list prices - the price of parts as Net_Profit
FROM SALE                                                         -- From SALE
JOIN PRODUCT ON SALE.prod_id = PRODUCT.prod_id                    -- Join PRODUCT on prod_id
JOIN REQUIRED_PARTS ON PRODUCT.prod_id = REQUIRED_PARTS.prod_id   -- Join REQUIRED_PARTS on prod_id
JOIN PART ON REQUIRED_PARTS.part_id = PART.part_id                -- Join PART where REQUIRED_PARTS.part_id matches PART.part_id
GROUP BY PRODUCT.product_type                                     -- group by product_type
ORDER BY Net_Profit DESC                                          -- order descending by Net_Profit
LIMIT 1;                                                          -- Show only first entry

-- #11

SELECT 
  CONCAT(CA.fname, ' ', CA.lname) AS Employee_Name,                 -- Concatenate fname and lname as Employee_Name
  E.personal_id AS Employee_ID                                      -- Get EMPLOYEE personal_id as Employee_ID
FROM EMPLOYEE E                                                     -- FROM EMPLOYEE as E
JOIN COMPANY_AFFILIATE CA ON E.personal_id = CA.personal_id           -- Join COMPANY_AFFILIATE as CA on personal_id
JOIN SHIFT S ON E.personal_id = S.emp_id                              -- Join SHIFT as S on emp_id = personal_id
GROUP BY E.personal_id                                                -- group by personal_id
HAVING COUNT(DISTINCT S.d_id) = (SELECT COUNT(*) FROM DEPARTMENT);  -- Count the amount of DISTINCT Department_ID's that the EMPLOYEE
                                                                    -- has for shift, if they're equal to the total number of Departments
                                                                    -- display


-- #12

SELECT
  CONCAT(COMPANY_AFFILIATE.fname, ' ', COMPANY_AFFILIATE.lname) AS Applicant_Name,        -- combine fname and lname from COMPANY_AFFILIATE as Applicant_Name
  EMAIL.email_addr AS Email                                                               -- get email from EMAIL as Email
FROM
(  -- START NESTED FROM (Table PassedCandidates)
  SELECT                                                                                                     
    INTERVIEW.personal_id,                                                                    -- get personal_id from INTERVIEW
    AVG(INTERVIEW.grade) AS Avg_Grade,                                                        -- AVG the grades as Avg_Grade
    COUNT(*) AS Passed_Rounds                                                                 -- Count all as Passed_Rounds
  FROM INTERVIEW                                                                              
  WHERE INTERVIEW.grade >= 60                                                                 -- only include Interviews where grade >= 60
  GROUP BY INTERVIEW.personal_id                                                              -- group by personal_id
  HAVING AVG(INTERVIEW.grade) >= 70                                                           -- where the Average of grades >= 70
) -- END NESTED FROM
AS PassedCandidates
JOIN COMPANY_AFFILIATE ON PassedCandidates.personal_id = COMPANY_AFFILIATE.personal_id    -- join COMPANY_AFFILIATE on personal_id
JOIN EMAIL ON PassedCandidates.personal_id = EMAIL.personal_id                            -- join EMAIl on personal_id
LIMIT 1;                                                                                  -- Assuming only 1 selected

-- #13

SELECT
  CONCAT(COMPANY_AFFILIATE.fname, ' ', COMPANY_AFFILIATE.lname) AS Interviewee_Name,      -- concatenate fname and lname as Interviewee_Name
  PHONE_NUMBER.phone_num AS Phone_Number,                                                 -- get phone_num as Phone_Number
  EMAIL.email_addr AS Email_Address,                                                      -- get email_addr as Email_Address
  APPLICATION.job_id AS Job_ID                                                            -- get job_id as Job_ID
FROM
( -- START NESTED FROM
  SELECT 
    personal_id,                                                                          -- get personal_id
    app_id,                                                                               -- get app_id
    AVG(grade) AS Avg_Grade,                                                              -- get the avg of grades as Avg_Grade
    COUNT(CASE WHEN grade >= 60 THEN 1 END) AS Passed_Rounds                              -- count the entry when grade >= 60 as 1 as Passed_rounds
  FROM INTERVIEW                                                                          
  GROUP BY personal_id, app_id                                                            -- group them by personal_id and app_id
  HAVING AVG(grade) >= 70 AND Passed_Rounds >= 5                                          -- restrict them where the avg of grades is >= 70 and Passed_Rounds >= 5
) -- END NESTED FROM
AS Selected -- Table named Selected
JOIN APPLICATION ON Selected.app_id = APPLICATION.app_id                                  -- Join with Selected on app_id
JOIN COMPANY_AFFILIATE ON APPLICATION.personal_id = COMPANY_AFFILIATE.personal_id         -- join COMPANY_AFFILIATE on personal_id
LEFT JOIN PHONE_NUMBER ON COMPANY_AFFILIATE.personal_id = PHONE_NUMBER.personal_id        -- left join with PHONE_NUMBER on personal_id
LEFT JOIN EMAIL ON COMPANY_AFFILIATE.personal_id = EMAIL.personal_id;                     -- left join with email on personal_id


-- #14

SELECT
  CONCAT(COMPANY_AFFILIATE.fname, ' ', COMPANY_AFFILIATE.lname) AS Employee_Name,           -- concatenate fname and lname as Employee_Name
  SALARY.emp_id AS Employee_ID,                                                             -- get emp_id from SALARY as Employee_ID
  ROUND(AVG(SALARY.amount), 2) AS Average_Monthly_Salary                                    -- ROUND the AVG Salary to second decimal as Average_Monthly_Salary from SALARY
FROM SALARY
JOIN COMPANY_AFFILIATE ON SALARY.emp_id = COMPANY_AFFILIATE.personal_id                     -- join COMPANY_AFFILIATE on emp_id = personal_id
GROUP BY SALARY.emp_id                                                                      -- group by emp_id
ORDER BY Average_Monthly_Salary DESC                                                        -- sort in descending order
LIMIT 1;                                                                                    -- limit to top entry

-- #15

SELECT                                          
  VENDOR.vendor_id AS Vendor_ID,                -- get vendor_id as Vendor_ID from VENDOR
  VENDOR.name AS Vendor_Name                    -- get name as Vendor_Name from VENDOR
FROM VENDOR
JOIN PART ON VENDOR.vendor_id = PART.vendor_id  -- join with PART on vendor_id
WHERE PART.name = 'Cup' AND PART.weight < 4     -- where the PART name = 'Cup' and the weight < 4
ORDER BY PART.price ASC                         -- sort ascendingly
LIMIT 1;                                        -- only show top entry

