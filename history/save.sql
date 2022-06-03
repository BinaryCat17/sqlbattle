INSERT INTO
    history (iteration, person, fights_with, points, equip, died)
SELECT
    $1,
    p.name,
    CASE
        WHEN fr.name1 = p.name THEN fr.name2
        ELSE fr.name1
    END,
    p.points,
    pl.statname,
    p.died
FROM
    persons p
    LEFT OUTER JOIN fight_results fr ON (
        fr.name1 = p.name
        OR fr.name2 = p.name
    )
    JOIN person_links pl ON (
        pl.personname = p.name
        AND pl.stattype = 'equip'
    );