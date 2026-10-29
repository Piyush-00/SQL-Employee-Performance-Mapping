# Employee Performance Mapping in SQL

A MySQL project that helps an HR team review employee performance, salaries, reporting lines and job-profile standards, and estimate the cost of a performance bonus.

**Tools:** MySQL

## Business question

HR needs to finalize performance reviews. Who are the high and low performers, are people in roles that match their experience, and what will a rating-based bonus cost?

## What the queries answer

| HR question | SQL technique |
|---|---|
| Which employees are low (< 2), mid (2–4) or high (> 4) performers? | Filtering with `WHERE` / `BETWEEN` |
| Who manages whom, and how many direct reports does each manager have? | Self-join on `MANAGER_ID`, `GROUP BY` |
| What is the top rating in each department, next to each employee's rating? | Window function `MAX() OVER (PARTITION BY DEPT)` |
| What are the minimum and maximum salaries for each role? | Aggregation with `GROUP BY` |
| How do employees rank by experience? | Window function `RANK()` |
| Do Data Science team members' roles match the standard for their experience? | Stored function returning CORRECT / INCORRECT |
| What will a bonus of 5% of salary × rating cost for each employee? | Calculated column |
| How does average salary vary by country and continent? | `GROUP BY` on two levels |
| Which employees earn over 6,000, by country? | View |
| Who has more than 3 years of experience? | Stored procedure |
| How can lookups by name run faster? | Index + `EXPLAIN` execution plan |
| Healthcare and Finance staff in one list | `UNION` |

## How the job-profile check works

The stored function `JOB_PROFILE(exp, role)` compares each person's years of experience with the organization's standard:

| Experience | Expected role |
|---|---|
| ≤ 2 years | Junior Data Scientist |
| 2–5 years | Associate Data Scientist |
| 5–10 years | Senior Data Scientist |
| 10–12 years | Lead Data Scientist |
| 12–16 years | Manager |

Anyone who doesn't fit is flagged INCORRECT so HR can review their title or level.

## Business value

- **Fair reviews:** performance bands and department maximums give managers a consistent reference point.
- **Budgeting:** the bonus query shows the total payout before it is approved.
- **Role compliance:** the job-profile check flags people whose title doesn't match their experience, for promotion or correction.

## Files

| File | Contents |
|---|---|
| `Employee-Performance_mapping.sql` | All queries, view, stored procedure, stored function and index |
| `Air-Cargo_Analysis.sql` | Queries for a separate project: see [SQL-Air-Cargo-Analysis](https://github.com/Piyush-00/SQL-Air-Cargo-Analysis) |

The source data is not included in this repo.

<details>
<summary>Data dictionary</summary>

**emp_record_table:** all employees

| Column | Description |
|---|---|
| EMP_ID | Employee ID |
| FIRST_NAME, LAST_NAME | Employee name |
| GENDER | Gender |
| ROLE | Job title |
| DEPT | Department |
| EXP | Years of experience |
| COUNTRY, CONTINENT | Where the employee lives |
| SALARY | Salary |
| EMP_RATING | Performance rating |
| MANAGER_ID | The employee's manager |
| PROJ_ID | Current or past project |

**Proj_table:** projects

| Column | Description |
|---|---|
| PROJECT_ID, PROJ_Name | Project ID and name |
| DOMAIN | Field of the project |
| START_DATE, CLOSURE_DATE | Project start and (planned) end |
| DEV_QTR | Scheduled quarter |
| STATUS | Current status |

**Data_science_team:** employees in the Data Science team, with the same personal and role columns as the employee table (ID, name, gender, role, department, experience, country, continent).

</details>
