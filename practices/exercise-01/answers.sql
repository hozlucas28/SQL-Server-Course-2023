/* -------------------------------- Answer 01 ------------------------------- */
SELECT
	Nombre
FROM
	Proveedor
WHERE
	Ciudad = 'La Plata';


/* -------------------------------- Answer 02 ------------------------------- */
SELECT
	CodArt
FROM
	Articulo
WHERE
	Precio < 10;


/* -------------------------------- Answer 03 ------------------------------- */
SELECT
	Responsable
FROM
	Almacen;


/* -------------------------------- Answer 04 ------------------------------- */
SELECT
	CodMat
FROM
	Provisto_Por
WHERE
	CodProv = 3
	AND CodMat NOT IN (
		SELECT
			CodMat
		FROM
			Provisto_Por
		WHERE
			CodProv = 5
	);


/* -------------------------------- Answer 05 ------------------------------- */
SELECT
	Nro
FROM
	Tiene
WHERE
	CodArt = 1;


/* -------------------------------- Answer 06 ------------------------------- */
SELECT
	CodProv
FROM
	Proveedor
WHERE
	Ciudad = 'Pergamino'
	AND Nombre LIKE '%Perez';


/* -------------------------------- Answer 07 ------------------------------- */
SELECT
	Nro
FROM
	Tiene
WHERE
	CodArt = 'B'
	AND Nro IN (
		SELECT
			Nro
		FROM
			Tiene
		WHERE
			CodArt = 'A'
	);


/* -------------------------------- Answer 08 ------------------------------- */
SELECT
	CodArt
FROM
	Articulo
WHERE
	Precio > 100
	OR CodArt IN (
		SELECT
			CodArt
		FROM
			Compuesto_Por
		WHERE
			CodMat = 1
	);
