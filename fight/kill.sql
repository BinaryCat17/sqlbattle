UPDATE
    persons
SET
    died = (
        CASE
            WHEN (
                name IN (
                    SELECT
                        CASE
                            WHEN fr.outcome1 = 'win' THEN fr.name1
                            ELSE fr.name2
                        END
                    FROM
                        fight_results fr
                    WHERE
                        (
                            fr.name1 = name
                            AND fr.outcome1 = 'win'
                        )
                        OR (
                            fr.name2 = name
                            AND fr.outcome1 = 'died'
                        )
                )
            ) THEN died
            ELSE 1
        END
    )
WHERE
    died IS NULL
    OR died = 0;