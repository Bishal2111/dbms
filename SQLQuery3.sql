create database db_employee;
CREATE TABLE
    tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );
	

CREATE TABLE
    tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
		FOREIGN KEY (company_name) REFERENCES tbl_Company(company_name),
        salary DECIMAL(10, 2)
    );
	drop table tbl_Works;

CREATE TABLE
    tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
		
    );
	select *from tbl_Company;
	
CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ), (
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    );

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );

INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );

INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'Small Bank Corporation',
        77000.00
    );

INSERT INTO
    tbl_Company (company_name, city)
VALUES (
        'Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );

INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES 
    ('Mark Thompson', 'Emily Williams'),
    --('John Smith', 'Jane Doe'),
    ('Alice Williams', 'Emily Williams'),
    ('Samantha Smith', 'Sara Davis'),
    ('Patrick', 'Jane Doe'); 




select c.company_name ,count(w.employee_name) as emnum
 from tbl_Company c,tbl_Works w
  where c.company_name=w.company_name
 group by c.company_name;

SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;
SELECT * FROM tbl_Company;


SELECT * FROM tbl_Employee,tbl_Works,tbl_Manages,tbl_Company;


-- Update the value of salary to 1000 where employee name= John Smith and company_name = First Bank Corporation
UPDATE tbl_Works
SET salary = '1000'
WHERE
    employee_name = 'John Smith'
AND company_name = 'First Bank Corporation';


--2 (a) Find the names of all employees who work for First Bank Corporation.
select employee_name
from tbl_Works
where company_name='First Bank Corporation';


--(b) Find the names and cities of residence of all employees who work for First Bank Corporation.

select tbl_Employee.employee_name,city
from  tbl_Works,tbl_Employee
where company_name='First Bank Corporation'
and  tbl_Employee.employee_name = tbl_Works.employee_name;

--(c) Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000.
select tbl_Employee.employee_name,street,city
from  tbl_Works,tbl_Employee
where (company_name='First Bank Corporation' AND salary > 10000)
and  tbl_Employee.employee_name = tbl_Works.employee_name ;

--(d) Find all employees in the database who live in the same cities as the companies for which they work.
select employee_name
from  tbl_Employee,tbl_Company
where employee_name IN ( select employee_name 
from tbl_Works 
where (tbl_Employee.city = tbl_Company.city and tbl_Works.company_name = tbl_Company.company_name)
);

--(e) Find all employees in the database who live in the same cities and on the same streets as do their managers.
select employee_name from tbl_Employee, tbl_Company,tbl_Manages
where employee_name in( select employee_name from tbl_Employee 
where

--(f) Find all employees in the database who do not work for First Bank Corporation.
select tbl_Employee.employee_name,company_name
from  tbl_Works,tbl_Employee
where company_name!='First Bank Corporation'
and  tbl_Employee.employee_name = tbl_Works.employee_name;

--(g) Find all employees in the database who earn more than each employee of Small Bank Corporation.
SELECT tbl_Works.employee_name, tbl_Works.salary
FROM tbl_Works 
WHERE salary > (
    SELECT MAX(salary)
    FROM tbl_Works 
    JOIN tbl_Company  ON tbl_Company.company_name = tbl_works.company_name
    WHERE tbl_Company.company_name = 'Small Bank Corporation'
);

--(h) Assume that the companies may be located in several cities. Find all companies located in every city in which Small Bank Corporation is located.
select company_name,city
from  tbl_Company
where city in (select city from tbl_company where company_name ='First Bank Corporation');

--(i) Find all employees who earn more than the average salary of all employees of their company.

--(j) Find the company that has the most employees.
SELECT company_name,COUNT(employee_name) AS NOE
from tbl_Works
group by company_name
HAVING COUNT(employee_name) = (
  SELECT MAX(emp_count)
  FROM (
    SELECT COUNT(employee_name) AS emp_count
    FROM tbl_Works
    GROUP BY company_name
  )AS COUNTS
  );

--(k) Find the company that has the smallest payroll.
--(l) Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.
