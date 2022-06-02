UPDATE
    stats
SET
    epoh = ceil(random() * 5)
WHERE
    type ~ '(spec|equip)';
