insert into
    stats(type, name)
select
    distinct 'attr',
    attr
from
    pool;