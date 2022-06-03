UPDATE
    persons
SET
    died = 0
WHERE
    persons.name in (
        SELECT
            p.name
        FROM
            persons p
        WHERE
            p.died >= 2
        ORDER BY
            random()
        LIMIT
            5
    );