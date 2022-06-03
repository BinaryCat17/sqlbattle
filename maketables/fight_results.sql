CREATE TABLE fight_results (
    name1 varchar(32) NOT NULL,
    name2 varchar(32) NOT NULL,
    outcome1 varchar(4) NOT NULL,
    PRIMARY KEY (name1, name2)
)