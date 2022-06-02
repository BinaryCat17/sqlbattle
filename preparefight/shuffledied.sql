UPDATE
    person_links
SET
    statname = refreshed.statname
FROM
    (
        WITH died_stats AS (
            SELECT
                p.name,
                pl.statname,
                pl.stattype
            FROM
                persons p,
                person_links pl
            WHERE
                p.died > 0
                AND pl.personname = p.name
        )
        SELECT
            t.name,
            t2.statname,
            t2.stattype
        FROM
            (
                SELECT
                    t.*,
                    row_number() OVER (
                        ORDER BY
                            random()
                    ) AS seqnum
                FROM
                    died_stats t
            ) t
            join (
                SELECT
                    t.*,
                    row_number() OVER (
                        ORDER BY
                            random()
                    ) AS seqnum
                FROM
                    died_stats t
            ) t2 ON t.seqnum = t2.seqnum
        WHERE
            t2.stattype = 'equip'
    ) AS refreshed
WHERE
    person_links.personname = refreshed.name
    AND refreshed.stattype = 'equip'
    AND person_links.stattype = 'equip';