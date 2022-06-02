INSERT INTO
    swap_equip (name, statname)
SELECT
    CASE
        WHEN fr.outcome1 = 'win' THEN fr.name1
        ELSE fr.name2
    END,
    CASE
        WHEN fr.outcome1 = 'win' THEN pl2.statname
        ELSE pl1.statname
    END
FROM
    fight_results fr,
    person_links pl1,
    person_links pl2
WHERE
    (
        fr.name1 = pl1.personname
        AND pl1.stattype = 'equip'
    )
    AND (
        fr.name2 = pl2.personname
        AND pl2.stattype = 'equip'
    );