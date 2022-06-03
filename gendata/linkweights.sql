UPDATE
    links
SET
    weight = ceil(random() * 5)
WHERE epoh = $1;