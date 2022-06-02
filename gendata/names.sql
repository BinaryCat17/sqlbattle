insert into
    persons(name, points)
select
    name,
    0
from
    names
ORDER BY
    random()
LIMIT
    100;
