/* -------------------------------- Answer 01 ------------------------------- */
SELECT DISTINCT
	A.*
FROM
	Alumno A
	JOIN Almuerza_En AE ON A.DNI = AE.DniAlumno
WHERE
	A.CodEscuela <> AE.CodEscuela
	AND A.CodEscuela NOT IN (
		SELECT
			CodEscuela
		FROM
			almuerza_en
	);


/* -------------------------------- Answer 02 ------------------------------- */
SELECT DISTINCT
	CodEscuela
FROM
	almuerza_en
WHERE
	CodEscuela NOT IN (
		SELECT DISTINCT
			E1.CodEscuela
		FROM
			Alumno E1
		WHERE
			NOT EXISTS (
				SELECT
					1
				FROM
					Almuerza_En E2
					JOIN Alumno A ON A.DNI = E2.DniAlumno
				WHERE
					DNI NOT IN (
						SELECT
							DniAlumno
						FROM
							Hermano_De
						GROUP BY
							DniAlumno
						HAVING
							COUNT(1) > 2
					)
					AND E1.DNI = E2.DniAlumno
					AND E1.CodEscuela = E2.CodEscuela
			)
	);
