/* -------------------------------- Answer 01 ------------------------------- */
-- Listar a las personas que no tienen ninguna cuenta en "pesos argentinos" en Ningún banco. Que además tengan al menos dos cuentas en "dólares"
SELECT
	*
FROM
	Persona P1
WHERE
	p1.Pasaporte NOT IN (
		SELECT
			idPersona
		FROM
			Cuenta c
			JOIN Moneda m ON m.id = c.idMoneda
		WHERE
			m.descripcion = 'Peso Argentino'
	)
	AND EXISTS (
		SELECT
			1
		FROM
			Cuenta c
			JOIN Moneda m ON m.id = c.idMoneda
		WHERE
			c.idPersona = p1.Pasaporte
			AND m.descripcion = 'dolar'
		GROUP BY
			idPersona
		HAVING
			COUNT(DISTINCT idBanco) >= 2
	);


/* -------------------------------- Answer 02 ------------------------------- */
CREATE VIEW
	monedas_en_todos_los_bancos AS
SELECT
	*
FROM
	moneda m
WHERE
	NOT EXISTS (
		SELECT
			1
		FROM
			banco b
		WHERE
			NOT EXISTS (
				SELECT
					1
				FROM
					opera o
				WHERE
					o.idmoneda = m.id
					AND o.idbanco = b.id
			)
	);


SELECT
	id,
	descripcion
FROM
	monedas_en_todos_los_bancos
WHERE
	valororo >= (
		SELECT
			MAX(valororo)
		FROM
			monedas_en_todos_los_bancos
	);
