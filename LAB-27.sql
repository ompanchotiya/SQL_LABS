-- From the table EMPLOYEE perform the following queries:
-- PART - A


-- 1. Create a cursor Employee_Cursor to fetch all rows from EMPLOYEE table
-- and display them.

DECLARE Employee_Cursor CURSOR FOR
SELECT * FROM EMPLOYEE;

OPEN Employee_Cursor;

FETCH NEXT FROM Employee_Cursor;

WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM Employee_Cursor;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 2. Create a cursor to display all female employees from EMPLOYEE table.

DECLARE Employee_Cursor CURSOR FOR
SELECT * FROM EMPLOYEE
WHERE GENDER = 'FEMALE';

OPEN Employee_Cursor;

FETCH NEXT FROM Employee_Cursor;

WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM Employee_Cursor;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 3. Create a cursor Employee_Cursor_Fetch to fetch records in form of
-- EID_FirstName_LastName.
-- Example: 101_Hetvi_Patel

DECLARE Employee_Cursor_Fetch CURSOR FOR
SELECT CAST(EID AS VARCHAR) + '_' + ENAME
FROM EMPLOYEE;

OPEN Employee_Cursor_Fetch;

DECLARE @NAME VARCHAR(100);

FETCH NEXT FROM Employee_Cursor_Fetch INTO @NAME;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @NAME;
    FETCH NEXT FROM Employee_Cursor_Fetch INTO @NAME;
END;

CLOSE Employee_Cursor_Fetch;
DEALLOCATE Employee_Cursor_Fetch;


-- 4. Create a cursor to find and display all employees with Salary
-- greater than 12000.

DECLARE Employee_Cursor CURSOR FOR
SELECT EID, ENAME, SALARY
FROM EMPLOYEE
WHERE SALARY > 12000;

OPEN Employee_Cursor;

DECLARE @EID INT, @ENAME VARCHAR(50), @SALARY INT;

FETCH NEXT FROM Employee_Cursor
INTO @EID, @ENAME, @SALARY;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT CAST(@EID AS VARCHAR) + ' ' + @ENAME + ' ' +
          CAST(@SALARY AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @EID, @ENAME, @SALARY;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 5. Create a cursor to display all employees who joined in year 2022 or later.

DECLARE Employee_Cursor CURSOR FOR
SELECT EID, ENAME, JOININGYEAR
FROM EMPLOYEE
WHERE JOININGYEAR >= 2022;

OPEN Employee_Cursor;

DECLARE @EID INT, @ENAME VARCHAR(50), @YEAR INT;

FETCH NEXT FROM Employee_Cursor
INTO @EID, @ENAME, @YEAR;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @ENAME + ' ' + CAST(@YEAR AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @EID, @ENAME, @YEAR;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 6. Create a cursor to fetch Employee Name with Department Name.
-- Example: Raj Mehta works in IT Department

DECLARE Employee_Cursor CURSOR FOR
SELECT ENAME, DEPARTMENT
FROM EMPLOYEE;

OPEN Employee_Cursor;

DECLARE @ENAME VARCHAR(50), @DEPT VARCHAR(50);

FETCH NEXT FROM Employee_Cursor
INTO @ENAME, @DEPT;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @ENAME + ' works in ' + @DEPT + ' Department';

    FETCH NEXT FROM Employee_Cursor
    INTO @ENAME, @DEPT;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 7. Create a cursor to update CITY as 'AHMEDABAD'
-- for employees whose CITY value is NULL.

DECLARE Employee_Cursor CURSOR FOR
SELECT EID
FROM EMPLOYEE
WHERE CITY IS NULL;

OPEN Employee_Cursor;

DECLARE @EID INT;

FETCH NEXT FROM Employee_Cursor INTO @EID;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE EMPLOYEE
    SET CITY = 'AHMEDABAD'
    WHERE EID = @EID;

    FETCH NEXT FROM Employee_Cursor INTO @EID;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 8. Create a cursor to display Employee Name with City Name.
-- Example: Deep Patel lives in Rajkot

DECLARE Employee_Cursor CURSOR FOR
SELECT ENAME, CITY
FROM EMPLOYEE;

OPEN Employee_Cursor;

DECLARE @ENAME VARCHAR(50), @CITY VARCHAR(50);

FETCH NEXT FROM Employee_Cursor
INTO @ENAME, @CITY;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @ENAME + ' lives in ' + @CITY;

    FETCH NEXT FROM Employee_Cursor
    INTO @ENAME, @CITY;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 9. Create a cursor to delete employees whose Salary is less than 5000.

DECLARE Employee_Cursor CURSOR FOR
SELECT EID
FROM EMPLOYEE
WHERE SALARY < 5000;

OPEN Employee_Cursor;

DECLARE @EID INT;

FETCH NEXT FROM Employee_Cursor INTO @EID;

WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM EMPLOYEE
    WHERE EID = @EID;

    FETCH NEXT FROM Employee_Cursor INTO @EID;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 10. Create a cursor to display employees department-wise.

DECLARE Employee_Cursor CURSOR FOR
SELECT DEPARTMENT, ENAME
FROM EMPLOYEE
ORDER BY DEPARTMENT;

OPEN Employee_Cursor;

DECLARE @DEPT VARCHAR(50), @ENAME VARCHAR(50);

FETCH NEXT FROM Employee_Cursor
INTO @DEPT, @ENAME;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @DEPT + ' - ' + @ENAME;

    FETCH NEXT FROM Employee_Cursor
    INTO @DEPT, @ENAME;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- PART - B


-- 11. Create a cursor to count total employees from each department.

DECLARE Employee_Cursor CURSOR FOR
SELECT DEPARTMENT, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPARTMENT;

OPEN Employee_Cursor;

DECLARE @DEPT VARCHAR(50), @COUNT INT;

FETCH NEXT FROM Employee_Cursor
INTO @DEPT, @COUNT;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @DEPT + ' Department = ' + CAST(@COUNT AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @DEPT, @COUNT;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 12. Create a cursor to display employees whose CITY starts with letter 'R'.

DECLARE Employee_Cursor CURSOR FOR
SELECT ENAME, CITY
FROM EMPLOYEE
WHERE CITY LIKE 'R%';

OPEN Employee_Cursor;

DECLARE @ENAME VARCHAR(50), @CITY VARCHAR(50);

FETCH NEXT FROM Employee_Cursor
INTO @ENAME, @CITY;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @ENAME + ' - ' + @CITY;

    FETCH NEXT FROM Employee_Cursor
    INTO @ENAME, @CITY;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 13. Create a cursor to display top 3 highest salary employees
-- from EMPLOYEE table.

DECLARE Employee_Cursor CURSOR FOR
SELECT TOP 3 ENAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

OPEN Employee_Cursor;

DECLARE @ENAME VARCHAR(50), @SALARY INT;

FETCH NEXT FROM Employee_Cursor
INTO @ENAME, @SALARY;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @ENAME + ' - ' + CAST(@SALARY AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @ENAME, @SALARY;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 14. Create a cursor to calculate total salary department-wise.
-- Example: IT Department total salary = 33000

DECLARE Employee_Cursor CURSOR FOR
SELECT DEPARTMENT, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPARTMENT;

OPEN Employee_Cursor;

DECLARE @DEPT VARCHAR(50), @TOTAL INT;

FETCH NEXT FROM Employee_Cursor
INTO @DEPT, @TOTAL;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @DEPT + ' Department total salary = ' +
          CAST(@TOTAL AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @DEPT, @TOTAL;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 15. Create a cursor to calculate average salary city-wise.

DECLARE Employee_Cursor CURSOR FOR
SELECT CITY, AVG(SALARY)
FROM EMPLOYEE
GROUP BY CITY;

OPEN Employee_Cursor;

DECLARE @CITY VARCHAR(50);
DECLARE @AVG FLOAT;

FETCH NEXT FROM Employee_Cursor
INTO @CITY, @AVG;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @CITY + ' Average Salary = ' +
          CAST(@AVG AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @CITY, @AVG;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- PART - C


-- 16. Create a cursor to display employee experience using JOININGYEAR.
-- Example: Raj Mehta has experience = 4 years

DECLARE Employee_Cursor CURSOR FOR
SELECT ENAME, JOININGYEAR
FROM EMPLOYEE;

OPEN Employee_Cursor;

DECLARE @ENAME VARCHAR(50), @YEAR INT;

FETCH NEXT FROM Employee_Cursor
INTO @ENAME, @YEAR;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @ENAME + ' has experience = ' +
          CAST(YEAR(GETDATE()) - @YEAR AS VARCHAR) + ' years';

    FETCH NEXT FROM Employee_Cursor
    INTO @ENAME, @YEAR;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 17. Create a cursor to display employee full name with annual salary.
-- Example: Hetvi Patel annual salary = 144000

DECLARE Employee_Cursor CURSOR FOR
SELECT ENAME, SALARY
FROM EMPLOYEE;

OPEN Employee_Cursor;

DECLARE @ENAME VARCHAR(50), @SALARY INT;

FETCH NEXT FROM Employee_Cursor
INTO @ENAME, @SALARY;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @ENAME + ' annual salary = ' +
          CAST(@SALARY * 12 AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @ENAME, @SALARY;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 18. Create a cursor to calculate total male and female employees separately.

DECLARE Employee_Cursor CURSOR FOR
SELECT GENDER, COUNT(*)
FROM EMPLOYEE
GROUP BY GENDER;

OPEN Employee_Cursor;

DECLARE @GENDER VARCHAR(10), @COUNT INT;

FETCH NEXT FROM Employee_Cursor
INTO @GENDER, @COUNT;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @GENDER + ' Employees = ' + CAST(@COUNT AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @GENDER, @COUNT;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 19. Create a cursor to display employees whose salary is greater
-- than department average salary.

DECLARE Employee_Cursor CURSOR FOR
SELECT EID, ENAME, SALARY
FROM EMPLOYEE E
WHERE SALARY >
(
    SELECT AVG(SALARY)
    FROM EMPLOYEE
    WHERE DEPARTMENT = E.DEPARTMENT
);

OPEN Employee_Cursor;

DECLARE @EID INT, @ENAME VARCHAR(50), @SALARY INT;

FETCH NEXT FROM Employee_Cursor
INTO @EID, @ENAME, @SALARY;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT CAST(@EID AS VARCHAR) + ' ' +
          @ENAME + ' ' + CAST(@SALARY AS VARCHAR);

    FETCH NEXT FROM Employee_Cursor
    INTO @EID, @ENAME, @SALARY;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;


-- 20. Create a cursor to transfer all employees from ADMIN department
-- to HR department.

DECLARE Employee_Cursor CURSOR FOR
SELECT EID
FROM EMPLOYEE
WHERE DEPARTMENT = 'ADMIN';

OPEN Employee_Cursor;

DECLARE @EID INT;

FETCH NEXT FROM Employee_Cursor INTO @EID;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE EMPLOYEE
    SET DEPARTMENT = 'HR'
    WHERE EID = @EID;

    FETCH NEXT FROM Employee_Cursor INTO @EID;
END;

CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;