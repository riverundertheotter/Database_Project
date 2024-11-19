CREATE TABLE COMPANY (
  c_id INTEGER PRIMARY KEY,
  c_name TEXT NOT NULL
);
  
CREATE TABLE ADDRESS (
  address_id INTEGER PRIMARY KEY,
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
  phone_num   INTEGER PRIMARY KEY
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
  job_desc        TEXT NOT NULL,
  post_date       DATE NOT NULL,
  d_id            INTEGER NOT NULL,
  
  FOREIGN KEY (d_id) REFERENCES DEPARTMENT(dep_id)
);

CREATE TABLE APPLICATION (
  app_id          INTEGER PRIMARY KEY,
  personal_id_emp     INTEGER NOT NULL DEFAULT 0,
  personal_id_potential INTEGER NOT NULL DEFAULT 0,
  job_id          INTEGER NOT NULL,
  
  FOREIGN KEY (job_id) REFERENCES JOB_POS(job_id),
  # created two separate attributes to provide distinction between the two entities.
  # one of them will always be 0, meaning that the employee is the other personal_id
  # not sure if this is a permanent solution, what do you think?
  FOREIGN KEY (personal_id_emp) REFERENCES EMPLOYEE(personal_id),           -- FIX HERE
  FOREIGN KEY (personal_id_potential) REFERENCES POTENTIAL_EMPLOYEE(personal_id)  -- FIX HERE
);

CREATE TABLE INTERVIEW (      -- personal_id, round_num, and app_id should be primary key
  time          TIMESTAMP NOT NULL,
  personal_id   INTEGER   NOT NULL,
  grade         INTEGER   NOT NULL,
  CHECK (grade <= 100 AND grade >= 0),
  app_id        INTEGER   NOT NULL,
  round_num     INTEGER   NOT NULL,
  CHECK (round_num > 0),
  # removed this since we have the personal_id in the APPLICATION relation.
  # FOREIGN KEY (personal_id) REFERENCES APPLICATION(personal_id),
  FOREIGN KEY (app_id)      REFERENCES APPLICATION(app_id),
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
  zip             INTEGER NOT NULL,
  city            TEXT    NOT NULL,
  state           CHAR(2) NOT NULL,
  line1           TEXT    NOT NULL,
  line2           TEXT
);

CREATE TABLE PART(
  part_id         INTEGER PRIMARY KEY,
  price           INTEGER NOT NULL,
  vendor_id       INTEGER NOT NULL,
  
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