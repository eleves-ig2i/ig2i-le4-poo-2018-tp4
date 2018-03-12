DROP TABLE route;
DROP TABLE client;
DROP TABLE vehicule;
DROP TABLE planning;
DROP TABLE depot;
DROP TABLE point;
DROP TABLE instance;


CREATE TABLE instance(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nom VARCHAR(50) NOT NULL
);

CREATE TABLE point(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	pointtype INT,
	x DOUBLE NOT NULL,
	y DOUBLE NOT NULL,
	ninstance INT,
	FOREIGN KEY (ninstance) REFERENCES instance(id)
);

CREATE TABLE depot(
	id INT NOT NULL,
	FOREIGN KEY (id) REFERENCES point(id),
	PRIMARY KEY (id)
);

CREATE TABLE planning(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	cout DOUBLE,
	ninstance INT,
	FOREIGN KEY (ninstance) REFERENCES instance(id)
);

CREATE TABLE vehicule(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	cout DOUBLE,
	capaciteutilisee INT,
	capacite INT,
	ndepot INT, 
	nplanning INT,
	ninstance INT,
	FOREIGN KEY (ndepot) REFERENCES point(id),
    FOREIGN KEY (nplanning) REFERENCES planning(id),
	FOREIGN KEY (ninstance) REFERENCES instance(id)
);

CREATE TABLE client(
	demand INT NOT NULL CHECK(demand > 0),
	position INT,
	id INT NOT NULL,
	FOREIGN KEY (id) REFERENCES point(id),
	nvehicule INT,
    FOREIGN KEY (nvehicule) REFERENCES vehicule(id),
	PRIMARY KEY (id)
);

CREATE TABLE route(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ndepart INT NOT NULL,
	narrivee INT NOT NULL,
	distance DOUBLE,
	FOREIGN KEY (ndepart) REFERENCES point(id),
	FOREIGN KEY (narrivee) REFERENCES point(id)
);

INSERT INTO instance(nom) VALUES ('tiny_test');

INSERT INTO point(pointtype, x, y, ninstance) VALUES (1, 0 , 0, (SELECT id FROM instance WHERE nom = 'tiny_test'));
INSERT INTO depot(id) VALUES (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test'));

INSERT INTO point(pointtype, x, y, ninstance) VALUES (2, 10 , 10, (SELECT id FROM instance WHERE nom = 'tiny_test'));
INSERT INTO client(demand, id) VALUES (10, (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')));
INSERT INTO point(pointtype, x, y, ninstance) VALUES (2, 10 , -10, (SELECT id FROM instance WHERE nom = 'tiny_test'));
INSERT INTO client(demand, id) VALUES (5, (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')));
INSERT INTO point(pointtype, x, y, ninstance) VALUES (2, -10 , 10, (SELECT id FROM instance WHERE nom = 'tiny_test'));
INSERT INTO client(demand, id) VALUES (10, (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')));
INSERT INTO point(pointtype, x, y, ninstance) VALUES (2, -10 , -10, (SELECT id FROM instance WHERE nom = 'tiny_test'));
INSERT INTO client(demand, id) VALUES (5, (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')));

INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    14.14);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    14.14);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    14.14);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    14.14);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    14.14);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    20);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    20);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    28.28);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    14.14);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    20);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    28.28);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    20);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    14.14);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    28.28);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    20);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    20);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    14.14);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    20);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    28.28);
INSERT INTO route(ndepart, narrivee, distance) VALUES (
    (SELECT id FROM point WHERE x=-10 AND y=-10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    (SELECT id FROM point WHERE x=-10 AND y=10 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')), 
    20);

INSERT INTO planning(ninstance) VALUES ((SELECT id FROM instance WHERE nom = 'tiny_test'));

INSERT INTO vehicule(capacite, ndepot, ninstance) VALUES(
    20,
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')),
    (SELECT id FROM instance WHERE nom = 'tiny_test')
);
INSERT INTO vehicule(capacite, ndepot, ninstance) VALUES(
    20,
    (SELECT id FROM point WHERE x=0 AND y=0 AND ninstance = (SELECT id FROM instance WHERE nom = 'tiny_test')),
    (SELECT id FROM instance WHERE nom = 'tiny_test')
);