CREATE TABLE
	GaleriaDeArte (
		id INT PRIMARY key,
		nombre VARCHAR(50),
		disponible VARCHAR(50),
		calle VARCHAR(50),
		nro VARCHAR(50),
		localidad VARCHAR(50)
	);


CREATE TABLE
	Autor (
		id INT PRIMARY KEY,
		nya VARCHAR(50),
		fech_nacimiento DATE
	);


CREATE TABLE
	TipoDeObra (id INT PRIMARY key, descripcion VARCHAR(50));


CREATE TABLE
	Obra (
		id INT PRIMARY key,
		nombre VARCHAR(50),
		material VARCHAR(50),
		idTipo INT,
		idAutor INT,
		FOREIGN KEY (idTipo) REFERENCES TipoDeObra (id),
		FOREIGN KEY (idAutor) REFERENCES Autor (id)
	);


CREATE TABLE
	Tematica (id INT PRIMARY key, descripción VARCHAR(50));


CREATE TABLE
	Exposicion (
		idGaleria INT,
		idObra INT,
		idTematica INT,
		fecha DATE,
		sala INT,
		PRIMARY KEY (idGaleria, idObra, idTematica, fecha),
		FOREIGN KEY (idGaleria) REFERENCES GaleriaDeArte (id),
		FOREIGN KEY (idObra) REFERENCES TipoDeObra (id),
		FOREIGN KEY (idTematica) REFERENCES Tematica (id)
	);
