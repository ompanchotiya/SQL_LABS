-- PART - A

-- 1. Handle Divide by Zero Error and Print message like:
-- Error occurs that is - Divide by zero error.

BEGIN TRY
    SELECT 10 / 0;
END TRY
BEGIN CATCH
    PRINT 'Error occurs that is - Divide by zero error.';
END CATCH;


-- 2. Try to convert string to integer and handle the error using try...catch block.

BEGIN TRY
    SELECT CAST('ABC' AS INT);
END TRY
BEGIN CATCH
    PRINT 'Invalid integer value.';
END CATCH;


-- 3. Create a procedure that prints the sum of two numbers:
-- take both numbers as integer & handle exception with all error functions
-- if any one enters string value in numbers otherwise print result.

CREATE OR ALTER PROCEDURE ADD_NUM
@A INT, @B INT
AS
BEGIN
    BEGIN TRY
        PRINT 'SUM = ' + CAST(@A + @B AS VARCHAR);
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS MSG,
               ERROR_NUMBER() AS NUM,
               ERROR_SEVERITY() AS SEVERITY,
               ERROR_STATE() AS STATE;
    END CATCH
END;

EXEC ADD_NUM 10,20;


-- 4. Handle a Primary Key Violation while inserting data into STUDENT_INFO
-- table and print error message, error number, severity and state.

BEGIN TRY
    INSERT INTO STUDENT_INFO
    VALUES(1,'MAYANK');
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS MSG,
           ERROR_NUMBER() AS NUM,
           ERROR_SEVERITY() AS SEVERITY,
           ERROR_STATE() AS STATE;
END CATCH;


-- 5. Throw custom exception using stored procedure which accepts RNO as input
-- and throws error like no RNO is available in database.

CREATE OR ALTER PROCEDURE CHECK_RNO
@RNO INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM STUDENT_INFO WHERE RNO=@RNO)
        THROW 50001,'No RNO is available in database.',1;
    ELSE
        PRINT 'RNO Available';
END;

EXEC CHECK_RNO 101;


-- PART - B

-- 6. Create a stored procedure to update employee SALARY and throw custom
-- exception if salary is negative or zero (Use EMPLOYEE Table).

CREATE OR ALTER PROCEDURE UPDATE_SALARY
@EID INT, @SALARY INT
AS
BEGIN
    IF @SALARY <= 0
        THROW 50002,'Salary must be greater than zero.',1;

    UPDATE EMPLOYEE
    SET SALARY=@SALARY
    WHERE EID=@EID;
END;

EXEC UPDATE_SALARY 101,50000;


-- 7. Handle a Foreign Key Violation while inserting data into RESULT table
-- and print appropriate error message (Use RESULT Table).

BEGIN TRY
    INSERT INTO RESULT
    VALUES(9999,8.6,90);
END TRY
BEGIN CATCH
    PRINT 'Foreign Key Violation.';
    PRINT ERROR_MESSAGE();
END CATCH;


-- 8. Handle Invalid Date Format while inserting data into DEPOSIT table.

BEGIN TRY
    INSERT INTO DEPOSIT(ACTNO,ADATE,AMOUNT)
    VALUES(101,'31-99-2026',5000);
END TRY
BEGIN CATCH
    PRINT 'Invalid Date Format.';
    PRINT ERROR_MESSAGE();
END CATCH;


-- 9. Create a stored procedure that validates gender column and throws error
-- if value is other than male or female (Use EMPLOYEE Table).

CREATE OR ALTER PROCEDURE CHECK_GENDER
@EID INT, @GENDER VARCHAR(10)
AS
BEGIN
    IF LOWER(@GENDER) NOT IN('male','female')
        THROW 50003,'Gender must be Male or Female.',1;

    UPDATE EMPLOYEE
    SET GENDER=@GENDER
    WHERE EID=@EID;
END;

EXEC CHECK_GENDER 101,'Male';


-- 10. Create a stored procedure that accepts joiningyear and throws custom
-- exception if entered year is greater than current year (Use EMPLOYEE Table).

CREATE OR ALTER PROCEDURE CHECK_YEAR
@EID INT, @YEAR INT
AS
BEGIN
    IF @YEAR > YEAR(GETDATE())
        THROW 50004,'Joining year cannot be greater than current year.',1;

    UPDATE EMPLOYEE
    SET JOININGYEAR=@YEAR
    WHERE EID=@EID;
END;

EXEC CHECK_YEAR 101,2025;


-- PART - C

-- 11. Create a stored procedure to delete employee record and handle
-- exception if employee does not exist.

CREATE OR ALTER PROCEDURE DELETE_EMP
@EID INT
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM EMPLOYEE WHERE EID=@EID)
            THROW 50005,'Employee does not exist.',1;

        DELETE FROM EMPLOYEE
        WHERE EID=@EID;

        PRINT 'Employee Deleted.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

EXEC DELETE_EMP 101;


-- 12. Create a stored procedure that throws custom exception if department
-- name is NULL during insertion.

CREATE OR ALTER PROCEDURE INSERT_EMP
@EID INT, @NAME VARCHAR(50), @DEPT VARCHAR(50)
AS
BEGIN
    IF @DEPT IS NULL
        THROW 50006,'Department name cannot be NULL.',1;

    INSERT INTO EMPLOYEE(EID,FIRSTNAME,DEPARTMENT)
    VALUES(@EID,@NAME,@DEPT);
END;

EXEC INSERT_EMP 101,'MAYANK','CSE';