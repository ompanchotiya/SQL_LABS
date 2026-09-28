--EMPLOYEE_LOG (LOGID, EID, OLDVALUE, NEWVALUE, FIELDNAME, OPERATIONTYPE, LOGDATE) 
--From the table EMPLOYEE perform the following queries:  
--Part – A: 
SELECT * FROM EMPLOYEE
--1. Create trigger for printing message after employee record insertion.
CREATE TRIGGER TR_INSERT_MESSAGE
ON EMPLOYEE

AFTER INSERT
AS
BEGIN
     PRINT('YOUR RECORD INSERTED SUCCESFULLY');
END;

INSERT INTO EMPLOYEE
VALUES
(101,'OM','PATEL','ADMIN',90000,'','MALE',2025)
--2. Create trigger for printing message after employee record update.
CREATE TRIGGER TR_UPDATE_MESSAGE
ON EMPLOYEE

AFTER UPDATE
AS
BEGIN
     PRINT('YOUR RECORD UPDATED SUCCESFULLY');
END;

UPDATE EMPLOYEE
SET SALARY = '90000'
WHERE FIRSTNAME = 'OM'
--3. Create trigger for printing message after employee record deletion.
CREATE TRIGGER TR_DELETE_MESSAGE
ON EMPLOYEE

AFTER DELETE
AS
BEGIN
     PRINT('YOUR RECORD DELETED SUCCESFULLY');
END;

DELETE FROM EMPLOYEE
WHERE FIRSTNAME = 'OM'
--4. Create trigger for printing message after employee salary increment. 
CREATE OR ALTER TRIGGER TR_INCREMENT_MESSAGE
ON EMPLOYEE

AFTER UPDATE
AS
BEGIN
     IF UPDATE(SALARY)
     BEGIN
     IF EXISTS(
         SELECT *
             FROM INSERTED I JOIN DELETED D
             ON I.EID = D.EID
             WHERE(I.SALARY > D.SALARY)
         )
         BEGIN
             PRINT('YOUR SALARY INCREMENTED SUCCESFULLY');
         END;
     END;
END;

UPDATE EMPLOYEE
SET SALARY = 16000
WHERE EID = 101
--5. Create trigger for automatically converting CITY names into uppercase during insertion.
CREATE OR ALTER TRIGGER TR_CONVER_UPPERCASE
ON EMPLOYEE

AFTER INSERT,UPDATE
AS
BEGIN
     UPDATE E
     SET CITY = UPPER(E.CITY)
     FROM EMPLOYEE E
     JOIN INSERTED I
     ON E.EID=I.EID
     
END;

INSERT INTO EMPLOYEE
VALUES
(11,'OM','PATEL','ADMIN',99999,'morbi','MALE',2025)


--Part – B: 
--6. Create trigger for updating employee city and printing old city and new city name. 
CREATE OR ALTER TRIGGER TR_OLD_NEW_CITY
ON EMPLOYEE

AFTER UPDATE
AS
BEGIN
     IF UPDATE(CITY)
     BEGIN
          SELECT I.CITY AS NEW_CITY, D.CITY AS OLD_CITY
          FROM INSERTED I JOIN DELETED D
          ON I.EID = D.EID
     END;
END;

UPDATE EMPLOYEE
SET CITY = 'RAJKOT'
WHERE EID = 101
--7. Create trigger for automatically setting CITY as 'RAJKOT' if no city value is entered during employee 
--insertion.
CREATE OR ALTER TRIGGER TR_CITY_DEFAULT_RAJKOT
ON EMPLOYEE

AFTER INSERT
AS
BEGIN
      UPDATE E
      SET CITY = 'RAJKOT'
      FROM EMPLOYEE E JOIN INSERTED I
      ON E.EID = I.EID
      WHERE I.CITY IS NULL OR I.CITY = ''
END;

INSERT INTO EMPLOYEE
VALUES
(101,'OM','PATEL','ADMIN',90000,'','MALE',2025)
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

INSERT INTO EMPLOYEE
VALUES (101,'OM','PATEL','ADMIN',99000,'JAMNAGAR','MALE',NULL)
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

INSERT INTO EMPLOYEE
VALUES (101,'OM','PATEL','ADMIN',99000,'JAMNAGAR','MALE',NULL)
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

INSERT INTO EMPLOYEE
VALUES (101,'OM','PATEL','ADMIN',99000,'JAMNAGAR','MALE',NULL)


--Part – C: 
--11. Create trigger for storing updated employee details such as EID, old salary, new salary, old department, 
--new department, and update date into EMPLOYEE_UPDATE_LOG table. 
--12. Create trigger for storing newly inserted employee details with insertion date into 
--EMPLOYEE_INSERT_LOG table. 
--13. Create trigger for storing old and new FIRSTNAME values after employee name update into 
--NAME_CHANGE_LOG table. 
--14. Create trigger for storing old city and new city details into CITY_UPDATE_LOG table after city update. 
--15. Implement INSTEAD OF INSERT trigger on EMPLOYEE table to automatically remove extra spaces from 
--FIRSTNAME and LASTNAME before insertion. 