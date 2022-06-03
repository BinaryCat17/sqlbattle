CREATE TABLE history (
    iteration int,
    person varchar(32),
    fights_with varchar(32),
    points int,
    equip varchar(32),
    died int,
    PRIMARY KEY(iteration, person)
);