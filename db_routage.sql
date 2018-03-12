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
	npoint INT NOT NULL,
	FOREIGN KEY (npoint) REFERENCES point(id),
	PRIMARY KEY (npoint)
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
	nplanning INT NOT NULL,
	ninstance INT,
	FOREIGN KEY (ndepot) REFERENCES point(id),
    FOREIGN KEY (nplanning) REFERENCES planning(id),
	FOREIGN KEY (ninstance) REFERENCES instance(id)
);

CREATE TABLE client(
	demand INT NOT NULL CHECK(demand > 0),
	position INT,
	npoint INT NOT NULL,
	FOREIGN KEY (npoint) REFERENCES point(id),
	nvehicule INT,
    FOREIGN KEY (nvehicule) REFERENCES vehicule(id),
	PRIMARY KEY (npoint)
);

CREATE TABLE route(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ndepart INT NOT NULL,
	narrivee INT NOT NULL,
	distance DOUBLE,
	FOREIGN KEY (ndepart) REFERENCES point(id),
	FOREIGN KEY (narrivee) REFERENCES point(id)
)
