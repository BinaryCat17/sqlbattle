UPDATE
    persons
SET
    name = SUBSTR(name, 6)
WHERE
    name LIKE 'Clone%';