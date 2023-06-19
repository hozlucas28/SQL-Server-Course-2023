/* -------------------------------- Answer 01 ------------------------------- */
CREATE VIEW
	exposicion_cantidadObras AS
SELECT DISTINCT
	e.id_galeria,
	e.id_tematica,
	e.fecha,
	COUNT(id_obra) AS cantObras
FROM
	exposicion e
GROUP BY
	e.id_galeria,
	e.id_tematica,
	e.fecha;


CREATE VIEW
	exposicion_obrasMax AS
SELECT
	e.id_galeria,
	e.id_tematica,
	e.fecha
FROM
	exposicion_cantidadObras
WHERE
	cantObras = (
		SELECT
			MAX(cantObras)
		FROM
			exposicion_cantidadObras
	);


CREATE VIEW
	geleria_todasTematicas AS
SELECT
	id_galeria,
	COUNT(id_tematica) tematicasPresentadas
FROM
	exposicion
GROUP BY
	id_galeria
HAVING
	tematicasPresentadas = (
		SELECT
			COUNT(*)
		FROM
			tematicas
	);


CREATE VIEW
	galeria_todosTiposObra AS
SELECT
	id_galeria,
	COUNT(o.id_tipo) cantidadTiposObra
FROM
	exposicion e
	JOIN obra o ON e.id_obra = o.id
GROUP BY
	id_galeria
HAVING
	cantidadTiposObra = (
		SELECT
			COUNT(*)
		FROM
			tipoDeObra
	);


SELECT
	*
FROM
	exposicion_obrasMax
WHERE
	id_galeria IN (
		SELECT
			id_galeria
		FROM
			galeria_todasTematicas
	)
	OR id_galeria IN (
		SELECT
			id_galeria
		FROM
			galeria_todosTiposObra
	);
