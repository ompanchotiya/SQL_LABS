SELECT * FROM STUDENT
--1. Update the SPI of all students with the name 'AMIT' to 8.20.
UPDATE STUDENT
SET SPI = 8.20
WHERE SNAME = 'AMIT'
-- 2. Change the city of PRIYA from 'MUMBAI' to 'PUNE'.
UPDATE STUDENT
SET CITY = 'MUMBAI'
WHERE CITY = 'PUNE'
-- 3. Update the SPI of HARSH to 7.80 and change his city to 'SURAT'.
UPDATE STUDENT
SET CITY = 'SURAT' , SPI = 7.80
WHERE SNAME = 'HARSH'
-- 4. Update the branch name from 'MECH' to 'MECHANICAL'.
UPDATE STUDENT
SET BRANCH = 'MECHANICAL'
WHERE BRANCH = 'MECH'
-- 5. Change the branch of KAVYA to 'CIVIL'.
UPDATE STUDENT
SET BRANCH = 'CIVIL'
WHERE SNAME = 'KAVYA'
-- 6. Update the SPI to 9.00 for all students whose STDID is between 110 and 115.
UPDATE STUDENT
SET SPI = 9.00
WHERE STDID BETWEEN 110 AND 115
-- 7. Update the city of AYUSH to 'BANGALORE'.
UPDATE STUDENT
SET CITY = 'BANGALORE'
WHERE SNAME = 'AYUSH'
-- 8. Update the SPI of ANJALI to 8.40 and her branch to 'CHEMICAL'.
UPDATE STUDENT
SET SPI = 8.40 , BRANCH = 'CHEMICAL'
WHERE SNAME = 'ANJALI'
--9. Give a 5% increment in SPI to all students.
UPDATE STUDENT
SET SPI = SPI*0.5
-- 10. Increase the SPI by 15% only for students belonging to the 'IT' branch.
UPDATE STUDENT
SET SPI = SPI*1.5
WHERE BRANCH = 'IT'
-- 11. Decrease the SPI by 0.20 for all students who live in 'VADODARA'.
UPDATE STUDENT
SET SPI = SPI-0.2
WHERE CITY = 'VADODARA'
-- 12. Update the branch to 'MINING', SPI to 6.50, and city to 'JAIPUR' where the student's name is VIKRAM.
UPDATE STUDENT
SET BRANCH = 'MINING' , SPI = 6.50 , CITY = 'JAIPUR'
WHERE SNAME = 'VIKRAM'
-- 13. Update the city to 'RAJKOT' and SPI to 7.50 for all students whose branch is 'COMPUTER' and STDID is greater than 105.
UPDATE STUDENT
SET CITY = 'RAJKOT' , SPI = 7.50
WHERE BRANCH = 'COMPUTER' , STDID > 105
-- 14. Deduct 10% from the SPI of any student whose current SPI is greater than 9.00.
UPDATE STUDENT
SET SPI = SPI - SPI*.1
WHERE SPI > 9.00
--15. Update the SPI of the student with STDID 112 to NULL.
UPDATE STUDENT
SET SPI = NULL
WHERE STDID = 112
-- 16. Update the city of ROHAN to NULL.
UPDATE STUDENT
SET CITY = NULL
WHERE SNAME = 'ROHAN'
-- 17. Display all details of students whose branch is NULL.
SELECT * FROM STUDENT
WHERE BRANCH IS NULL
-- 18. Display the names and cities of students who have an SPI assigned (is not NULL).
SELECT CITY,SNAME FROM STUDENT
WHERE SPI IS NULL
-- 19. Update the student with STDID 105 to have the name 'MEET', branch 'EC', and SPI 7.90.
UPDATE STUDENT
SET SNAME = 'MEET' , BRANCH = 'EC' , SPI = 7.00
WHERE STDID = 105
-- 20. Update the city to 'AHMEDABAD' and branch to 'DATA SCIENCE' for the student with STDID 120.
UPDATE STUDENT
SET CITY = 'AHMEDABAD' , BRANCH = 'DATA SCIENCE'
WHERE STDID = 120


--LIKE WISE OPERATOR
--1. Find all records where the PatientName starts with 'A' and ends with 'h'.
SELECT * FROM PATIENTRECORDS
WHERE PatientName LIKE 'A%h'
--2. Find all records where the DiagnosisCode starts with 'abc' and ends with '9'.
SELECT * FROM PATIENTRECORDS
WHERE DIAGNOSISCODE LIKE 'ABC%9'
--3. Find all records where the PatientName starts with 'C' and is exactly 11 characters long.
SELECT * FROM PATIENTRECORDS
WHERE PATIENTNAME LIKE 'C__________'
--4. Find all records where the DiagnosisCode ends with a literal percent sign %.
SELECT * FROM PATIENTRECORDS
WHERE DIAGNOSISCODE LIKE '%[%]'
--5. Find all records where the TreatmentPlan ends with a period ‘.’.
SELECT * FROM PATIENTRECORDS
WHERE TREATMENTPLAN LIKE '%[.]'
--6. Find all records where the PatientName begins with any letter from A through C.
SELECT * FROM PATIENTRECORDS
WHERE PATIENTNAME LIKE '[A-C]%'
--7. Find all records where the DiagnosisCode starts with a letter between X and Z.
SELECT * FROM PATIENTRECORDS
WHERE DIAGNOSISCODE LIKE '[X-Z]%'
--8. Find all records where the DiagnosisCode contains a 3-digit number starting with 4 (i.e., 400 to 499).
SELECT * FROM PATIENTRECORDS
WHERE DIAGNOSISCODE LIKE '%4__%'
--9. Find all records where the PatientName does NOT start with any letter between A and C.
SELECT * FROM PATIENTRECORDS
WHERE PATIENTNAME NOT LIKE '[A-C]%'
--10. Find all records where the PatientName starts with a number.
SELECT * FROM PATIENTRECORDS
WHERE PATIENTNAME LIKE '[0-9]%'
--11. Find all records where the second letter of the PatientName is a lowercase vowel (a, e, i, o, u).
SELECT * FROM PATIENTRECORDS
WHERE PATIENTNAME LIKE '_[aeiou]%'
--12. Find all records where the DiagnosisCode starts with a letter, followed immediately by two digits.
SELECT * FROM PATIENTRECORDS
WHERE DIAGNOSISCODE LIKE '[A-Z][0-9][0-9]'
--13. Find all records where the last character of the DiagnosisCode is not a letter or a number.
SELECT * FROM PATIENTRECORDS
WHERE DIAGNOSISCODE NOT LIKE '%[0-9A-Z]'
--14. Find all records where the PatientName contains a literal underscore ‘_’ anywhere inside it.
SELECT * FROM PATIENTRECORDS
WHERE PATIENTNAME LIKE '%[_]%'



--ORDER BY AND HAVING
--1)Display each department and the total hours worked.
SELECT DEPARTMENT, SUM(HOURS_WORKED) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
--2)Show departments where the total hours worked are greater than 120.
SELECT DEPARTMENT, SUM(HOURS_WORKED) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
HAVING SUM(HOURS_WORKED) > 120
--3)Find the average hours worked in each department and display them from highest to lowest average.
SELECT DEPARTMENT, SUM(HOURS_WORKED) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
ORDER BY SUM(HOURS_WORKED) DESC
--4)Display departments having more than 3 employees.
SELECT DEPARTMENT, COUNT(ASSIGNMENMENT_ID) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
HAVING COUNT(ASSIGNMENMENT_ID) > 3
--5)Show departments whose maximum hours worked exceed 45.
SELECT DEPARTMENT, MAX(HOURS_WORKED) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
HAVING MAX(HOURS_WORKED) > 45
--6)Find departments where the minimum hours worked is less than 30 and sort by minimum hours.
SELECT DEPARTMENT, MIN(HOURS_WORKED) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
HAVING MIN(HOURS_WORKED) < 30
ORDER BY MIN(HOURS_WORKED) ASC
--7)Display each department with employee count and total hours. Show only departments having an average greater than 40.
SELECT DEPARTMENT, COUNT(ASSIGNMENT_ID), SUM(HOURS_WORKED) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
HAVING AVG(HOURS_WORKED) > 40
--8)Find departments where total hours are between 100 and 170. Display them in descending order of total hours.
SELECT DEPARTMENT, SUM(HOURS_WORKED) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
HAVING SUM(HOURS_WORKED) BETWEEN 100 AND 170
ORDER BY SUM(HOURS_WORKED) DESC
--9)Display departments having at least 3 employees. Sort first by employee count (descending), then by department name (ascending).
SELECT DEPARTMENT, COUNT(ASSIGNMENT_ID) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
HAVING COUNT(ASSIGNMENT_ID) >= 3
ORDER BY COUNT(ASSIGNMENT_ID), DEPARTMENT ASC
--10) Display each department with:
--Number of employees
--Total hours worked
--Average hours worked
--Show only departments where:
--Total hours are greater than 110
--Average hours are greater than 38
--Sort by average hours (descending) and then department name.
SELECT DEPARTMENT, COUNT(ASSIGNMENT_ID), SUM(HOURS_WORKED), AVG(HOURS_WORKED) FROM PROJECT_ASSIGNMENTS
GROUP BY DEPARTMENT
HAVING SUM(HOURS_WORKED) > 110 AND AVG(HOURS_WORKED) > 38
ORDER BY AVG(HOURS_WORKED), DEPARTMENT
