# Learning repo

This repo is a collection of completed challenges to push learning and practice using fundamental programming languages.

## SQL

### PADS

Querying a table of names and occupations for a complex constructed output. [Try the challenge on Hackerrank](https://www.hackerrank.com/challenges/the-pads/problem).

<details>
<summary>
Problem
</summary>
Generate the following two result sets:

1. Query an alphabetically ordered list of all names in OCCUPATIONS
immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses).
For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

2. Query the number of ocurrences of each occupation in OCCUPATIONS.
Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS 
and [occupation] is the lowercase occupation name.
If more than one Occupation has the same [occupation_count],
they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation.
</details>

<details>
<summary>
Solution
</summary>

```sql

SELECT NAME || '(' || SUBSTR(OCCUPATION,1, 1) || ')' FROM OCCUPATIONS ORDER BY NAME;

SELECT 'There are a total of ', COUNT(OCCUPATION), ' ', LOWER(OCCUPATION) || 's.' FROM OCCUPATIONS GROUP BY OCCUPATION ORDER BY COUNT(OCCUPATION), OCCUPATION;

```
</details>

<details>
<summary>
Explanation
</summary>
First of all, break down the problem into its constituents. We'll start by looking at no. 1.

We'd like to gather all of the names from the `OCCUPATIONS` table. We can do this with a `SELECT` statement.



</details>