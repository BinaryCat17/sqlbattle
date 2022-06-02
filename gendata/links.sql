INSERT INTO
    links(name1, type1, name2, type2, weight) with control as (
        select
            *
        from
            stats
        order by
            random()
        limit
            (
                select
                    count(*) / 2
                from
                    stats
            )
    ),
    splitted_stats AS (
        select
            *,
            (
                case
                    when t in (
                        select
                            t
                        from
                            control t
                    ) then 'first'
                    else 'second'
                end
            ) as match
        from
            stats t
    ),
    stats_splitted_left AS (
        select
            s.name as name1,
            s.type as type1
        from
            splitted_stats as s
        WHERE
            s.match = 'first'
        ORDER BY
            random()
    ),
    stats_splitted_right AS (
        select
            s.name as name2,
            s.type as type2
        from
            splitted_stats as s
        WHERE
            s.match = 'second'
        ORDER BY
            random()
    )
SELECT
    l.name1,
    l.type1,
    r.name2,
    r.type2,
    0
FROM
    stats_splitted_left l,
    stats_splitted_right r
WHERE
    l.name1 <> r.name2
    AND l.type1 <> r.type2
ORDER BY
    random()
LIMIT
    600