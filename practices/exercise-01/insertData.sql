INSERT INTO
	Almacen
VALUES
	(1, 'Juan Perez'),
	(2, 'Jose Basualdo'),
	(3, 'Rogelio Rodriguez');


INSERT INTO
	Articulo
VALUES
	(1, 'Sandwich JyQ', 5),
	(2, 'Pancho', 6),
	(3, 'Hamburguesa', 10),
	(4, 'Hamburguesa completa', 15);


INSERT INTO
	Material
VALUES
	(1, 'Pan'),
	(2, 'Jamon'),
	(3, 'Queso'),
	(4, 'Salchicha'),
	(5, 'Pan Pancho'),
	(6, 'Paty'),
	(7, 'Lechuga'),
	(8, 'Tomate');


INSERT INTO
	Proveedor
VALUES
	(
		1,
		'Panadería Carlitos',
		'Carlos Calvo 1212',
		'CABA'
	),
	(
		2,
		'Fiambres Perez',
		'San Martin 121',
		'Pergamino'
	),
	(
		3,
		'Almacen San Pedrito',
		'San Pedrito 1244',
		'CABA'
	),
	(4, 'Carnicería Boedo', 'Av. Boedo 3232', 'CABA'),
	(5, 'Verdulería Platense', '5 3232', 'La Plata');


INSERT INTO
	Tiene
VALUES
	/* Juan Perez */
	(1, 1),
	/* Jose Basualdo */
	(2, 1),
	(2, 2),
	(2, 3),
	(2, 4),
	/* Rogelio Rodriguez */
	(3, 3),
	(3, 4);


INSERT INTO
	Compuesto_Por
VALUES
	/* Sandwich JyQ */
	(1, 1),
	(1, 2),
	(1, 3),
	/* Pancho */
	(2, 4),
	(2, 5),
	/* Hamburguesa */
	(3, 1),
	(3, 6),
	/* Hamburguesa completa */
	(4, 1),
	(4, 6),
	(4, 7),
	(4, 8);


INSERT INTO
	Provisto_Por
VALUES
	/* Pan */
	(1, 1),
	(1, 3),
	/* Jamon */
	(2, 2),
	(2, 3),
	(2, 4),
	/* Queso */
	(3, 2),
	(3, 3),
	/* Salchicha */
	(4, 3),
	(4, 4),
	/* Pan Pancho */
	(5, 1),
	(5, 3),
	/* Paty */
	(6, 3),
	(6, 4),
	/* Lechuga */
	(7, 3),
	(7, 5),
	/* Tomate */
	(8, 3),
	(8, 5);
