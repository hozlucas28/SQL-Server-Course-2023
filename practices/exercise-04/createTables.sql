CREATE TABLE
	Pais (pais CHAR(50) PRIMARY key);


CREATE TABLE
	Banco (
		id INT PRIMARY key,
		nombre VARCHAR(50),
		pais CHAR(50)
	);


CREATE TABLE
	Moneda (
		id CHAR(2) PRIMARY key,
		descripcion VARCHAR(50),
		valorOro DECIMAL(18, 3),
		valorPetroleo DECIMAL(18, 3)
	);


CREATE TABLE
	Persona (
		pasaporte CHAR(15) PRIMARY key,
		codigoFiscal INT,
		nombre VARCHAR(50)
	);


CREATE TABLE
	Cuenta (
		monto DECIMAL(18, 3),
		idBanco INT NOT NULL,
		idMoneda CHAR(2) NOT NULL,
		idPersona CHAR(15) NOT NULL,
		CONSTRAINT PK_Persona PRIMARY key (idBanco, idMoneda, idPersona)
	);


CREATE TABLE
	Opera (
		idBanco INT NOT NULL,
		idMoneda CHAR(2) NOT NULL,
		cambioCompra DECIMAL(18, 3),
		cambioVenta DECIMAL(18, 3),
		CONSTRAINT PK_Opera PRIMARY key (idBanco, idMoneda)
	);
