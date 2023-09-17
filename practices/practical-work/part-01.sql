-- Trabajo práctico Integrador – Unidad 1 parte 2
--
-- Luego de decidirse por un motor de base de datos relacional (le recomendamos SQL Server para 
-- aplicar lo que se verá en la unidad 3, pero pueden escoger otro siempre que sea relacional si lo 
-- desean), llegó el momento de generar la base de datos.
--
-- Deberá instalar el DMBS y documentar el proceso. No incluya capturas de pantalla. Detalle las 
-- configuraciones aplicadas (ubicación de archivos, memoria asignada, seguridad, puertos, etc.) 
-- en un documento como el que le entregaría al DBA.
--
-- Cree la base de datos, entidades y relaciones. Incluya restricciones y claves. Deberá entregar un 
-- archivo .sql con el script completo de creación (debe funcionar si se lo ejecuta “tal cual” es 
-- entregado). Incluya comentarios para indicar qué hace cada módulo de código.
--
-- Genere store procedures para manejar la inserción, modificado, borrado (si corresponde, 
-- también debe decidir si determinadas entidades solo admitirán borrado lógico) de cada tabla.
--
-- Los nombres de los store procedures NO deben comenzar con “SP”. Genere esquemas para 
-- organizar de forma lógica los componentes del sistema y aplique esto en la creación de objetos. 
-- NO use el esquema “dbo”.
--
-- El archivo .sql con el script debe incluir comentarios donde consten este enunciado, la fecha de 
-- entrega, número de grupo, nombre de la materia, nombres y DNI de los alumnos.
--
-- Se presenta un modelo de base de datos a implementar por el hospital Cure SA, para la reserva 
-- de turnos médicos y la visualización de estudios clínicos realizados (ver archivo Clinica Cure 
-- SA.png).
--
-- Para facilitar la lectura del diagrama se informa la identificación de la cardinalidad en las 
-- relaciones [Imagen]
--
-- Aclaraciones:
--
-- El modelo es el esquema inicial, en caso de ser necesario agregue las relaciones/entidades que 
-- sean convenientes.
--
-- Los turnos para estudios clínicos no se encuentran dentro del alcance del desarrollo del 
-- sistema actual.
--
-- Los estudios clínicos son ingresados al sistema por el técnico encargado de realizar el estudio, 
-- una vez finalizado el estudio (en el caso de las imágenes) y en el caso de los laboratorios cuando 
-- el mismo se encuentre terminado.
--
-- Los turnos para atención médica tienen como estado inicial disponible, según el médico, la 
-- especialidad y la sede.
--
-- Los prestadores están conformador por Obras Sociales y Prepagas con las cuales se establece 
-- una alianza comercial. Dicha alianza puede finalizar en cualquier momento, por lo cual debe 
-- poder ser actualizable de forma inmediata si el contrato no está vigente. En caso de no estar 
-- vigente el contrato, deben ser anulados todos los turnos de pacientes que se encuentren 
-- vinculados a esa prestadora y pasar a estado disponible.
--
-- Los estudios clínicos deben ser autorizados, e indicar si se cubre el costo completo del mismo o 
-- solo un porcentaje. El sistema de Cure se comunica con el servicio de la prestadora, se le envía 
-- el código del estudio, el dni del paciente y el plan; el sistema de la prestadora informa si está 
-- autorizado o no y el importe a facturarle al paciente.
--
-- Los roles establecidos al inicio del proyecto son:
-- • Paciente
-- • Medico
-- • Personal Administrativo
-- • Personal Técnico clínico
-- • Administrador General
--
-- El usuario web se define utilizando el DNI.
-- Información del trabajo práctico
-- Fecha de entrega: TODO
-- Número de grupo: 2
-- Materia: Bases de Datos Aplicadas
-- Integrantes:
-- • Lucas Ariel Clivio - 43.308.587
-- • Alexis Ezequiel Castillo - 43.991.136
-- • Lucas Nahuel Hoz - 43.920.122
-- • Gonzalo Ezequiel Sosa - 43.458.499
-- Creación de la base de datos de CURE S.A
CREATE database cure_sa;


use cure_sa;


/* ------------------------------- Referencias ------------------------------ */
-- Creación del esquema de referencias
CREATE schema referencias;


-- Creación de la tabla "Géneros"
CREATE TABLE
	referencias.generos (
		id_genero INT IDENTITY (1, 1),
		nombre VARCHAR(50) NOT NULL,
		CONSTRAINT pk_id_genero PRIMARY key (id_genero)
	)
	-- Creación de la tabla "Países"
CREATE TABLE
	referencias.paises (
		id_pais INT IDENTITY (1, 1),
		nombre VARCHAR(50) NOT NULL,
		gentilicio VARCHAR(50) NOT NULL,
		CONSTRAINT pk_id_pais PRIMARY key (id_pais)
	);


-- Creación de la tabla "Nombres de provincias"
CREATE TABLE
	referencias.nombres_provincias (
		id_provincia INT IDENTITY (1, 1),
		nombre VARCHAR(50) NOT NULL,
		id_pais INT NOT NULL,
		CONSTRAINT pk_id_provincia PRIMARY key (id_provincia),
		CONSTRAINT fk_id_pais_nombres_provincias FOREIGN key (id_pais) REFERENCES referencias.paises (id_pais)
	);


-- Creación de la tabla "Nombres de localidades" :sask
CREATE TABLE
	referencias.nombres_localidades (
		id_localidad INT IDENTITY (1, 1),
		nombre VARCHAR(50) NOT NULL,
		CONSTRAINT pk_id_localidad PRIMARY key (id_localidad)
	);


-- Creación de la tabla de direcciones
-- apuntar a solo localidad? :sask
CREATE TABLE
	referencias.direcciones (
		id_pais INT NOT NULL,
		id_provincia INT NOT NULL,
		id_localidad INT NOT NULL,
		id_direccion INT IDENTITY (1, 1),
		calle VARCHAR(50) NOT NULL,
		numero INT NOT NULL,
		cod_postal SMALLINT NOT NULL,
		piso SMALLINT,
		departamento SMALLINT,
		CONSTRAINT pk_id_direccion PRIMARY key (id_direccion),
		CONSTRAINT fk_id_pais_direcciones FOREIGN key (id_pais) REFERENCES referencias.paises (id_pais),
		CONSTRAINT fk_id_provincia FOREIGN key (id_provincia) REFERENCES referencias.nombres_provincias (id_provincia),
		CONSTRAINT fk_id_localidad FOREIGN key (id_localidad) REFERENCES referencias.nombres_localidades (id_localidad)
	)
	-- Creación de la tabla "Tipo de documento"
CREATE TABLE
	referencias.tipos_documentos (
		id_tipo_documento INT IDENTITY (1, 1),
		nombre VARCHAR(50) NOT NULL,
		CONSTRAINT pk_id_tipo_documento PRIMARY key (id_tipo_documento)
	);


/* ---------------------------------- Datos --------------------------------- */
-- Creación del esquema de datos (logica de negocio)
CREATE schema datos;


-- Creación de la tabla "Pacientes"
CREATE TABLE
	datos.pacientes (
		id_paciente INT IDENTITY (1, 1), --pk -- historia clinica
		id_cobertura INT, --fk
		id_direccion INT, --fk -- domicilio
		id_tipo_documento INT NOT NULL,
		nro_documento VARCHAR(50) NOT NULL, -- Poner un index no cluster aca? :clivio 
		nombre nvarchar (50) NOT NULL,
		apellido nvarchar (50) NOT NULL,
		apellido_materno nvarchar (50),
		fecha_nacimiento DATE NOT NULL,
		sexo_biologico CHAR(1), -- M o F -- castear uppercase
		id_genero INT NOT NULL, -- fk
		nacionalidad INT, --fk 
		foto_perfil image,
		email nvarchar (70) NOT NULL,
		tel_fijo VARCHAR(20) NOT NULL, -- check de solo numeros :sask
		tel_alternativo VARCHAR(20),
		tel_laboral VARCHAR(20),
		fecha_registro DATE DEFAULT CAST(GETDATE () AS DATE), -- un constraint para que sea default now()? :clivio -- current timestamp
		fecha_actualizacion DATE, --- TRIGGER :sask
		usuario_actualizacion INT, --fk -- nose que es esto xd :clivio -- TRIGGER
		CONSTRAINT pk_id_paciente PRIMARY key (id_paciente),
		CONSTRAINT fk_id_cobertura_pacientes FOREIGN key (id_cobertura) REFERENCES coberturas (id_cobertura),
		CONSTRAINT fk_id_direccion_pacientes FOREIGN key (id_direccion) REFERENCES referencias.direcciones (id_direccion),
		CONSTRAINT fk_id_tipo_documento FOREIGN key (id_tipo_documento) REFERENCES referencias.tipos_documentos (id_tipo_documento),
		CONSTRAINT fk_id_genero FOREIGN key (id_genero) REFERENCES referencias.generos (id_genero),
		CONSTRAINT fk_id_nacionalidad FOREIGN key (nacionalidad) REFERENCES referencias.paises (id_pais)
	);


-- Creación de la tabla "Estudios"
CREATE TABLE
	datos.estudios (
		id_estudio INT IDENTITY (1, 1),
		fecha DATE NOT NULL,
		nombre_estudio VARCHAR(60) NOT NULL,
		autorizado bit DEFAULT 1, -- tipo de borrado logico 
		documento_resultado image,
		imagen_resultado image,
		id_paciente INT, -- index cluster aca? :clivio -- historia clinica
		CONSTRAINT pk_id_estudio PRIMARY key (id_estudio),
		CONSTRAINT fk_id_paciente_estudio FOREIGN key (id_paciente) REFERENCES datos.pacientes (id_paciente)
	);


-- Creación de la tabla "Usuarios"
CREATE TABLE
	datos.usuarios (
		id_usuario INT IDENTITY (1, 1),
		contraseña VARCHAR(256), -- hashear?
		id_paciente INT,
		fecha_creacion DATE DEFAULT CAST(GETDATE () AS DATE), -- default now() ?
		CONSTRAINT pk_id_usuario PRIMARY key (id_usuario),
		CONSTRAINT fk_id_paciente_usuario FOREIGN key (id_paciente) REFERENCES datos.pacientes (id_paciente)
	);


-- Creación de la tabla "Coberturas"
CREATE TABLE
	datos.coberturas (
		id_cobertura INT IDENTITY (1, 1),
		imagen_credencial image,
		nro_socio VARCHAR(30) NOT NULL,
		fecha_registro DATE DEFAULT CAST(GETDATE () AS DATE), --objecion :sask 
		CONSTRAINT pk_id_cobertura PRIMARY key (id_cobertura),
	);


-- Creación de la tabla "Prestadoras"
CREATE TABLE
	datos.prestadores (
		id_prestador INT IDENTITY (1, 1),
		nombre VARCHAR(50) NOT NULL,
		plan_prestador VARCHAR(30) NOT NULL, -- hacer tabla con planes? :clivio -- si :sask
		id_cobertura INT, -- revisar :sask
		CONSTRAINT pk_id_prestador PRIMARY key (id_prestador),
		CONSTRAINT fk_id_cobertura FOREIGN key (id_cobertura) REFERENCES datos.coberturas (id_cobertura)
	);


-- Creación de la tabla "Turnos médicos"
CREATE TABLE
	datos.reservas_turnos_medicos (
		id_turno INT IDENTITY (1, 1),
		fecha DATE DEFAULT now (),
		hora TIME DEFAULT CAST(GETDATE () AS TIME), -- revisar
		id_medico INT NOT NULL,
		id_especialidad INT NOT NULL,
		id_direccion_atencion INT NOT NULL,
		id_estado_turno INT NOT NULL,
		id_tipo_turno INT NOT NULL,
		id_paciente INT NOT NULL,
		id_dias_x_sede INT NOT NULL,
		CONSTRAINT pk_id_turno PRIMARY key (id_turno),
		CONSTRAINT fk_id_tipo_turno FOREIGN key (id_tipo_turno) REFERENCES datos.tipos_turnos (id_tipo_turno),
		CONSTRAINT fk_id_estado FOREIGN key (id_tipo_turno) REFERENCES datos.estados_turnos (id_estado),
		CONSTRAINT fk_id_paciente_turno FOREIGN key (id_paciente) REFERENCES datos.pacientes (id_paciente),
		CONSTRAINT fk_id_dias_x_sede FOREIGN key (id_dias_x_sede) REFERENCES datos.dias_x_sede (id_sede)
	);


-- Creación de la tabla "Estado del turno"
CREATE TABLE
	datos.estados_turnos (
		id_estado INT IDENTITY (1, 1),
		nombre VARCHAR(30) CHECK (
			UPPER(nombre) LIKE 'ANTENDIDO'
			OR UPPER(nombre) LIKE 'AUSENTE'
			OR UPPER(nombre) LIKE 'CANCELADO'
		), -- referencia a estados :sask
		CONSTRAINT pk_id_estado_turno PRIMARY key (id_estado)
	);


-- Creación de la tabla "Tipo de turno"
CREATE TABLE
	datos.tipos_turnos (
		id_tipo_turno INT IDENTITY (1, 1),
		nombre_tipo VARCHAR(30) CHECK (
			UPPER(nombre_tipo) LIKE 'PRESENCIAL'
			OR UPPER(nombre_tipo) LIKE 'VIRTUAL'
		),
		CONSTRAINT pk_tipo_turno PRIMARY key (tipo_turno)
	);


-- Creación de la tabla "Días x Sede"
CREATE TABLE
	datos.dias_x_sede (
		id_sede INT IDENTITY (1, 1),
		id_medico INT NOT NULL,
		id_sede_de_atencion INT NOT NULL,
		dia DATE NOT NULL,
		hora_inicio TIME NOT NULL, -- los turnos son de 15 min => manejar en una funcion eso :sask
		CONSTRAINT fk_id_medico FOREIGN key (id_medico) REFERENCES datos.medicos (id_medico),
		CONSTRAINT fk_id_sede_de_atencion FOREIGN key (id_sede_de_atencion) REFERENCES datos.sede_de_atencion (id_sede),
		CONSTRAINT pk_id_sede PRIMARY key (id_sede)
	);


-- Creación de la tabla "Sede de atención"
CREATE TABLE
	datos.sede_de_atencion (
		id_sede INT IDENTITY (1, 1),
		nombre VARCHAR(100) NOT NULL,
		direccion INT,
		CONSTRAINT pk_id_medico_sede_de_atención PRIMARY key (id_sede),
		CONSTRAINT fk_id_direccion FOREIGN key (direccion) REFERENCES referencias.direcciones (id_direccion)
	);


-- Creación de la tabla "Médicos"
CREATE TABLE
	datos.medicos (
		id_medico INT IDENTITY (1, 1),
		nombre nvarchar (50) NOT NULL,
		apellido nvarchar (50) NOT NULL,
		nro_matricula INT NOT NULL, -- esta bien? :sask
		id_especialidad INT,
		CONSTRAINT pk_id_medico PRIMARY key (id_medico),
		CONSTRAINT fk_id_especialidad FOREIGN key (id_especialidad) REFERENCES datos.especialidad (id_especialidad)
	);


-- Creación de la tabla "Especialidad"
CREATE TABLE
	datos.especialidad (
		id_especialidad INT IDENTITY (1, 1),
		nombre VARCHAR(50) NOT NULL,
		CONSTRAINT pk_id_especialidad PRIMARY key (id_especialidad)
	);
