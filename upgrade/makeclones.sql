INSERT INTO
    persons (name, died, points)
SELECT
    'Clone' || se.name,
    p.died,
    0 as points
from
    swap_equip se,
    persons p
WHERE
    p.name = se.name;