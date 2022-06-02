INSERT INTO
    person_links (personname, statname, stattype)
SELECT
    'Clone' || p.name,
    CASE
        WHEN pl.stattype = 'equip' THEN p.statname
        ELSE pl.statname
    END,
    pl.stattype
FROM
    swap_equip p,
    person_links pl
WHERE
    pl.personname = p.name;