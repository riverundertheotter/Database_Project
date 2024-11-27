-- Query 1
SELECT
    i.interviewer_id,
    CONCAT (c.fname, ' ', c.lname) AS interviewer_name
FROM
    INTERVIEWERS i
    JOIN EMPLOYEE em ON i.interviewer_id = em.personal_id
    JOIN COMPANY_AFFILIATE c ON em.personal_id = c.personal_id
    JOIN APPLICATION a ON i.app_id = a.app_id
    JOIN COMPANY_AFFILIATE interviewee ON a.personal_id = interviewee.personal_id
WHERE
    interviewee.fname = "Hellen"
    AND interviewee.lname = "Cole"
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
    AND j.post_date < DATE_SUB(NOW(), INTERVAL 1 MONTH);

-- Query 6
SELECT
    e.personal_id,
    CONCAT (ca.fname, " ", ca.lname) AS salesperson_name
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

-- #8
SELECT
    CONCAT (
        COMPANY_AFFILIATE.fname,
        ' ',
        COMPANY_AFFILIATE.lname
    ) AS Employee_Name, -- concatenate fname and lname from COMPANY_AFFILIATE
    EMPLOYEE.personal_id AS Employee_ID, -- get personal_id as Employee_ID from EMPLOYEE table
    EMPLOYEE.dep_id AS Department_ID -- get dep_id as Department_ID from DEPARTMENT
FROM
    EMPLOYEE -- from EMPLOYEE table, joined with
    -- (restricts query to employees only)
    JOIN COMPANY_AFFILIATE ON EMPLOYEE.personal_id = COMPANY_AFFILIATE.personal_id -- COMPANY_AFFILIATE on personal_id
    JOIN APPLICATION ON EMPLOYEE.personal_id = APPLICATION.personal_id -- APPLICATION on personal_id
WHERE
    APPLICATION.job_id = 12345;

-- restrict to only job_id 12345
-- #9
SELECT
    PRODUCT.product_type AS Product, -- get the product_type as Product
    COUNT(SALE.sale_id) AS Total_Sales -- Count the entries of sale_id as Total_Sales
FROM
    SALE
    JOIN PRODUCT ON SALE.prod_id = PRODUCT.prod_id -- JOIN with PRODUCT on prod_id
GROUP BY
    PRODUCT.product_type -- group by product_type
ORDER BY
    Total_Sales DESC -- Order the entries by Total_Sales in descending order
LIMIT
    1;

-- Only display top entry
-- #10
SELECT
    PRODUCT.product_type AS Product, -- Get product_type as Product
    SUM(PRODUCT.list_price - PART.price) AS Net_Profit -- Get the sum of all list prices - the price of parts as Net_Profit
FROM
    SALE -- From SALE
    JOIN PRODUCT ON SALE.prod_id = PRODUCT.prod_id -- Join PRODUCT on prod_id
    JOIN REQUIRED_PARTS ON PRODUCT.prod_id = REQUIRED_PARTS.prod_id -- Join REQUIRED_PARTS on prod_id
    JOIN PART ON REQUIRED_PARTS.part_id = PART.part_id -- Join PART where REQUIRED_PARTS.part_id matches PART.part_id
GROUP BY
    PRODUCT.product_type -- group by product_type
ORDER BY
    Net_Profit DESC -- order descending by Net_Profit
LIMIT
    1;

-- Show only first entry
-- #11
SELECT
    CONCAT (CA.fname, ' ', CA.lname) AS Employee_Name, -- Concatenate fname and lname as Employee_Name
    E.personal_id AS Employee_ID -- Get EMPLOYEE personal_id as Employee_ID
FROM
    EMPLOYEE E -- FROM EMPLOYEE as E
    JOIN COMPANY_AFFILIATE CA ON E.personal_id = CA.personal_id -- Join COMPANY_AFFILIATE as CA on personal_id
    JOIN SHIFT S ON E.personal_id = S.emp_id -- Join SHIFT as S on emp_id = personal_id
GROUP BY
    E.personal_id -- group by personal_id
HAVING
    COUNT(DISTINCT S.d_id) = (
        SELECT
            COUNT(*)
        FROM
            DEPARTMENT
    );

-- Count the amount of DISTINCT Department_ID's that the EMPLOYEE
-- has for shift, if they're equal to the total number of Departments
-- display
-- #12
SELECT
    CONCAT (
        COMPANY_AFFILIATE.fname,
        ' ',
        COMPANY_AFFILIATE.lname
    ) AS Applicant_Name, -- combine fname and lname from COMPANY_AFFILIATE as Applicant_Name
    EMAIL.email_addr AS Email -- get email from EMAIL as Email
FROM
    ( -- START NESTED FROM (Table PassedCandidates)
        SELECT
            INTERVIEW.personal_id, -- get personal_id from INTERVIEW
            AVG(INTERVIEW.grade) AS Avg_Grade, -- AVG the grades as Avg_Grade
            COUNT(*) AS Passed_Rounds -- Count all as Passed_Rounds
        FROM
            INTERVIEW
        WHERE
            INTERVIEW.grade >= 60 -- only include Interviews where grade >= 60
        GROUP BY
            INTERVIEW.personal_id -- group by personal_id
        HAVING
            AVG(INTERVIEW.grade) >= 70 -- where the Average of grades >= 70
    ) -- END NESTED FROM
    AS PassedCandidates
    JOIN COMPANY_AFFILIATE ON PassedCandidates.personal_id = COMPANY_AFFILIATE.personal_id -- join COMPANY_AFFILIATE on personal_id
    JOIN EMAIL ON PassedCandidates.personal_id = EMAIL.personal_id -- join EMAIl on personal_id
LIMIT
    1;

-- Assuming only 1 selected
-- #13
SELECT
    CONCAT (
        COMPANY_AFFILIATE.fname,
        ' ',
        COMPANY_AFFILIATE.lname
    ) AS Interviewee_Name, -- concatenate fname and lname as Interviewee_Name
    PHONE_NUMBER.phone_num AS Phone_Number, -- get phone_num as Phone_Number
    EMAIL.email_addr AS Email_Address, -- get email_addr as Email_Address
    APPLICATION.job_id AS Job_ID -- get job_id as Job_ID
FROM
    ( -- START NESTED FROM
        SELECT
            personal_id, -- get personal_id
            app_id, -- get app_id
            AVG(grade) AS Avg_Grade, -- get the avg of grades as Avg_Grade
            COUNT(
                CASE
                    WHEN grade >= 60 THEN 1
                END
            ) AS Passed_Rounds -- count the entry when grade >= 60 as 1 as Passed_rounds
        FROM
            INTERVIEW
        GROUP BY
            personal_id,
            app_id -- group them by personal_id and app_id
        HAVING
            AVG(grade) >= 70
            AND Passed_Rounds >= 5 -- restrict them where the avg of grades is >= 70 and Passed_Rounds >= 5
    ) -- END NESTED FROM
    AS Selected -- Table named Selected
    JOIN APPLICATION ON Selected.app_id = APPLICATION.app_id -- Join with Selected on app_id
    JOIN COMPANY_AFFILIATE ON APPLICATION.personal_id = COMPANY_AFFILIATE.personal_id -- join COMPANY_AFFILIATE on personal_id
    LEFT JOIN PHONE_NUMBER ON COMPANY_AFFILIATE.personal_id = PHONE_NUMBER.personal_id -- left join with PHONE_NUMBER on personal_id
    LEFT JOIN EMAIL ON COMPANY_AFFILIATE.personal_id = EMAIL.personal_id;

-- left join with email on personal_id
-- #14
SELECT
    CONCAT (
        COMPANY_AFFILIATE.fname,
        ' ',
        COMPANY_AFFILIATE.lname
    ) AS Employee_Name, -- concatenate fname and lname as Employee_Name
    SALARY.emp_id AS Employee_ID, -- get emp_id from SALARY as Employee_ID
    ROUND(AVG(SALARY.amount), 2) AS Average_Monthly_Salary -- ROUND the AVG Salary to second decimal as Average_Monthly_Salary from SALARY
FROM
    SALARY
    JOIN COMPANY_AFFILIATE ON SALARY.emp_id = COMPANY_AFFILIATE.personal_id -- join COMPANY_AFFILIATE on emp_id = personal_id
GROUP BY
    SALARY.emp_id -- group by emp_id
ORDER BY
    Average_Monthly_Salary DESC -- sort in descending order
LIMIT
    1;

-- limit to top entry
-- #15
SELECT
    VENDOR.vendor_id AS Vendor_ID, -- get vendor_id as Vendor_ID from VENDOR
    VENDOR.name AS Vendor_Name -- get name as Vendor_Name from VENDOR
FROM
    VENDOR
    JOIN PART ON VENDOR.vendor_id = PART.vendor_id -- join with PART on vendor_id
WHERE
    PART.name = 'Cup'
    AND PART.weight < 4 -- where the PART name = 'Cup' and the weight < 4
ORDER BY
    PART.price ASC -- sort ascendingly
LIMIT
    1;

-- only show top entry