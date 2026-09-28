--EM
CREATE TABLE EMPLOYEE_UPDATE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_SALARY DECIMAL(10,2),
    NEW_SALARY DECIMAL(10,2),
    OLD_DEPARTMENT VARCHAR(50),
    NEW_DEPARTMENT VARCHAR(50),
    UPDATE_DATE DATETIME
);



CREATE TABLE EMPLOYEE_INSERT_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    FIRSTNAME VARCHAR(50),
    LASTNAME VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    SALARY DECIMAL(10,2),
    INSERT_DATE DATETIME
);



CREATE TABLE NAME_CHANGE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_FIRSTNAME VARCHAR(50),
    NEW_FIRSTNAME VARCHAR(50),
    CHANGE_DATE DATETIME
);



CREATE TABLE CITY_UPDATE_LOG
(
    LOGID INT IDENTITY(1,1) PRIMARY KEY,
    EID INT,
    OLD_CITY VARCHAR(50),
    NEW_CITY VARCHAR(50),
    UPDATE_DATE DATETIME
);
--Part � A:
--1. Create trigger for preventing removal of employees from the table.

CREATE OR ALTER TRIGGER TRG_Prevent_Delet
ON EMPLOYEE
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Employee deletion is not allowed.';
END;



--2. Create INSTEAD OF DELETE trigger to prevent deletion of employee records and store deleted data into
--EMPLOYEE_LOG table.
CREATE OR ALTER TRIGGER TRG_Delete_Log
ON EMPLOYEE
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO EMPLOYEE_LOG
    (EID, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)
    SELECT
        EID,
        FIRSTNAME + ' ' + LASTNAME,
        NULL,
        'EMPLOYEE',
        'DELETE',
        GETDATE()
    FROM DELETED;

    PRINT 'Employee deletion prevented and data stored in EMPLOYEE_LOG.';
END;

--3. Create INSTEAD OF trigger to log all operations on EMPLOYEE table (INSERT/UPDATE/DELETE) into
--EMPLOYEE_LOG table. 
CREATE OR ALTER TRIGGER TRG_Log_All_Operations
ON EMPLOYEE
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN

    -- INSERT
    IF EXISTS (SELECT * FROM INSERTED)
       AND NOT EXISTS (SELECT * FROM DELETED)
    BEGIN
        INSERT INTO EMPLOYEE_LOG
        (EID, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)
        SELECT
            EID,
            NULL,
            FIRSTNAME + ' ' + LASTNAME,
            'EMPLOYEE',
            'INSERT',
            GETDATE()
        FROM INSERTED;
    END

    -- DELETE
    IF EXISTS (SELECT * FROM DELETED)
       AND NOT EXISTS (SELECT * FROM INSERTED)
    BEGIN
        INSERT INTO EMPLOYEE_LOG
        (EID, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)
        SELECT
            EID,
            FIRSTNAME + ' ' + LASTNAME,
            NULL,
            'EMPLOYEE',
            'DELETE',
            GETDATE()
        FROM DELETED;
    END

    -- UPDATE
    IF EXISTS (SELECT * FROM INSERTED)
       AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        INSERT INTO EMPLOYEE_LOG
        (EID, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)
        SELECT
            I.EID,
            D.FIRSTNAME + ' ' + D.LASTNAME,
            I.FIRSTNAME + ' ' + I.LASTNAME,
            'EMPLOYEE',
            'UPDATE',
            GETDATE()
        FROM INSERTED I
        INNER JOIN DELETED D
            ON I.EID = D.EID;
    END

    PRINT 'Employee operation logged successfully.';
END;

--4. Create trigger to block employees from updating their JOININGYEAR and print message
--�Employees are not allowed to update their joining year�.
CREATE OR ALTER TRIGGER TRG_Prevent_Duplicate
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM EMPLOYEE E
        INNER JOIN INSERTED I
        ON E.FIRSTNAME = I.FIRSTNAME
        AND E.LASTNAME = I.LASTNAME
        AND E.CITY = I.CITY
    )
    BEGIN
        PRINT 'Duplicate employee record is not allowed.';
        RETURN;
    END

    INSERT INTO EMPLOYEE
    (EID, FIRSTNAME, LASTNAME, DEPARTMENT, SALARY, CITY, GENDER, JOININGYEAR)
    SELECT
        EID, FIRSTNAME, LASTNAME, DEPARTMENT,
        SALARY, CITY, GENDER, JOININGYEAR
    FROM INSERTED;
END;
--5. Create trigger for preventing duplicate employee records having same FIRSTNAME, LASTNAME, and CITY.
CREATE OR ALTER TRIGGER TRG_Prevent_Duplicate
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM EMPLOYEE E
        INNER JOIN INSERTED I
        ON E.FIRSTNAME = I.FIRSTNAME
        AND E.LASTNAME = I.LASTNAME
        AND E.CITY = I.CITY
    )
    BEGIN
        PRINT 'Duplicate employee record is not allowed.';
        RETURN;
    END

    INSERT INTO EMPLOYEE
    (EID, FIRSTNAME, LASTNAME, DEPARTMENT, SALARY, CITY, GENDER, JOININGYEAR)
    SELECT
        EID, FIRSTNAME, LASTNAME, DEPARTMENT,
        SALARY, CITY, GENDER, JOININGYEAR
    FROM INSERTED;
END;


--Part � B:
--6. Create INSTEAD OF INSERT trigger to prevent insertion of duplicate EID in EMPLOYEE table.
CREATE OR ALTER TRIGGER TRG_Prevent_Duplicate_EID
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM EMPLOYEE E
        INNER JOIN INSERTED I
            ON E.EID = I.EID
    )
    BEGIN
        PRINT 'Duplicate EID is not allowed.';
        RETURN;
    END

    INSERT INTO EMPLOYEE
    (EID, FIRSTNAME, LASTNAME, DEPARTMENT, SALARY, CITY, GENDER, JOININGYEAR)
    SELECT
        EID, FIRSTNAME, LASTNAME, DEPARTMENT,
        SALARY, CITY, GENDER, JOININGYEAR
    FROM INSERTED;
END;

--7. Create INSTEAD OF UPDATE trigger to maintain complete employee update history into EMPLOYEE_LOG
--table.
CREATE OR ALTER TRIGGER TRG_Employee_Update_History
ON EMPLOYEE
INSTEAD OF UPDATE
AS
BEGIN
    INSERT INTO EMPLOYEE_LOG
    (EID, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)
    SELECT
        I.EID,
        D.FIRSTNAME + ' ' + D.LASTNAME,
        I.FIRSTNAME + ' ' + I.LASTNAME,
        'EMPLOYEE',
        'UPDATE',
        GETDATE()
    FROM INSERTED I
    INNER JOIN DELETED D
        ON I.EID = D.EID;

    UPDATE E
    SET
        E.FIRSTNAME = I.FIRSTNAME,
        E.LASTNAME = I.LASTNAME,
        E.DEPARTMENT = I.DEPARTMENT,
        E.SALARY = I.SALARY,
        E.CITY = I.CITY,
        E.GENDER = I.GENDER,
        E.JOININGYEAR = I.JOININGYEAR
    FROM EMPLOYEE E
    INNER JOIN INSERTED I
        ON E.EID = I.EID;
END;

--8. Create INSTEAD OF UPDATE trigger to prevent changing employee EID once record is created.
CREATE OR ALTER TRIGGER TRG_Prevent_EID_Update
ON EMPLOYEE
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM INSERTED I
        INNER JOIN DELETED D
            ON D.EID <> I.EID
    )
    BEGIN
        PRINT 'Employee EID cannot be changed.';
        RETURN;
    END

    UPDATE E
    SET
        E.FIRSTNAME = I.FIRSTNAME,
        E.LASTNAME = I.LASTNAME,
        E.DEPARTMENT = I.DEPARTMENT,
        E.SALARY = I.SALARY,
        E.CITY = I.CITY,
        E.GENDER = I.GENDER,
        E.JOININGYEAR = I.JOININGYEAR
    FROM EMPLOYEE E
    INNER JOIN INSERTED I
        ON E.EID = I.EID;
END;

--9. Create INSTEAD OF INSERT trigger to block insertion of employees with NULL department name.
CREATE OR ALTER TRIGGER TRG_Prevent_Null_Department
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM INSERTED
        WHERE DEPARTMENT IS NULL
    )
    BEGIN
        PRINT 'Department cannot be NULL.';
        RETURN;
    END

    INSERT INTO EMPLOYEE
    (EID, FIRSTNAME, LASTNAME, DEPARTMENT, SALARY, CITY, GENDER, JOININGYEAR)
    SELECT
        EID, FIRSTNAME, LASTNAME, DEPARTMENT,
        SALARY, CITY, GENDER, JOININGYEAR
    FROM INSERTED;
END;

--10. Create INSTEAD OF UPDATE trigger to prevent updating GENDER column after employee registration.
--STUDENT_LOG (LOGID, STDID, SNAME, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)
CREATE OR ALTER TRIGGER TRG_Prevent_Gender_Update
ON EMPLOYEE
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM INSERTED I
        INNER JOIN DELETED D
            ON I.EID = D.EID
        WHERE I.GENDER <> D.GENDER
    )
    BEGIN
        PRINT 'Gender cannot be updated.';
        RETURN;
    END

    UPDATE E
    SET
        E.FIRSTNAME = I.FIRSTNAME,
        E.LASTNAME = I.LASTNAME,
        E.DEPARTMENT = I.DEPARTMENT,
        E.SALARY = I.SALARY,
        E.CITY = I.CITY,
        E.GENDER = I.GENDER,
        E.JOININGYEAR = I.JOININGYEAR
    FROM EMPLOYEE E
    INNER JOIN INSERTED I
        ON E.EID = I.EID;
END;



--Part � C:
--11. Create INSTEAD OF INSERT trigger to prevent insertion of students whose SPI is greater than 10 or less
--than 0.
CREATE OR ALTER TRIGGER TRG_Check_SPI
ON STUDENT
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM INSERTED
        WHERE SPI > 10 OR SPI < 0
    )
    BEGIN
        PRINT 'SPI must be between 0 and 10.';
        RETURN;
    END

    INSERT INTO STUDENT
    (STDID, SNAME, CITY, SPI, BRANCH)
    SELECT
        STDID, SNAME, CITY, SPI, BRANCH
    FROM INSERTED;
END;

--12. Create INSTEAD OF UPDATE trigger to block students from changing their BRANCH after admission.
CREATE OR ALTER TRIGGER TRG_Prevent_Branch_Update
ON STUDENT
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM INSERTED I
        INNER JOIN DELETED D
            ON I.STDID = D.STDID
        WHERE I.BRANCH <> D.BRANCH
    )
    BEGIN
        PRINT 'Branch cannot be changed after admission.';
        RETURN;
    END

    UPDATE S
    SET
        S.SNAME = I.SNAME,
        S.CITY = I.CITY,
        S.SPI = I.SPI,
        S.BRANCH = I.BRANCH
    FROM STUDENT S
    INNER JOIN INSERTED I
        ON S.STDID = I.STDID;
END;

--13. Create INSTEAD OF DELETE trigger to move deleted student records into STUDENT_LOG table instead of
--permanent deletion.
CREATE OR ALTER TRIGGER TRG_Student_Delete_Log
ON STUDENT
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO STUDENT_LOG
    (STDID, SNAME, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)
    SELECT
        STDID,
        SNAME,
        CAST(SPI AS VARCHAR),
        NULL,
        'STUDENT',
        'DELETE',
        GETDATE()
    FROM DELETED;

    PRINT 'Student record moved to STUDENT_LOG.';
END;

--14. Create INSTEAD OF UPDATE trigger to prevent updating student SPI.
CREATE OR ALTER TRIGGER TRG_Prevent_SPI_Update
ON STUDENT
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM INSERTED I
        INNER JOIN DELETED D
            ON I.STDID = D.STDID
        WHERE I.SPI <> D.SPI
    )
    BEGIN
        PRINT 'Student SPI cannot be updated.';
        RETURN;
    END

    UPDATE S
    SET
        S.SNAME = I.SNAME,
        S.CITY = I.CITY,
        S.SPI = I.SPI,
        S.BRANCH = I.BRANCH
    FROM STUDENT S
    INNER JOIN INSERTED I
        ON S.STDID = I.STDID;
END;

--15. Create INSTEAD OF UPDATE trigger to store student branch transfer history into STUDENT_LOG table.
CREATE OR ALTER TRIGGER TRG_Branch_Transfer_Log
ON STUDENT
INSTEAD OF UPDATE
AS
BEGIN
    INSERT INTO STUDENT_LOG
    (STDID, SNAME, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)
    SELECT
        I.STDID,
        I.SNAME,
        D.BRANCH,
        I.BRANCH,
        'BRANCH',
        'UPDATE',
        GETDATE()
    FROM INSERTED I
    INNER JOIN DELETED D
        ON I.STDID = D.STDID
    WHERE I.BRANCH <> D.BRANCH;

    UPDATE S
    SET
        S.SNAME = I.SNAME,
        S.CITY = I.CITY,
        S.SPI = I.SPI,
        S.BRANCH = I.BRANCH
    FROM STUDENT S
    INNER JOIN INSERTED I
        ON S.STDID = I.STDID;
END;