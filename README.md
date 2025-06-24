# SQL-Employee-Performance-Mapping

To facilitate a better understanding, managers have provided ratings for each employee, which will help the HR department to finalise the employee performance mapping. As a DBA, you should find the maximum salary of the employees and ensure that all jobs meet the organisation's profile standard. You also need to calculate bonuses to see extra costs for expenses. This will improve the organisation's overall performance by ensuring that all required employees receive training.

## Input Dataset

### emp_record_table: It contains information about all the employees.
● EMP_ID – ID of the employee
● FIRST_NAME – First name of the employee
● LAST_NAME – Last name of the employee
● GENDER – Gender of the employee
● ROLE – Post of the employee
● DEPT – Field of the employee
● EXP – The employee’s years of experience
● COUNTRY – The employee’s current country of residence
● CONTINENT – The employee’s continent of residence
● SALARY – Salary of the employee
● EMP_RATING – Performance rating of the employee
● MANAGER_ID – The manager mapped to the employee
● PROJ_ID – The project on which the employee is working or has worked on

### Proj_table: It contains information about the projects.
● PROJECT_ID – ID for the project
● PROJ_Name – Name of the project
● DOMAIN – Field of the project
● START_DATE – Day the project began
● CLOSURE_DATE – Day the project was or will be completed
● DEV_QTR – Quarter in which the project was scheduled
● STATUS – Status of the project currently

### Data_science_team: It contains information about all the employees in the Data Science team.
● EMP_ID – ID of the employee
● FIRST_NAME – First name of the employee
● LAST_NAME – Last name of the employee
● GENDER – Gender of the employee
● ROLE – Post of the employee
● DEPT – Field of the employee
● EXP – Years of experience the employee has
● COUNTRY – Country in which the employee is presently living
● CONTINENT – Continent in which the country is
