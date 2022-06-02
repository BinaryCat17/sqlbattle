INSERT INTO
    person_links (personname, statname, stattype)
SELECT
    DISTINCT ON (p.name, s.type) p.name,
    s.name,
    s.type
FROM
    persons p,
    (
        SELECT
            *
        FROM
            stats
        ORDER BY
            random()
    ) s;
