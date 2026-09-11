--Part – A:
--1. Implement scalar function to return "Welcome to DBMS Lab".
CREATE FUNCTION FN_WELCOME()
RETURNS VARCHAR(100)
AS 
BEGIN 
     RETURN 'Welcome to DBMS Lab'
END;

SELECT DBO.FN_WELCOME();
--2. Implement scalar function to calculate simple interest.
CREATE FUNCTION FN_SIMPLEINTREST
(
   @P DECIMAL(10,4),
   @R DECIMAL(10,4),
   @T DECIMAL(10,4)
)
RETURNS DECIMAL(10,4)
AS
BEGIN
    RETURN (@P * @R * @T)/100

END;

SELECT DBO.FN_SIMPLEINTREST(10,10,10)
--3. Implement scalar function to find difference in days between two dates.
CREATE FUNCTION FN_DIFF_DAYS
(
   @D1 DATE,
   @D2 DATE
)
RETURNS INT
AS
BEGIN
     RETURN (DATEDIFF(DAY,@D1,@D2))
END;

SELECT DBO.FN_DIFF_DAYS('2025/01/01','2026/01/01')
--4. Implement scalar function to check whether number is odd or even.
CREATE FUNCTION FN_ODDEVEN
(
   @NUM INT
)
RETURNS VARCHAR(10)
AS
BEGIN
     DECLARE @RES VARCHAR(10)
     IF(@NUM%2 = 0)
        SET @RES = 'EVEN'
     ELSE
        SET @RES = 'ODD'

     RETURN @RES
END;

SELECT DBO.FN_ODDEVEN(115)
--5. Implement scalar function to print numbers from 1 to N.
CREATE FUNCTION FN_1_TO_N
(
   @N INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
     DECLARE @I INT =1
     DECLARE @ANS VARCHAR(MAX)=' '
   

     WHILE @I != @N+1
     BEGIN
        SET @ANS = @ANS + CAST(@I AS VARCHAR) + ' '
        SET @I = @I + 1
     END
     RETURN @ANS
END;

SELECT DBO.FN_1_TO_N(10)


--Part – B:
--6. Implement scalar function to calculate factorial of given number.
CREATE OR ALTER FUNCTION FN_FACT_N
(
   @N INT
)
RETURNS INT
AS
BEGIN
     DECLARE @I INT = 1
     DECLARE @ANS INT = 1
   

     WHILE @I <= @N
     BEGIN
        SET @ANS = @ANS*@I
        SET @I = @I + 1
     END
     RETURN @ANS
END;

SELECT DBO.FN_FACT_N(5)
--7. Implement scalar function to check palindrome number.
CREATE FUNCTION FN_PALINDROME
(
    @N INT
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @TEMP INT = @N
    DECLARE @REV INT = 0
    DECLARE @REM INT

    WHILE @TEMP > 0
    BEGIN
        SET @REM = @TEMP % 10
        SET @REV = (@REV * 10) + @REM
        SET @TEMP = @TEMP / 10
    END

    IF @N = @REV
        RETURN 'PALINDROME'

    RETURN 'NOT PALINDROME'
END

SELECT DBO.FN_PALINDROME(121)
--8. IMPLEMENT SCALAR FUNCTION TO FIND MAXIMUM OF THREE NUMBERS.
CREATE FUNCTION FN_MAX_THREE
(
    @A INT,
    @B INT,
    @C INT
)
RETURNS INT
AS
BEGIN
    DECLARE @MAX INT

    SET @MAX = @A

    IF @B > @MAX
        SET @MAX = @B

    IF @C > @MAX
        SET @MAX = @C

    RETURN @MAX
END

SELECT DBO.FN_MAX_THREE(10, 25, 15)
--9. IMPLEMENT SCALAR FUNCTION TO CALCULATE SQUARE AND CUBE OF A NUMBER.
CREATE FUNCTION FN_SQUARE_CUBE
(
    @N INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    RETURN 'SQUARE = ' + CAST(@N * @N AS VARCHAR) +
           ', CUBE = ' + CAST(@N * @N * @N AS VARCHAR)
END

SELECT DBO.FN_SQUARE_CUBE(5)


--From the table EMPLOYEE perform the following queries:
--Part – C:
--10. Implement scalar function to return employee full details using EID.
CREATE FUNCTION FN_ALLDETAIL
(
   @EID INT
)
RETURNS TABLE
AS
   RETURN 
   (
      SELECT * FROM EMPLOYEE
      WHERE EID = @EID
   )

SELECT * FROM FN_ALLDETAIL(106)
--11. Implement scalar function to return highest salary from a given department.
CREATE FUNCTION FN_MAX_SALARY_BYDEPARTMENT
(
   @DEP VARCHAR(20)
)
RETURNS TABLE
AS
   RETURN 
   (
      SELECT MAX(SALARY) AS HIGHEST_SALARY FROM EMPLOYEE
      WHERE DEPARTMENT = @DEP
   )

SELECT * FROM FN_MAX_SALARY_BYDEPARTMENT('IT')
--12. Implement scalar function to count total employees in EMPLOYEE table.
CREATE FUNCTION FN_TOTAL_EMPLOYEE()
RETURNS TABLE
AS
   RETURN 
   (
      SELECT COUNT(EID) AS TOTAL_EMPLOYEE FROM EMPLOYEE
   )

SELECT * FROM FN_TOTAL_EMPLOYEE()
--13. Implement scalar function to find total experience of employee using JoiningYear.
CREATE OR ALTER FUNCTION FN_EXPERIENCE()
RETURNS TABLE
AS
   RETURN 
   (
      SELECT YEAR(GETDATE())-JOININGYEAR AS EXPERIENCE FROM EMPLOYEE

   )

SELECT * FROM FN_EXPERIENCE()
--14. Implement scalar function to return total number of employees in a given department.
CREATE FUNCTION FN_TOTAL_EMPLOYEE_BYDEPARTMENT
(
   @DEP VARCHAR(30)
)
RETURNS TABLE
AS
   RETURN 
   (
      SELECT COUNT(EID) AS TOTAL_EMPLOYEE FROM EMPLOYEE
      WHERE DEPARTMENT = @DEP
   )

SELECT * FROM FN_TOTAL_EMPLOYEE_BYDEPARTMENT('IT')
--15. Implement scalar function to count total employees from a given city.
CREATE FUNCTION FN_TOTAL_EMPLOYEE_BYCITY
(
   @CITY VARCHAR(30)
)
RETURNS TABLE
AS
   RETURN 
   (
      SELECT COUNT(EID) AS TOTAL_EMPLOYEE FROM EMPLOYEE
      WHERE CITY = @CITY
   )

SELECT * FROM FN_TOTAL_EMPLOYEE_BYCITY('RAJKOT')