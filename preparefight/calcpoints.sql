INSERT INTO
    persons (name, points) WITH all_person_links AS (
        SELECT
            pl.personname,
            pl.statname,
            pl.stattype,
            CASE
                WHEN (
                    l.name1 = pl.statname
                    AND l.type1 = pl.stattype
                ) THEN l.name2
                ELSE l.name1
            END AS linkname,
            CASE
                WHEN (
                    l.name1 = pl.statname
                    AND l.type1 = pl.stattype
                ) THEN l.type2
                ELSE l.type1
            END AS linktype,
            l.weight
        FROM
            person_links pl,
            links l
        WHERE
            (
                l.name1 = pl.statname
                AND l.type1 = pl.stattype
            )
            OR (
                l.name2 = pl.statname
                AND l.type2 = pl.stattype
            )
    ),
    all_combos AS (
        SELECT
            apll.*
        FROM
            all_person_links apll,
            all_person_links aplr
        WHERE
            apll.personname = aplr.personname
            AND apll.statname = aplr.linkname
            AND apll.stattype = aplr.linktype
            AND aplr.statname = apll.linkname
            AND aplr.stattype = apll.linktype
    ),
    person_combos AS (
        SELECT
            DISTINCT personname,
            weight,
            statname AS name1,
            stattype AS type1,
            linkname AS name2,
            linktype AS type2
        FROM
            (
                SELECT
                    personname,
                    weight,
                    CASE
                        WHEN statname < linkname THEN statname
                        ELSE linkname
                    END AS statname,
                    CASE
                        WHEN statname < linkname THEN stattype
                        ELSE linktype
                    END AS stattype,
                    CASE
                        WHEN statname < linkname THEN linkname
                        ELSE statname
                    END AS linkname,
                    CASE
                        WHEN statname < linkname THEN linktype
                        ELSE stattype
                    END AS linktype
                FROM
                    all_combos
            ) t
    )
SELECT
    pc.personname AS name,
    sum(pc.weight) AS points
FROM
    person_combos pc
GROUP BY
    pc.personname ON CONFLICT (name) DO
UPDATE
SET
    points = EXCLUDED.points;