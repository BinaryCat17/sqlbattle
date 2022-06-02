INSERT INTO
    fight_results (name1, name2, outcome1) WITH not_died AS (
        SELECT
            *
        FROM
            persons p
        WHERE
            p.died IS NULL
            OR p.died = 0
    ),
    control AS (
        SELECT
            *
        FROM
            not_died
        ORDER BY
            random()
        limit
            (
                SELECT
                    count(*) / 2
                FROM
                    not_died
            )
    ),
    splitted_persons AS (
        SELECT
            *,
            (
                CASE
                    WHEN t IN (
                        SELECT
                            c
                        FROM
                            control c
                    ) THEN 'first'
                    ELSE 'second'
                END
            ) AS match
        FROM
            not_died t
    ),
    persons_splitted_left AS (
        SELECT
            row_number() OVER (
                ORDER BY
                    random()
            ),
            s.name AS name1,
            s.points AS points1
        FROM
            splitted_persons AS s
        WHERE
            s.match = 'first'
    ),
    persons_splitted_right AS (
        SELECT
            row_number() OVER (
                ORDER BY
                    random()
            ),
            s.name AS name2,
            s.points AS points2
        FROM
            splitted_persons AS s
        WHERE
            s.match = 'second'
    ),
    fight_pairs AS (
        SELECT
            l.name1,
            r.name2,
            l.points1 AS firstpoints,
            l.points1 + r.points2 AS sumpoints
        FROM
            persons_splitted_left l,
            persons_splitted_right r
        WHERE
            l.row_number = r.row_number
    )
SELECT
    fp.name1,
    fp.name2,
    CASE
        WHEN ceil(random() * fp.sumpoints) <= fp.firstpoints THEN 'win'
        ELSE 'died'
    END
FROM
    fight_pairs fp;