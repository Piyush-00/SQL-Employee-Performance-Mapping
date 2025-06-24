use employee;

select * from data_team;

Select * from emp_record;

Select * from project;

-- WriteaquerytofetchEMP_ID,FIRST_NAME,LAST_NAME,GENDER,and DEPARTMENT from the employee record table, and make a list of employees and details of their department. --

Select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_record;

-- WriteaquerytofetchEMP_ID,FIRST_NAME,LAST_NAME,GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is:less than two, greater than four, between two and four --

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from emp_record
WHERE EMP_RATING < '2';

Select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from emp_record
WHERE EMP_RATING > '4';

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING from emp_record
WHERE EMP_RATING BETWEEN 2 AND 4;

-- WriteaquerytoconcatenatetheFIRST_NAMEandtheLAST_NAMEof employees in the Finance department from the employee table and then give the resultant column alias as NAME. --

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME FROM emp_record
where DEPT = 'FINANCE';

-- Writeaquerytolistonlythoseemployeeswhohavesomeonereportingto them. Also, show the number of reporters (including the President). --

select m.EMP_ID, m.FIRST_NAME, m.LAST_NAME, count(e.EMP_ID) as EMP_REPORT from emp_record as m
inner join emp_record as e
on m.EMP_ID = e.MANAGER_ID
and e.EMP_ID != e.MANAGER_ID
where m.ROLE in("MANAGER","PRESIDENT","CEO")
group by m.EMP_ID, m.FIRST_NAME, m.LAST_NAME
order by m.EMP_ID;

-- Writeaquerytolistdownalltheemployeesfromthehealthcareandfinance departments using union. Take data from the employee record table. --

select EMP_ID, FIRST_NAME, LAST_NAME, DEPT FROM emp_record
where DEPT = 'HEALTHCARE'
UNION
select EMP_ID, FIRST_NAME, LAST_NAME, DEPT FROM emp_record
where DEPT = 'FINANCE';

-- WriteaquerytolistdownemployeedetailssuchasEMP_ID,FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department. --

select EMP_ID, FIRST_NAME, LAST_NAME, DEPT, EMP_RATING, ROLE, MAX(EMP_RATING) 
OVER( PARTITION BY DEPT) AS MAX_RATING FROM emp_record;

-- Writeaquerytocalculatetheminimumandthemaximumsalaryofthe employees in each role. Take data from the employee record table. --

SELECT ROLE, MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY FROM emp_record
group By Role;

-- Write a query to assign ranks to each employee based on their experience. Take data from the employee record table. --

SELECT FIRST_NAME, LAST_NAME, EXP, RANK()OVER(ORDER BY EXP DESC) FROM emp_record;

-- Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table. --

create view emp_countryy as
select FIRST_NAME, LAST_NAME, COUNTRY FROM emp_record
where SALARY > 6000;

SELECT * FROM emp_countryy;

--  Write a nested query to find employees with experience of more than ten years. Take data from the employee record table. --

select FIRST_NAME, LAST_NAME FROM emp_record
where exp in (
select exp from emp_record
where exp>10);

--  Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table. --

delimiter //
create procedure 3_year()
begin
select * from emp_record
where exp>3;
end //
delimiter ;
call 3_year;

-- Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard. --

delimiter //
drop function if exists employee.JOB_PROFILE;
create function employee.JOB_PROFILE(exp int, role varchar(50))
returns varchar (50) deterministic
begin
	declare JOB_PROFILE varchar (20);
	if (exp <= 2 and role = 'JUNIOR DATA SCIENTIST')
	THEN SET JOB_PROFILE = "CORRECT";
	ELSEIF(EXP>2 AND EXP<=5 AND ROLE = 'ASSOCIATE DAT SCIENTIST')
	THEN SET JOB_PROFILE = "CORRECT";
	ELSEIF (EXP>5 AND EXP<=10 AND ROLE="SENIOR DATA SCIENTIST")
	THEN SET JOB_PROFILE = "CORRECT";
	ELSEIF (EXP>10 AND EXP<=12 AND ROLE="LEAD DATA SCIENTIST")
	THEN SET JOB_PROFILE="CORRECT";
	ELSEIF (EXP>12 AND EXP<=16 AND ROLE="MANAGER")
	THEN SET JOB_PROFILE="CORRECT";
	ELSE SET JOB_PROFILE = "INCORRECT";
	END IF;
	RETURN JOB_PROFILE;
END //
DELIMITER ;
SELECT FIRST_NAME, LAST_NAME, EXP, ROLE, JOB_PROFILE(exp, role) as check_profile from employee.emp_record;

-- Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan. --

create index inddde on emp_record(ROLE(20));
EXPLAIN SELECT * FROM emp_record
WHERE FIRST_NAME = 'Eric';

-- Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating). --

select FIRST_NAME, LAST_NAME, SALARY, EMP_RATING, ((SALARY*5/100)*EMP_RATING) AS BONUS FROM emp_record;

--  Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table. --

select COUNTRY, CONTINENT, AVG(SALARY) AS SALARY_DIST FROM emp_record
group by COUNTRY, CONTINENT
ORDER BY CONTINENT;