/* CITIES */

-- Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

SELECT * FROM CITY WHERE COUNTRYCODE = 'USA' AND POPULATION > 100000;

-- Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

SELECT NAME FROM CITY WHERE COUNTRYCODE = 'USA' AND POPULATION > 120000;

-- Query all columns (attributes) for every row in the CITY table.

SELECT * FROM CITY;

-- Query all columns for a city in CITY with the ID 1661.

SELECT * FROM CITY WHERE ID = 1661;

-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN';

/* WEATHER STATIONS */

-- Query a list of CITY and STATE from the STATION table.

SELECT CITY, STATE FROM STATION;

-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

SELECT UNIQUE CITY FROM STATION WHERE MOD(ID, 2) = 0;

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

SELECT (COUNT(CITY) - COUNT(UNIQUE CITY)) FROM STATION;

/*
Initially, I tried:

(SELECT COUNT(CITY) FROM STATION) - (COUNT(UNIQUE CITY)) FROM STATION);

and also using `MINUS` in place of `-`
*/


/*
Query the two cities in STATION with the shortest and longest CITY names,
as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city,
choose the one that comes first when ordered alphabetically.
*/

SELECT * FROM (SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY), CITY) WHERE ROWNUM = 1;

SELECT * FROM (SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY) WHERE ROWNUM = 1;

