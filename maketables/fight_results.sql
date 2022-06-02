CREATE TABLE fight_results (
    name1 varchar(32) NOT NULL,
    name2 varchar(32) NOT NULL,
    outcome1 varchar(4) NOT NULL,
    PRIMARY KEY (name1, name2),
    FOREIGN KEY (name1) REFERENCES persons (name),
    FOREIGN KEY (name2) REFERENCES persons (name)
)