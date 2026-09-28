--EMPLOYEE_LOG (LOGID, EID, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE)

--From the table EMPLOYEE perform the following queries:

--Part – A:
select * from EMPLOYEE
--1. Create trigger for printing message after employee record insertion.
CREATE TRIGGER TR_EMPLOYEE_INSERT
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    PRINT 'Employee record inserted successfully.';
END;

insert into employee
values (101,'mayank','pathar','admin',99000,'jamnagar','male',2000)
--2. Create trigger for printing message after employee record update.
CREATE TRIGGER TR_EMPLOYEE_UPDATE
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    PRINT 'Employee record updated successfully.';
END;

update EMPLOYEE
set SALARY=99999
where FIRSTNAME='mayank'

--3. Create trigger for printing message after employee record deletion.
CREATE TRIGGER TR_EMPLOYEE_DELETE
ON EMPLOYEE
AFTER DELETE
AS
BEGIN
    PRINT 'Employee record deleted successfully.';
END;
delete from EMPLOYEE
where LASTNAME='pathar'

--4. Create trigger for printing message after employee salary increment.
CREATE or alter TRIGGER TR_SALARY_INCREMENT
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(SALARY)
    BEGIN
        IF EXISTS
        (
            SELECT 1
            FROM inserted I
            INNER JOIN deleted D ON I.EID = D.EID
            WHERE I.SALARY > D.SALARY
        )
        BEGIN
            PRINT 'Employee salary incremented successfully.';
        END
    END
END;
update EMPLOYEE
set SALARY=22000
where EID=101

--5. Create trigger for automatically converting CITY names into uppercase during insertion.
CREATE TRIGGER TR_CITY_UPPERCASE
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET E.CITY = UPPER(I.CITY)
    FROM EMPLOYEE E
    INNER JOIN inserted I
        ON E.EID = I.EID;
END;
insert into employee
values (101,'mayank','pathar','admin',99000,'jamnagar','male',2000)

--Part – B:

--6. Create trigger for updating employee city and printing old city and new city name.
CREATE TRIGGER TR_CITY_UPDATE
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CITY)
    BEGIN
        SELECT 
            D.EID,
            D.CITY AS OLD_CITY,
            I.CITY AS NEW_CITY
        FROM deleted D
        INNER JOIN inserted I ON D.EID = I.EID;
    END
END;

update EMPLOYEE
set CITY='rajkot'
where FIRSTNAME='mayank'


--7. Create trigger for automatically setting CITY as 'RAJKOT' if no city value is entered during employee
--insertion.
CREATE TRIGGER TR_DEFAULT_CITY
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET CITY = 'RAJKOT'
    FROM EMPLOYEE E
    INNER JOIN inserted I ON E.EID = I.EID
    WHERE I.CITY IS NULL OR I.CITY = '';
END;

insert into employee
values (101,'mayank','pathar','admin',99000,NULL,'male',2000)
select * from EMPLOYEE

--8. Create trigger for automatically adding current year in JOININGYEAR if no value is entered.
CREATE TRIGGER TR_DEFAULT_JOININGYEAR
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET JOININGYEAR = YEAR(GETDATE())
    FROM EMPLOYEE E
    INNER JOIN inserted I ON E.EID = I.EID
    WHERE I.JOININGYEAR IS NULL;
END;

insert into employee
values (101,'mayank','pathar','admin',99000,'jamnagar','male',NULL)



--9. Create trigger for printing employee full name after new employee insertion.
CREATE TRIGGER TR_PRINT_FULLNAME
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    SELECT 
        FIRSTNAME + ' ' + LASTNAME AS FULLNAME
    FROM inserted;
END;
insert into employee
values (101,'mayank','pathar','admin',99000,'jamnagar','male',NULL)

--10. Create trigger for automatically assigning department as ‘GENERAL’ if DEPARTMENT value is NULL.
CREATE TRIGGER TR_DEFAULT_DEPARTMENT
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    UPDATE E
    SET DEPARTMENT = 'GENERAL'
    FROM EMPLOYEE E
    INNER JOIN inserted I ON E.EID = I.EID
    WHERE I.DEPARTMENT IS NULL;
END;

insert into employee
values (101,'mayank','pathar',NULL,99000,'jamnagar','male',2020)

--Part – C:

--11. Create trigger for storing updated employee details such as EID, old salary, new salary, old department,
--new department, and update date into EMPLOYEE_UPDATE_LOG table.

CREATE TABLE EMPLOYEE_UPDATE_LOG
(
    LOGID INT IDENTITY(1,1),
    EID INT,
    OLDSALARY INT,
    NEWSALARY INT,
    OLDDEPARTMENT VARCHAR(50),
    NEWDEPARTMENT VARCHAR(50),
    UPDATEDATE DATETIME
);

CREATE TRIGGER TR_EMPLOYEE_UPDATE_LOG
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    INSERT INTO EMPLOYEE_UPDATE_LOG
    SELECT D.EID, D.SALARY, I.SALARY,
           D.DEPARTMENT, I.DEPARTMENT, GETDATE()
    FROM deleted D
    INNER JOIN inserted I ON D.EID = I.EID;
END;


--12. Create trigger for storing newly inserted employee details with insertion date into
--EMPLOYEE_INSERT_LOG table.

CREATE TABLE EMPLOYEE_INSERT_LOG
(
    LOGID INT IDENTITY(1,1),
    EID INT,
    FIRSTNAME VARCHAR(50),
    LASTNAME VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    SALARY INT,
    CITY VARCHAR(50),
    GENDER VARCHAR(20),
    JOININGYEAR INT,
    INSERTDATE DATETIME
);

CREATE TRIGGER TR_EMPLOYEE_INSERT_LOG
ON EMPLOYEE
AFTER INSERT
AS
BEGIN
    INSERT INTO EMPLOYEE_INSERT_LOG
    SELECT EID, FIRSTNAME, LASTNAME, DEPARTMENT,
           SALARY, CITY, GENDER, JOININGYEAR, GETDATE()
    FROM inserted;
END;
--13. Create trigger for storing old and new FIRSTNAME values after employee name update into
--NAME_CHANGE_LOG table.
CREATE TABLE NAME_CHANGE_LOG
(
    LOGID INT IDENTITY(1,1),
    EID INT,
    OLDFIRSTNAME VARCHAR(50),
    NEWFIRSTNAME VARCHAR(50),
    CHANGEDATE DATETIME
);

CREATE TRIGGER TR_NAME_CHANGE
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(FIRSTNAME)
    BEGIN
        INSERT INTO NAME_CHANGE_LOG
        SELECT D.EID, D.FIRSTNAME, I.FIRSTNAME, GETDATE()
        FROM deleted D
        INNER JOIN inserted I ON D.EID = I.EID
        WHERE D.FIRSTNAME <> I.FIRSTNAME;
    END
END;

--14. Create trigger for storing old city and new city details into CITY_UPDATE_LOG table after city update.
CREATE TABLE CITY_UPDATE_LOG
(
    LOGID INT IDENTITY(1,1),
    EID INT,
    OLDCITY VARCHAR(50),
    NEWCITY VARCHAR(50),
    CHANGEDATE DATETIME
);

CREATE TRIGGER TR_CITY_UPDATE_LOG
ON EMPLOYEE
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CITY)
    BEGIN
        INSERT INTO CITY_UPDATE_LOG
        SELECT D.EID, D.CITY, I.CITY, GETDATE()
        FROM deleted D
        INNER JOIN inserted I ON D.EID = I.EID
        WHERE ISNULL(D.CITY,'') <> ISNULL(I.CITY,'');
    END
END;

--15. Implement INSTEAD OF INSERT trigger on EMPLOYEE table to automatically remove extra spaces from
--FIRSTNAME and LASTNAME before insertion.
CREATE TRIGGER TR_EMPLOYEE_SPACE
ON EMPLOYEE
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO EMPLOYEE
    (
        EID, FIRSTNAME, LASTNAME, DEPARTMENT,
        SALARY, CITY, GENDER, JOININGYEAR
    )
    SELECT
        EID,
        LTRIM(RTRIM(FIRSTNAME)),
        LTRIM(RTRIM(LASTNAME)),
        DEPARTMENT,
        SALARY,
        CITY,
        GENDER,
        JOININGYEAR
    FROM inserted;
END;



INSERT INTO EMPLOYEE
VALUES
(101,'MAYANK','PATHAR','ADMIN',99000,'JAMNAGAR','MALE',2000);

SELECT * FROM EMPLOYEE;
SELECT * FROM EMPLOYEE_UPDATE_LOG;
SELECT * FROM EMPLOYEE_INSERT_LOG;
SELECT * FROM NAME_CHANGE_LOG;
SELECT * FROM CITY_UPDATE_LOG;