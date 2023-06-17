CREATE TABLE
	Almacen (Nro INT PRIMARY key, Responsable VARCHAR(50));


CREATE TABLE
	Articulo (
		CodArt INT PRIMARY key,
		Descripcion VARCHAR(50),
		Precio DECIMAL(12, 3)
	);


CREATE TABLE
	Material (CodMat INT PRIMARY key, Descripcion VARCHAR(50));


CREATE TABLE
	Proveedor (
		CodProv INT PRIMARY key,
		Nombre VARCHAR(50),
		Domicilio VARCHAR(50),
		Ciudad VARCHAR(50)
	);


CREATE TABLE
	Tiene (Nro INT, CodArt INT);


CREATE TABLE
	Compuesto_Por (CodArt INT, CodMat INT);


CREATE TABLE
	Provisto_Por (CodMat INT, CodProv INT);
