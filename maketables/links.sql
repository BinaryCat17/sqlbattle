CREATE TABLE links (
    name1 varchar(32) NOT NULL,
    type1 varchar(5) NOT NULL,
    name2 varchar(32) NOT NULL,
    type2 varchar(5) NOT NULL,
    weight int NOT NULL,
    PRIMARY KEY (name1, type1, name2, type2),
    FOREIGN KEY(name1, type1) REFERENCES stats(name, type),
    FOREIGN KEY(name2, type2) REFERENCES stats(name, type)
);