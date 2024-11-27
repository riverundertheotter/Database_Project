-- populate section
INSERT INTO
    DEPARTMENT (dep_id, dep_name)
VALUES
    (1, 'Sales'),
    (2, 'Engineering'),
    (3, 'HR'),
    (4, 'Marketing');

-- 4 
INSERT INTO
    ADDRESS (address_id, city, state, zip, line1, line2)
VALUES
    (
        23002,
        'City',
        'TX',
        12345,
        '2319 Johnson Lane',
        NULL
    );

INSERT INTO
    ADDRESS (address_id, city, state, zip, line1, line2)
VALUES
    (
        19002,
        'City',
        'TX',
        12325,
        '5432 W. Nemo Street',
        NULL
    );

INSERT INTO
    ADDRESS (address_id, city, state, zip, line1, line2)
VALUES
    (
        17330,
        'Town',
        'TX',
        12125,
        '4002 Red Street',
        NULL
    );

INSERT INTO
    ADDRESS (address_id, city, state, zip, line1, line2)
VALUES
    (
        18211,
        'City',
        'TX',
        12322,
        '3321 Blue Street',
        NULL
    );

INSERT INTO
    ADDRESS (address_id, city, state, zip, line1, line2)
VALUES
    (
        24098,
        'Town',
        'FL',
        78201,
        '9091 Green Way',
        NULL
    );

INSERT INTO
    ADDRESS (address_id, city, state, zip, line1, line2)
VALUES
    (
        10101,
        'Town',
        'FL',
        78201,
        '9091 Green Way',
        NULL
    );

-- Company Affiliate (Employees, P_Employees, and Customers)
-- EMPLOYEE(s)
INSERT INTO
    COMPANY_AFFILIATE (
        personal_id,
        fname,
        lname,
        age,
        gender,
        address_id
    )
VALUES
    (23002, 'James', 'Smith', 28, 'M', 23002);

INSERT INTO
    EMPLOYEE (personal_id, rank_title, dep_id)
VALUES
    (23002, 'Junior Sales Associate', 1);

INSERT INTO
    COMPANY_AFFILIATE (
        personal_id,
        fname,
        lname,
        age,
        gender,
        address_id
    )
VALUES
    (19002, 'Mary', 'Johnson', 32, 'F', 19002);

INSERT INTO
    EMPLOYEE (personal_id, rank_title, dep_id)
VALUES
    (19002, 'Sales Representative', 1);

INSERT INTO
    COMPANY_AFFILIATE (
        personal_id,
        fname,
        lname,
        age,
        gender,
        address_id
    )
VALUES
    (17330, 'Robert', 'Williams', 46, 'M', 17330);

INSERT INTO
    EMPLOYEE (personal_id, rank_title, dep_id)
VALUES
    (17330, 'Sales Supervisor', 1);

INSERT INTO
    COMPANY_AFFILIATE (
        personal_id,
        fname,
        lname,
        age,
        gender,
        address_id
    )
VALUES
    (18211, 'Patricia', 'Brown', 48, 'F', 18211);

INSERT INTO
    EMPLOYEE (personal_id, rank_title, dep_id)
VALUES
    (18211, 'Regional Sales Manager', 1);

INSERT INTO
    COMPANY_AFFILIATE (
        personal_id,
        fname,
        lname,
        age,
        gender,
        address_id
    )
VALUES
    (15223, 'Michael', 'Brown', 50, 'M', 18211);

INSERT INTO
    EMPLOYEE (personal_id, rank_title, dep_id)
VALUES
    (15223, 'Chief Sales Officer', 1);

INSERT INTO
    COMPANY_AFFILIATE (
        personal_id,
        fname,
        lname,
        age,
        gender,
        address_id
    )
VALUES
    (25001, 'John', 'Doe', 29, 'M', 10101);

INSERT INTO
    EMPLOYEE (personal_id, rank_title, dep_id)
VALUES
    (25001, 'Sales Representative', 1);

-- POTENTIAL_EMPLOYEE(s)
INSERT INTO
    COMPANY_AFFILIATE (
        personal_id,
        fname,
        lname,
        age,
        gender,
        address_id
    )
VALUES
    (24098, 'Linda', 'Garcia', 22, 'F', 24098);

INSERT INTO
    POTENTIAL_EMPLOYEE (personal_id)
VALUES
    (24098);

-- Customers
INSERT INTO
    COMPANY_AFFILIATE (
        personal_id,
        fname,
        lname,
        age,
        gender,
        address_id
    )
VALUES
    (10000, 'Josh', 'White', 51, 'M', 18211);

INSERT INTO
    CUSTOMER (personal_id, preferred_salesperson_id)
VALUES
    (10000, 15223);

-- phone_number population
-- Populate PHONE_NUMBER for all company affiliates
INSERT INTO
    PHONE_NUMBER (personal_id, phone_num)
VALUES
    (23002, '1234567890');

-- James Smith
INSERT INTO
    PHONE_NUMBER (personal_id, phone_num)
VALUES
    (19002, '1234567891');

-- Mary Johnson
INSERT INTO
    PHONE_NUMBER (personal_id, phone_num)
VALUES
    (17330, '1234567892');

-- Robert Williams
INSERT INTO
    PHONE_NUMBER (personal_id, phone_num)
VALUES
    (18211, '1234567893');

-- Patricia Brown
INSERT INTO
    PHONE_NUMBER (personal_id, phone_num)
VALUES
    (15223, '1234567894');

-- Michael Brown
INSERT INTO
    PHONE_NUMBER (personal_id, phone_num)
VALUES
    (24098, '1234567895');

-- Linda Garcia
INSERT INTO
    PHONE_NUMBER (personal_id, phone_num)
VALUES
    (25001, '1234567896');

-- John Doe
INSERT INTO
    PHONE_NUMBER (personal_id, phone_num)
VALUES
    (10000, '1234567897');

-- Josh White
-- Salary population
-- Populate SALARY for EMPLOYEES
INSERT INTO
    SALARY (emp_id, transaction_num, pay_date, amount)
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

INSERT INTO
    JOB_POS (job_id, job_desc, post_date, d_id)
VALUES
    (11111, 'Sales Associate 2024', '2024-08-14', 1);

INSERT INTO
    JOB_POS (job_id, job_desc, post_date, d_id)
VALUES
    (2001, 'Junior Engineer 2011', '2011-01-10', 2);

INSERT INTO
    JOB_POS (job_id, job_desc, post_date, d_id)
VALUES
    (
        12345,
        'Chief Technology Officer',
        '2010-09-13',
        2
    );

-- values to test query 7
INSERT INTO
    JOB_POS (job_id, job_desc, post_date, d_id)
VALUES
    (1002, 'Sales Manager', '2010-12-15', 1),
    (3001, 'HR Specialist', '2011-02-15', 3),
    (4001, 'Marketing Intern', '2012-03-01', 4);

-- Application Population
INSERT INTO
    APPLICATION (app_id, personal_id, job_id)
VALUES
    (24098, 24098, 1001);

-- POTENTIAL EMPLOYEE Linda Garcia
INSERT INTO
    APPLICATION (app_id, personal_id, job_id)
VALUES
    (240982, 24098, 12345);

-- POTENTIAL EMPLOYEE Linda Garcia (to test that query 8 does not include potential employees)
INSERT INTO
    APPLICATION (app_id, personal_id, job_id)
VALUES
    (18211, 18211, 12345);

INSERT INTO
    APPLICATION (app_id, personal_id, job_id)
VALUES
    (15223, 15223, 12345);

INSERT INTO
    APPLICATION (app_id, personal_id, job_id)
VALUES
    (10001, 25001, 12345);

INSERT INTO
    APPLICATION (app_id, personal_id, job_id)
VALUES
    (10002, 24098, 12345);

INSERT INTO
    APPLICATION (app_id, personal_id, job_id)
VALUES
    (10003, 19002, 12345);

-- Interview Population
INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-01 10:00:00', 25001, 60, 10001, 1);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-02 10:00:00', 25001, 62, 10001, 2);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-03 10:00:00', 25001, 65, 10001, 3);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-04 10:00:00', 25001, 68, 10001, 4);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-05 10:00:00', 25001, 69, 10001, 5);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-01 09:00:00', 24098, 95, 10002, 1);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-02 09:00:00', 24098, 87, 10002, 2);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-03 09:00:00', 24098, 83, 10002, 3);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-04 09:00:00', 24098, 75, 10002, 4);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-05 09:00:00', 24098, 90, 10002, 5);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-01 10:30:00', 19002, 65, 10003, 1);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-02 10:30:00', 19002, 60, 10003, 2);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-03 10:30:00', 19002, 58, 10003, 3);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-04 10:30:00', 19002, 59, 10003, 4);

INSERT INTO
    INTERVIEW (time, personal_id, grade, app_id, round_num)
VALUES
    ('2024-01-05 10:30:00', 19002, 63, 10003, 5);

-- Interviewer Population
INSERT INTO
    INTERVIEWERS (personal_id, round_num, app_id, interviewer_id)
VALUES
    (24098, 1, 24098, 17330);

INSERT INTO
    INTERVIEWERS (personal_id, round_num, app_id, interviewer_id)
VALUES
    (24098, 2, 24098, 17330);

INSERT INTO
    INTERVIEWERS (personal_id, round_num, app_id, interviewer_id)
VALUES
    (24098, 3, 24098, 17330);

INSERT INTO
    INTERVIEWERS (personal_id, round_num, app_id, interviewer_id)
VALUES
    (24098, 3, 24098, 15223);

-- Product Population
INSERT INTO
    PRODUCT (
        prod_id,
        list_price,
        size,
        product_type,
        style,
        weight
    )
VALUES
    (1, 100, 2, 'Electronics', 'Smart Device', 2);

INSERT INTO
    PRODUCT (
        prod_id,
        list_price,
        size,
        product_type,
        style,
        weight
    )
VALUES
    (2, 10, 1, 'Accessories', 'Bracelet', 1);

-- Vendor Population
INSERT INTO
    VENDOR (
        vendor_id,
        credit_rating,
        name,
        acct_num,
        web_url,
        address_id
    )
VALUES
    (
        1,
        100,
        'Metal Parts Inc.',
        10101,
        'www.metalsupplier.net',
        23002
    );

INSERT INTO
    VENDOR (
        vendor_id,
        credit_rating,
        name,
        acct_num,
        web_url,
        address_id
    )
VALUES
    (
        20,
        100,
        'Cups Inc.',
        99990,
        'www.cupsforcheap.net',
        23002
    );

INSERT INTO
    VENDOR (
        vendor_id,
        credit_rating,
        name,
        acct_num,
        web_url,
        address_id
    )
VALUES
    (
        21,
        100,
        'Cups Limited.',
        99991,
        'www.cupslimited.org',
        23002
    );

INSERT INTO
    VENDOR (
        vendor_id,
        credit_rating,
        name,
        acct_num,
        web_url,
        address_id
    )
VALUES
    (
        22,
        100,
        'Cups - A Cup Company.',
        99991,
        'www.cup.ru.com',
        23002
    );

-- Part Population
INSERT INTO
    PART (part_id, price, vendor_id, name, weight)
VALUES
    (1, 30, 1, "metal component #1", 9),
    (2, 50, 1, "metal component #2", 9),
    (3, 70, 1, "metal component #3", 9),
    (4, 20, 20, "Cup", 3),
    (6, 5, 22, "Cup", 1),
    (5, 10, 21, "Cup", 2);

-- Required_parts Population
INSERT INTO
    REQUIRED_PARTS (prod_id, part_id)
VALUES
    (1, 1);

INSERT INTO
    REQUIRED_PARTS (prod_id, part_id)
VALUES
    (2, 2);

INSERT INTO
    REQUIRED_PARTS (prod_id, part_id)
VALUES
    (1, 3);

-- Site Population
INSERT INTO
    SITE (site_id, site_name, site_location)
VALUES
    (1, 'Spruce Mills', 'Spruce Mills Mall');

-- Sale Population
INSERT INTO
    SALE (
        sale_id,
        sale_time,
        site_id,
        salesperson_id,
        customer_id,
        prod_id
    )
VALUES
    (
        1,
        '2022-11-07 17:30:00.000000',
        1,
        15223,
        10000,
        1
    );

INSERT INTO
    SALE (
        sale_id,
        sale_time,
        site_id,
        salesperson_id,
        customer_id,
        prod_id
    )
VALUES
    (
        2,
        '2022-11-07 17:30:00.000000',
        1,
        15223,
        10000,
        2
    );

INSERT INTO
    SALE (
        sale_id,
        sale_time,
        site_id,
        salesperson_id,
        customer_id,
        prod_id
    )
VALUES
    (
        3,
        '2022-11-07 17:30:00.000000',
        1,
        15223,
        10000,
        1
    );

-- Shift Population
INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        23002,
        1,
        '2024-01-01 08:00:00',
        '2024-01-01 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        19002,
        1,
        '2024-01-02 08:00:00',
        '2024-01-02 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        19002,
        3,
        '2024-01-03 08:00:00',
        '2024-01-03 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        17330,
        1,
        '2024-01-04 08:00:00',
        '2024-01-04 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        17330,
        2,
        '2024-01-05 08:00:00',
        '2024-01-05 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        17330,
        4,
        '2024-01-06 08:00:00',
        '2024-01-06 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        18211,
        1,
        '2024-01-07 08:00:00',
        '2024-01-07 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        18211,
        2,
        '2024-01-08 08:00:00',
        '2024-01-08 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        18211,
        3,
        '2024-01-09 08:00:00',
        '2024-01-09 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        18211,
        4,
        '2024-01-10 08:00:00',
        '2024-01-10 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        15223,
        2,
        '2024-01-11 08:00:00',
        '2024-01-11 16:00:00'
    );

INSERT INTO
    SHIFT (emp_id, d_id, shift_start, shift_end)
VALUES
    (
        15223,
        3,
        '2024-01-12 08:00:00',
        '2024-01-12 16:00:00'
    );

-- EMAIL Population
INSERT INTO
    EMAIL (personal_id, email_addr)
VALUES
    (23002, 'jamess@email.com');

INSERT INTO
    EMAIL (personal_id, email_addr)
VALUES
    (19002, 'maryj@email.com');

INSERT INTO
    EMAIL (personal_id, email_addr)
VALUES
    (17330, 'robertw@email.com');

INSERT INTO
    EMAIL (personal_id, email_addr)
VALUES
    (18211, 'patriciab@email.com');

INSERT INTO
    EMAIL (personal_id, email_addr)
VALUES
    (15223, 'michaelb@email.com');

INSERT INTO
    EMAIL (personal_id, email_addr)
VALUES
    (25001, 'johnd@email.com');

INSERT INTO
    EMAIL (personal_id, email_addr)
VALUES
    (24098, 'lindag@email.com');

-- View3
CREATE VIEW
    View3 AS
SELECT
    p.product_type,
    COUNT(s.sale_id) AS items_sold
FROM
    SALE s
    JOIN PRODUCT p ON s.prod_id = p.prod_id
GROUP BY
    p.product_type;

-- View4
CREATE VIEW
    View4 AS
SELECT
    rp.prod_id,
    SUM(pr.price) AS total_part_cost
FROM
    REQUIRED_PARTS rp
    JOIN PART pr on rp.part_id = pr.part_id
GROUP BY
    rp.prod_id;

-- Query 1
SELECT
    i.interviewer_id,
    CONCAT (e.fname, ' ', e.lname) AS interviewer_name
FROM
    INTERVIEWERS i
    JOIN EMPLOYEE em ON i.interviewer_id = em.personal_id
    JOIN APPLICATION a ON i.app_id = a.app_id
    JOIN COMPANY_AFFILIATE ca ON a.personal_id = ca.personal_id_emp
WHERE
    ca.fname = "Helen"
    AND ca.lname = "Cole"
    AND a.job_id = 11111;

-- Query 2
SELECT
    j.job_id
FROM
    JOB_POS j
    JOIN DEPARTMENT d ON j.job_id
WHERE
    d.dep_name = 'Marketing'
    AND j.post_date BETWEEN '2011-01-01' AND '2011-01-31';

-- Query 3
SELECT
    e.personal_id,
    CONCAT (ca.fname, ' ', ca.lname)
FROM
    EMPLOYEE e
    JOIN COMPANY_AFFILIATE ca ON e.personal_id = ca.personal_id
WHERE
    e.personal_id NOT IN (
        SELECT
            sup_id
        FROM
            MANAGES
    );

-- Query 4
SELECT
    s.site_id,
    s.site_location
FROM
    SITE S
    JOIN DEPARTMENT d ON d.dep_id = (
        SELECT
            dep_id
        FROM
            DEPARTMENT
        WHERE
            dep_name = 'Marketing'
    )
    LEFT JOIN SALE sa ON sa.site_id = s.site_id
    AND sa.sale_time BETWEEN '2011-03-01' AND '2011-03-31'
WHERE
    sa.sale_id IS NULL;

-- Query 5
SELECT
    j.job_id,
    j.job_desc
FROM
    JOB_POS j
    LEFT JOIN APPLICATION a ON j.job_id = a.job_id
WHERE
    a.app_id IS NULL
    AND j.post_date < DATE ('now', '-1 month');

-- Query 6
SELECT
    e.personal_id,
    ca.fname || ' ' || ca.lname AS salesperson_name
FROM
    EMPLOYEE e
    JOIN COMPANY_AFFILIATE ca ON e.personal_id = ca.personal_id
WHERE
    NOT EXISTS (
        SELECT DISTINCT
            p.product_type
        FROM
            PRODUCT p
        WHERE
            p.list_price > 200
            AND NOT EXISTS (
                SELECT
                    1
                FROM
                    SALE s
                WHERE
                    s.salesperson_id = e.personal_id
                    AND s.prod_id = p.prod_id
            )
    );

-- Query 7
SELECT
    d.dep_id,
    d.dep_name
FROM
    DEPARTMENT d
    LEFT JOIN JOB_POS j ON d.dep_id = j.d_id
    AND j.post_date BETWEEN '2011-01-01' AND '2011-02-01'
WHERE
    j.job_id IS NULL;