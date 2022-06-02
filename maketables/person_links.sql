CREATE TABLE person_links (
    personname varchar(32) NOT NULL,
    statname varchar(32) NOT NULL,
    stattype varchar(5) NOT NULL,
    PRIMARY KEY(personname, stattype),
    FOREIGN KEY (personname) REFERENCES persons (name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (statname, stattype) REFERENCES stats (name, type) ON UPDATE CASCADE
);