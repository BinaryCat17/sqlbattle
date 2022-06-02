DELETE FROM
    persons
WHERE
    name in (
        SELECT
            CASE
                WHEN pc.points < p.points THEN pc.name
                ELSE p.name
            END
        FROM
            persons p,
            persons pc
        WHERE
            pc.name = ('Clone' || p.name)
    );
