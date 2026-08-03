--From the table EMPLOYEE perform the following queries:
--Part – A:
--1. Create a view Employee_All with all columns.
CREATE VIEW EMPLOYEE_ALL
AS
SELECT * FROM EMPLOYEE
SELECT * FROM EMPLOYEE_ALL

--2. Create a view Employee_NameDeptSalary having columns FirstName, Department and Salary.
CREATE VIEW EMPLOYEE_NAMEDEPTSALARY
AS
SELECT FIRSTNAME, DEPARTMENT, SALARY FROM EMPLOYEE
SELECT * FROM EMPLOYEE_NAMEDEPTSALARY

--3. Create a view Employee_Basic having columns EID, FirstName and City.
CREATE VIEW EMPLOYEE_BASIC
AS
SELECT EID, FIRSTNAME, CITY FROM EMPLOYEE
SELECT * FROM EMPLOYEE_BASIC

--4. Create a view IT_Employees that displays IT department data only.
CREATE VIEW IT_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM EMPLOYEE
WHERE DEPARTMENT = 'IT'
--5. Create a view HR_Employees that displays HR department data only.
--6. Create a view Employee_2026 that displays employees joined in 2026 only.
--7. Create a view Patel_Employees that displays employees whose last name is PATEL.
--8. Create a view High_Salary_Emp having all columns but employees whose salary is more than 12000.
--9. Create a view that displays information of all employees whose salary is above 14000.
--10. Create a view that displays employees having salary below 10000.
--11. Create a view Server_Dept that displays Server department employees only.
--12. Insert a new record into Employee_Basic view. (111, MEET, SURAT)
--13. Update the department of DEEP from ADMIN to IT in Employee_NameDeptSalary view.
--14. Delete an employee whose EID is 107 from Employee_Basic view.
--15. Drop IT_Employees view from the database.


--Part – B:
--16. Create a view Admin_Employees that displays ADMIN department employees only.
CREATE VIEW ADMIN_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM ADMIN_EMPLOYEES
WHERE DEPARTMENT = 'ADMIN'
--17. Create a view Female_Employees that displays female employee data only.
CREATE VIEW FEMALE_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM FEMALE_EMPLOYEES
WHERE GENDER = 'FEMALE'
--18. Create a view Male_Employees that displays male employee data only.
CREATE VIEW MALE_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM MALE_EMPLOYEES
WHERE GENDER = 'MALE'
--19. Create a view Rajkot_Employees that displays employees from Rajkot city only.
CREATE VIEW RAJKOT_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM RAJKOT_EMPLOYEES
WHERE CITY = 'RAJKOT'
--20. Create a view Ahmedabad_Employees that displays employees from Ahmedabad city only.
CREATE VIEW AHMEDABAD_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM ADMIN_EMPLOYEES
WHERE CITY = 'AHMEDABAD'
--21. Create a view Salary_Between that displays employees whose salary is between 10000 and 14000.
CREATE VIEW SALARY_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM SALARY_EMPLOYEES
WHERE SALARY BETWEEN 10000 AND 14000
--22. Create a view Recent_Employees that displays employees joined after 2023.
CREATE VIEW RECENT_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM RECENT_EMPLOYEES
WHERE JOININGYEAR > 2023
--23. Create a view Old_Employees that displays employees joined before 2023.
CREATE VIEW OLD_EMPLOYEES
AS
SELECT * FROM EMPLOYEE
SELECT * FROM OLD_EMPLOYEES
WHERE JOININGYEAR < 2023
--24. Create a view Employees_Start_R that displays employees whose first name starts with R.
CREATE VIEW EMPLOYEES_START_R
AS
SELECT * FROM EMPLOYEE
SELECT * FROM EMPLOYEES_START_R
WHERE FIRSTNAME LIKE 'R%'
--25. Create a view Employees_End_A that displays employees whose first name ends with A.
CREATE VIEW EMPLOYEES_END_A
AS
SELECT * FROM EMPLOYEE
SELECT * FROM EMPLOYEES_END_A
WHERE FIRSTNAME LIKE '%A'

--Part – C:
--26. Create a view Employees_NameContains_H that displays employees whose first name contains 
CREATE VIEW EMPLOYEES_NAMECONTAINS_H
AS
SELECT * FROM EMPLOYEE
SELECT * FROM EMPLOYEES_NAMECONTAINS_H
WHERE FIRSTNAME LIKE '%H%'
--27. Create a view for the employees whose first name contains vowels.
CREATE VIEW EMPLOYEES_START_VOWEL
AS
SELECT * FROM EMPLOYEE
SELECT * FROM EMPLOYEES_START_VOWEL
WHERE FIRSTNAME LIKE '[AEIOU]%'
--28. Create a view FourLetter_Name having EID, FirstName and Department columns in which FirstName
--consists of four letters.
CREATE VIEW FOURLETTER_NAME
AS
SELECT EID, FIRSTNAME, DEPARTMENT FROM EMPLOYEE
SELECT * FROM FOURLETTER_NAME
WHERE FIRSTNAME LIKE '____'
--29. Create a view for the employees whose name starts with M and ends with N.
CREATE VIEW EMPLOYEES_START_M_ENDS_N
AS
SELECT * FROM EMPLOYEE
SELECT * FROM EMPLOYEES_START_M_ENDS_N
WHERE FIRSTNAME LIKE 'M%N'
--30. Create a view Transport_Dept that displays Transport department employees only.
CREATE VIEW TRANSPORT_DEPT
AS
SELECT * FROM EMPLOYEE
SELECT * FROM TRANSPORT_DEPT
WHERE DEPARTMENT = 'TRANSPORT'