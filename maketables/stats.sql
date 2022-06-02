CREATE TABLE stats (
    name varchar(32) NOT NULL,
    type varchar(5) NOT NULL,
    epoh int,
    PRIMARY KEY(name, type),
    CHECK (type in ('spec', 'skill', 'attr', 'equip'))
);