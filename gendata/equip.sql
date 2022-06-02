insert into
    stats(type, name)
select
    distinct 'equip',
    equip
from
    pool;