CREATE TABLE
	Alumno (
		DNI INT NOT NULL PRIMARY key,
		Apellido VARCHAR(50),
		Nombre VARCHAR(50),
		CodEscuela INT
	);


CREATE TABLE
	Hermano_De (
		DniAlumno INT NOT NULL,
		DniHermano INT NOT NULL,
		CONSTRAINT PK_Hermano_De PRIMARY key (DniAlumno, DniHermano)
	);


CREATE TABLE
	Escuela (
		CodEscuela INT NOT NULL PRIMARY key,
		Nombre VARCHAR(50),
		Direccion VARCHAR(255)
	);


CREATE TABLE
	Alimento (
		IdAlimento INT NOT NULL PRIMARY key,
		Descripcion VARCHAR(50),
		Marca VARCHAR(50)
	);


CREATE TABLE
	Almuerza_En (
		DniAlumno INT NOT NULL,
		IdAlimento INT NOT NULL,
		CodEscuela INT,
		CONSTRAINT PK_Almuerza_En PRIMARY key (DniAlumno, IdAlimento)
	);
