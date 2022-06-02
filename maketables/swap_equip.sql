CREATE TABLE swap_equip (
    name varchar(32) NOT NULL,
    statname varchar(32) NOT NULL,
    PRIMARY KEY (name, statname),
    FOREIGN KEY (name) REFERENCES persons (name)
);