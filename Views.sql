-- view creation:
-- View1
CREATE VIEW
    View1 AS
SELECT
    emp_id AS Employee_ID, -- select the emp_id from SALARY under the column Employee_ID
    CONCAT (
        COMPANY_AFFILIATE.fname,
        ' ',
        COMPANY_AFFILIATE.lname
    ) AS Name, -- select the fname and lname from COMPANY_AFFILIATE,
    -- concatenated as '[fname] [lname]' under the column Name
    CONCAT ('$', ROUND(AVG(monthly_total), 2)) AS Monthly_Salary -- select the monthly_total (defined below)
    -- take the average of all of them, then round to the second decimal place
    -- then add a '$' before by using CONCAT. store result in column Monthly_Salary.
FROM
    (
        SELECT -- select from the table MonthlySalaries defined below
            emp_id, -- select the emp ID from SALARY
            SUBSTRING(pay_date, 1, 7) AS pay_month, -- get the Year and Month, (YYYY-MM), as pay_month from paydate in SALARY.
            SUM(amount) AS monthly_total -- get the total sum of amount as monthly_total.
            -- this will make it so that all paychecks in a month are summed and grouped together. 
        FROM
            SALARY
        GROUP BY
            emp_id,
            SUBSTRING(pay_date, 1, 7) -- group data by YYYY-MM and emp_id for this table
    ) MonthlySalaries
    JOIN COMPANY_AFFILIATE ON MonthlySalaries.emp_id = COMPANY_AFFILIATE.personal_id -- join MonthlySalaries and COMPANY_AFFILIATE on personal_id (emp_id)
GROUP BY
    emp_id;

-- View2
CREATE VIEW
    View2 AS
SELECT
    CONCAT (
        COMPANY_AFFILIATE.fname,
        ' ',
        COMPANY_AFFILIATE.lname
    ) AS Name, -- Concatenate fname and lname as Name from COMPANY_AFFILIATE
    APPLICATION.personal_id AS Applicant_ID, -- Get the personal_id from APPLICATION as Applicant_ID
    JOB_POS.job_desc AS Job_Position, -- Get the job_desc (name) from Job_Position
    COUNT(INTERVIEW.round_num) AS Rounds_Passed -- Count the number of INTERVIEW rounds as Rounds_Passed
FROM
    INTERVIEW -- From TABLE INTERVIEW, joining
    JOIN APPLICATION ON INTERVIEW.app_id = APPLICATION.app_id -- with APPLICATION on app_id
    JOIN JOB_POS ON APPLICATION.job_id = JOB_POS.job_id -- with JOB_POS on job_id
    JOIN COMPANY_AFFILIATE ON APPLICATION.personal_id = COMPANY_AFFILIATE.personal_id -- with COMPANY_AFFILIATE on personal_id
WHERE
    INTERVIEW.grade >= 60 -- restrict the output where the grade of the interview is >= 60 (pass)
GROUP BY
    APPLICATION.personal_id,
    JOB_POS.job_desc;

-- group output by personal_id, job_desc
-- view testing
SELECT
    *
FROM
    View1;

SELECT
    *
FROM
    View2;

-- View3
CREATE VIEW
    View3 AS
SELECT
    p.product_type, -- getting product type
    COUNT(s.sale_id) AS items_sold -- getting total amount of sales for each product
FROM
    SALE s
    JOIN PRODUCT p ON s.prod_id = p.prod_id -- join where the product ids match
GROUP BY
    -- group results by product type
    p.product_type;

-- View4
CREATE VIEW
    View4 AS
SELECT
    rp.prod_id, -- getting product id of required product
    SUM(p.price) AS total_part_cost -- summing the total price of all required parts on a product
FROM
    REQUIRED_PARTS rp
    JOIN PART p on rp.part_id = p.part_id -- join required parts on product where the part_id matches.
GROUP BY
    -- group by product_id
    rp.prod_id;

-- verifying the views are correct
SELECT
    *
FROM
    View3;

SELECT
    *
FROM
    View4;