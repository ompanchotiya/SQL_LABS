--From the table STUDENT perform the following queries:
SELECT * FROM STUDENT
--Part – A:
--1. Display rank of students based on SPI.
SELECT STDID, SNAME, CITY, SPI, BRANCH,
RANK() OVER (ORDER BY SPI DESC) AS R_N
FROM STUDENT
--2. Display dense rank of students based on SPI.
SELECT STDID, SNAME, CITY, SPI, BRANCH,
DENSE_RANK() OVER (ORDER BY SPI DESC) AS R_N
FROM STUDENT
--3. Display sequential number for each student record.
SELECT STDID, SNAME, CITY, SPI, BRANCH,
ROW_NUMBER() OVER (ORDER BY SPI DESC) AS R_N
FROM STUDENT
--4. Display branch-wise rank of students.
SELECT STDID, SNAME, CITY, SPI, BRANCH,
RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS R_N
FROM STUDENT
--5. Display branch-wise dense ranking of students.
SELECT STDID, SNAME, CITY, SPI, BRANCH,
DENSE_RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS R_N
FROM STUDENT
--6. Display branch-wise sequential numbering of students.
SELECT STDID, SNAME, CITY, SPI, BRANCH,
ROW_NUMBER() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS R_N
FROM STUDENT
--7. Display SNAME, Current SPI, Previous SPI and SPI Difference with previous student in ascending order of
--SPI.
SELECT SNAME, SPI,
(LAG(SPI) OVER (ORDER BY SPI ASC))-SPI AS DIFF
FROM STUDENT
--8. Display SNAME, Current SPI, Next SPI and SPI Difference with next student in descending order of SPI.
SELECT SNAME, SPI,
(LEAD(SPI) OVER (ORDER BY SPI ASC))-SPI AS DIFF
FROM STUDENT
--9. Display top 3 students based on SPI.
SELECT * FROM
(SELECT STDID, SNAME, CITY, SPI, BRANCH,
DENSE_RANK() OVER (ORDER BY SPI DESC) AS D_R
FROM STUDENT) DATA
WHERE D_R <= 3
--10. Display top 2 students from each branch.
SELECT * FROM
(SELECT STDID, SNAME, CITY, SPI, BRANCH,
DENSE_RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS D_R
FROM STUDENT) DATA
WHERE D_R <= 2


--Part – B:
--11. Display 5th highest SPI.
SELECT * FROM
(SELECT STDID, SNAME, CITY, SPI, BRANCH,
DENSE_RANK() OVER (ORDER BY SPI DESC) AS D_R
FROM STUDENT) DATA
WHERE D_R = 5
--12. Display 6th highest SPI.
SELECT * FROM
(SELECT STDID, SNAME, CITY, SPI, BRANCH,
DENSE_RANK() OVER (ORDER BY SPI DESC) AS D_R
FROM STUDENT) DATA
WHERE D_R = 6
--13. Display students having same ranking.
--14. Display SNAME, Previous SPI, Current SPI and Next SPI based on ascending order of SPI.
SELECT SNAME,
LAG(SPI) OVER (ORDER BY SPI ASC) AS LAG_SPI,
 SPI,
LEAD(SPI) OVER (ORDER BY SPI ASC) AS LAG_SPI
FROM STUDENT
--15. Display topper of each branch.
SELECT * FROM
(SELECT STDID, SNAME, CITY, SPI, BRANCH,
DENSE_RANK() OVER (PARTITION BY BRANCH ORDER BY SPI DESC) AS D_R
FROM STUDENT) DATA
WHERE D_R = 1


--Part – C:
--16. Display students whose SPI is greater than the previous student and less than the next student.
--17. Display branch-wise second topper students.
--18. Display students whose rank and dense rank are different.
--19. Display consecutive students having same branch ordered by SPI.
--20. Display students whose SPI difference with previous student is maximum.