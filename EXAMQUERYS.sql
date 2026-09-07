CREATE TABLE MOVIEDETAILS
(
    MOVIEID INT PRIMARY KEY,
    TITLE VARCHAR(100),
    GENRE VARCHAR(100),
    DIRECTOR VARCHAR(100),
    RELEASEYEAR INT
);

CREATE TABLE MOVIEFINANCIALS
(
    FINANCIALID INT PRIMARY KEY,
    BUDGETUSD DECIMAL(12,2),
    BOXOFFICEUSD DECIMAL(12,2),
    MOVIEID INT,
    FOREIGN KEY (MOVIEID) REFERENCES MOVIEDETAILS(MOVIEID)
);

CREATE TABLE MOVIERATINGSDURATION
(
    RATINGID INT PRIMARY KEY,
    DURATIONMIN INT,
    RATING DECIMAL(12,2),
    LANGUAGE VARCHAR(100),
    COUNTRY VARCHAR(100),
    MOVIEID INT,
    FOREIGN KEY (MOVIEID) REFERENCES MOVIEDETAILS(MOVIEID)
);



INSERT INTO MOVIEDETAILS
(MOVIEID, TITLE, GENRE, DIRECTOR, RELEASEYEAR)
VALUES
(1, 'THE DARK KNIGHT', 'ACTION', 'CHRISTOPHER NOLAN', 2008),
(2, 'INCEPTION', 'SCI-FI', 'CHRISTOPHER NOLAN', 2010),
(3, 'AVENGERS:ENDGAME', 'DRAMA', 'ANTHONY RUSSO', 2019),
(4, 'THE AVENGERS', 'ACTION', 'JOSS WHEDON', 2012),
(5, 'TITANIC', 'ROMANCE', 'JAMES CAMERON', 1997),
(6, 'INTERSTELLAR', 'SCI-FI', 'CHRISTOPHER NOLAN', 2014),
(7, 'THE GODFATHER', 'CRIME', 'FRANCIS FORD COPPOLA', 1972),
(8, 'AVENGERS:INFINITY WAR', 'ACTION', 'ANTHONY RUSSO', 2018),
(9, 'THE BATMAN', 'CRIME', 'MATT REEVES', 2022),
(10, 'JURASSIC PARK', 'ADVENTURE', 'STEVEN SPIELBERG', 1993);

INSERT INTO MOVIEFINANCIALS
(FINANCIALID, BUDGETUSD, BOXOFFICEUSD, MOVIEID)
VALUES
(1, 185000000.00, 1005000000.00, 1),
(2, 160000000.00, 839000000.00, 2),
(3, 356000000.00, 2798000000.00, 3),
(4, 220000000.00, 1518000000.00, 4),
(5, 200000000.00, 2264000000.00, 5),
(6, 165000000.00, 731000000.00, 6),
(7, 6000000.00, 250000000.00, 7),
(8, 321000000.00, 2050000000.00, 8),
(9, 200000000.00, 772000000.00, 9),
(10, 63000000.00, 1046000000.00, 10);

INSERT INTO MOVIERATINGSDURATION
(RATINGID, DURATIONMIN, RATING, LANGUAGE, COUNTRY, MOVIEID)
VALUES
(1, 152, 9.0, 'ENGLISH', 'USA', 1),
(2, 148, 8.8, 'ENGLISH', 'USA', 2),
(3, 181, 8.4, 'ENGLISH', 'USA', 3),
(4, 143, 8.0, 'ENGLISH', 'USA', 4),
(5, 195, 7.9, 'ENGLISH', 'USA', 5),
(6, 169, 8.6, 'ENGLISH', 'USA', 6),
(7, 175, 9.2, 'ENGLISH', 'USA', 7),
(8, 149, 8.4, 'ENGLISH', 'USA', 8),
(9, 176, 7.8, 'ENGLISH', 'USA', 9),
(10, 127, 8.1, 'ENGLISH', 'USA', 10);

SELECT * FROM MOVIEDETAILS
SELECT * FROM MOVIEFINANCIALS
SELECT * FROM MOVIERATINGSDURATION
--1. Retrive first five distinct movies along with their title from MovieDetails table.
SELECT DISTINCT TOP 5 * FROM MOVIEDETAILS
--2. Display the total of the BudgetUSD and BoxOfficeUSD assign the name TotalUSD from MovieFinancials.
SELECT (BUDGETUSD + BOXOFFICEUSD) AS TOTALUSD FROM MOVIEFINANCIALS
--3. Insert the new row with this data (11,The Incredible Hulk, Action, Louis Leterrier,2008) in MovieDetails
--table.
INSERT INTO MOVIEDETAILS
VALUES
(11,'THE INCRADIBLE HULK','ACTION','LOUIS LETERRIER',2008)
--4. Set the value of the genre to ‘Action’ of ‘Avengers:Endgame’ movie from MovieDetails table.
UPDATE MOVIEDETAILS
SET GENRE = 'ACTION'
WHERE TITLE = 'AVENGERS:ENDGAME'
--5. Delete the records with duration of 181 minutes from MovieRatingsDuration table.
DELETE FROM MOVIERATINGSDURATION
WHERE DURATIONMIN = 181
--6. Add a new column ‘Producer’ into the MovieDetails table.
ALTER TABLE MOVIEDETAILS
ADD PRODUCER VARCHAR(30)
--7. Delete records of MovieFinancials table without removing its table structure.
DELETE FROM MOVIEFINANCIALS
--8. Retrive all the movies from MovieDetails table with title starting with ‘The’.
SELECT * FROM MOVIEDETAILS
WHERE TITLE LIKE 'THE%'
--9. Retrive name of directors includes ‘son’ from MovieDetails table.
SELECT * FROM MOVIEDETAILS
WHERE DIRECTOR LIKE '%SON%'
--10. Convert and display title of all movies in uppercase.
SELECT UPPER(TITLE) FROM MOVIEDETAILS
--11. Display the highest rating from the MovieRatingsDuration table.
SELECT MAX(RATING) FROM MOVIERATINGSDURATION
--12. Calculate the years between current year and movies release year.
SELECT (YEAR(GETDATE()) - RELEASEYEAR) AS YEARDIFF FROM MOVIEDETAILS
--13. Find the languages in which movies have an average rating of greater than 8.0. Display the language
--and the average rating.
SELECT LANGUAGE, AVG(RATING) FROM MOVIERATINGSDURATION
WHERE RATING > 8
GROUP BY LANGUAGE
--14. Retrieve the minimum, maximum, and average movie duration for each language in the
--MovieRatingsDuration table, but display only those languages where the average rating is greater than
--7.5.
SELECT LANGUAGE, MIN(DURATIONMIN), MAX(DURATIONMIN), AVG(DURATIONMIN) FROM MOVIERATINGSDURATION
GROUP BY LANGUAGE
HAVING AVG(RATING) > 7.5
--15. Find the titles of movies whose budget is higher than the average budget of all movies.(Do not use
--JOINS)
SELECT TITLE FROM MOVIEDETAILS
WHERE MOVIEID IN (
      SELECT MOVIEID FROM MOVIEFINANCIALS
      WHERE BUDGETUSD > (
            SELECT AVG(BUDGETUSD) FROM MOVIEFINANCIALS
      )
)
--16. Find the titles of movies that have a box office revenue greater than the average box office revenue of
--all movies.
SELECT TITLE FROM MOVIEDETAILS
WHERE MOVIEID IN (
      SELECT MOVIEID FROM MOVIEFINANCIALS
      WHERE BOXOFFICEUSD > (
            SELECT AVG(BOXOFFICEUSD) FROM MOVIEFINANCIALS
      )
)
--17. Create a view with Rating, Language and Country columns with no data and named it MovieReview.
CREATE VIEW MOVIEREVIEW AS
SELECT RATING, LANGUAGE, COUNTRY FROM MOVIERATINGSDURATION
--18. List all movies that have the same director but different genres, displaying the director’s name, both
--movie titles, and their respective genres.
SELECT M1.DIRECTOR, M1.TITLE AS MOVIE1, M1.GENRE AS GENRE1, M2.TITLE AS MOVIE2, M2.GENRE AS GENRE2
FROM MOVIEDETAILS M1, MOVIEDETAILS M2
WHERE M1.DIRECTOR = M2.DIRECTOR AND M1.GENRE != M2.GENRE AND M1.MOVIEID < M2.MOVIEID
--19. Retrieve the title, director, and box office earnings for all movies that were released after 2010, along
--with their ratings.
SELECT D.TITLE, D.DIRECTOR, F.BOXOFFICEUSD, R.RATING
FROM MOVIEDETAILS D
JOIN MOVIEFINANCIALS F ON D.MOVIEID = F.MOVIEID
JOIN MOVIERATINGSDURATION R ON D.MOVIEID = R.MOVIEID
WHERE D.RELEASEYEAR > 2010;

--20. List all directors and the number of movies they have directed, but only include directors who have
--directed more than 1 movie.
SELECT DIRECTOR, COUNT(MOVIEID) AS MOVIECOUNT
FROM MOVIEDETAILS
GROUP BY DIRECTOR
HAVING COUNT(MOVIEID) > 1;