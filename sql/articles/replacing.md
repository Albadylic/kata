-- Creating new records by copying old records and replacing text

```
INSERT INTO tablename (
	columns,
)
	SELECT
		columns,
		replace(column, 'oldstring', 'newstring')
		-- To replace multiple values, nest replace statements
		replace(replace(column, 'firstoldstring', 'firstnewstring'), 'secondoldstring', 'secondnewstring')
	FROM tablename
	WHERE
		label LIKE '%something%';
```