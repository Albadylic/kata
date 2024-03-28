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

The OCCUPATIONS table is described as follows:

| Column | Type |
| --- | --- |
| Name | String |
| Occupation | String |

The table contains the following records:

| Name | Occupation |
| --- | --- |
| Ashley | Professor |
| Samantha | Actor |
| Julia | Doctor |
| Britney | Professor |
| Maria | Professor |
| Meera | Professor |
| Priya | Doctor |
| Priyanka | Professor |
| Jennifer | Actor |
| Ketty | Actor |
| Belvet | Professor |
| Naomi | Professor |
| Jane | Singer |
| Jenny | Singer |
| Kristeen | Singer |
| Christeen | Singer |
| Eve | Actor |
| Aamina | Doctor |
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

### Part one

We'd like to gather all of the names from the `OCCUPATIONS` table. We can do this with a `SELECT` statement.

```sql
SELECT NAME FROM OCCUPATIONS;
``` 

These need to be ordered alphabetically, so let's add an `ORDER BY` which by default will order from A to Z.

```sql
SELECT NAME FROM OCCUPATIONS ORDER BY NAME;
```

Next, we'll grab the occupation. The first step is to write a similar `SELECT` reference the column name. We can then use the [`SUBSTR` function](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/SUBSTR.html#GUID-C8A20B57-C647-4649-A379-8651AA97187E) to get only the first letter. (Note: I'm writing my solution in PLSQL / Oracle SQL. In vanilla SQL, the function is `SUBSTRING`).

This takes three arguments: string, starting position and number of characters. The starting position can be indexed from 1 or 0.

```sql
SELECT NAME, SUBSTR(OCCUPATION,1,1) FROM OCCUPATIONS ORDER BY NAME;
```

Now we'll see an output of the name and the first character of the occupation separated by a space. For example:

```
Aamina D
Ashley P
Belvet P
```

And finally, we'll need to format our ouput with the brackets. Initially, I had no idea how I'd do this so I had a look around online and came across the [`CONCAT` function](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/CONCAT.html#GUID-D8723EA5-C93A-45C3-83FB-1F3D2A4CEAF2).

This function takes two arguments and joins them together with no separator. Before reading the documentation, I'd tried to pass in more than 2 arguments but these cause error. Having come from JS world, I'd assumed that any number of arguments would be acceptable.

So, my solution instead was to nest `CONCAT`s until I had my desired result.

```sql
SELECT CONCAT(NAME, CONCAT('(', CONCAT(SUBSTR(OCCUPATION,1, 1), ')')) ) FROM OCCUPATIONS ORDER BY NAME;
```

This is pretty ugly and unreadable. We'll refactor at the end of the solution.

<details>
<summary>
Nested CONCAT breakdown
</summary>

The innermost `CONCAT` joins the OCCUPATION initial (first character) to a closing bracket. Assuming `OCCUPATION` is 'Doctor' then our result so far is `D)`.

```sql
CONCAT(SUBSTR(OCCUPATION,1, 1), ')')
```

Next, we'll concatenate this with an opening bracket. We then have `(D)`.

```sql
CONCAT('(', CONCAT(SUBSTR(OCCUPATION,1, 1), ')'))
```

Finally, we'll include the name infront of the bracketed initial, to get `Aamina(D)` for example.

```sql
CONCAT(NAME, CONCAT('(', CONCAT(SUBSTR(OCCUPATION,1, 1), ')')) )
```

</details>

### Part two

In this second part, we're looking to count the number of occurences of each occupation. We'll order our output first by the number of occurences (lowest to highest) and then alphabetically (if we have two of equal number).

Our output should be in the form 'There are a total of [count] [occupation]s.' We're told there will always be at least two of each occupation so we can include the pluralising 's' in every output, avoiding adding in conditional logic.

We'll start with our `SELECT` first of all. We're going to use the `COUNT` function to count the occurences of the occupations. We'll also include `OCCUPATION` as we'll be using this name in our output.

```sql
SELECT COUNT(OCCUPATION), OCCUPATION FROM OCCUPATIONS;
```

This statement will return the total number of occupations found in the table. So long as there's no `NULL` values, we'll get the number of rows in the table.

In order to get the number of occurences of *each occupation* we'll include a `GROUP BY` statement.

```sql
SELECT COUNT(OCCUPATION), OCCUPATION FROM OCCUPATIONS GROUP BY OCCUPATION;
```

This returns a set of numbers representing occurences for each occupation, followed by the occupation:
```
3 Doctor
7 Professor
4 Actor
4 Singer
```

Next, we can orr out result into the expected order.

```sql
SELECT COUNT(OCCUPATION), OCCUPATION FROM OCCUPATIONS GROUP BY OCCUPATION ORDER BY COUNT(OCCUPATION), OCCUPATION;
```

We're now getting back the correct results, in the right order:

```
3 Doctor
4 Actor
4 Singer
7 Professor
```

Our final task is to construct our output in the form expected. We can use commas within the initial `SELECT` to compose a string which concatenates strings with results returned.

```sql
SELECT 'There are a total of ', COUNT(OCCUPATION), ' ', CONCAT(LOWER(OCCUPATION), 's.') FROM OCCUPATIONS GROUP BY OCCUPATION ORDER BY COUNT(OCCUPATION), OCCUPATION;
```

As before, I'm using a `CONCAT` to combine the occupation with the pluralising 's'. I'm also using `LOWER` on the occupation to give an entirely lower case string. The value stored in the database has a capital initial which can be removed when outputting a sentence.

This returns the correct result from the database for part two.

### Solution 

So, here we have a working solution to this problem:

```sql
SELECT CONCAT(NAME, CONCAT('(', CONCAT(SUBSTR(OCCUPATION,1, 1), ')')) ) FROM OCCUPATIONS ORDER BY NAME;

SELECT 'There are a total of ', COUNT(OCCUPATION), ' ', CONCAT(LOWER(OCCUPATION), 's.') FROM OCCUPATIONS GROUP BY OCCUPATION ORDER BY COUNT(OCCUPATION), OCCUPATION;
```

### Refactoring

After completing this challenge, I asked my colleague [Mark](https://github.com/hanleymark) if he'd worked on it too and we compared solutions. Fundamentally, they perform the same task. However, he had a neater approach to concatenating the output.

This uses the `||` operator to concatenate in place. And much like in JS where we can pass n number of arguments to the `concat()` method, we can join together any number of strings. Not to be confused with the logical OR used in JS!

So, after refactoring my solution, I have the following:

```sql
SELECT NAME || '(' || SUBSTR(OCCUPATION,1, 1) || ')' FROM OCCUPATIONS ORDER BY NAME;

SELECT 'There are a total of ' || COUNT(OCCUPATION) ||  ' ' || LOWER(OCCUPATION) || 's.' FROM OCCUPATIONS GROUP BY OCCUPATION ORDER BY COUNT(OCCUPATION), OCCUPATION;
```

</details>