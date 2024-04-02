--CREANDO TABLAS 

CREATE TABLE Clientes (
documento NUMBER NOT NULL,
edad NUMBER NOT NULL,
telefono NUMBER NOT NULL, 
nombre CHAR(50)NOT NULL,
correo CHAR(50)NOT NULL
);

CREATE TABLE UsuarioClientes (
documento NUMBER NOT NULL,
fechaInscripcion DATE NOT NULL,
tarjetaDeCredito NUMBER NOT NULL,
idProceso NUMBER NOT NULL,
idContrato NUMBER NOT NULL
);

CREATE TABLE CondicionesI(
documento NUMBER NOT NULL,
nivel CHAR(1) NOT NULL,
lesion CHAR(50),
observaciones CHAR(50),
fecha DATE NOT NULL
);

CREATE TABLE Procesos(
idProceso NUMBER NOT NULL,
pesoInicial NUMBER NOT NULL,
pesoFinal NUMBER NOT NULL,
pesoObjetivo NUMBER NOT NULL,
observaciones CHAR(50),
fecha DATE NOT NULL
);

CREATE TABLE Contratos(
idContrato NUMBER NOT NULL,
tiempo NUMBER NOT NULL,
servicio CHAR(50) NOT NULL,
estado CHAR(2) NOT NULL,
documento NUMBER NOT NULL
);

CREATE TABLE Clases(
fecha DATE NOT NULL,
hora DATE NOT NULL,
asistencia CHAR(2) NOT NULL,
idContrato NUMBER NOT NULL
);

CREATE TABLE pago(
idPago NUMBER NOT NULL,
total NUMBER NOT NULL,
descuento NUMBER,
idContrato NUMBER NOT NULL,
idBono NUMBER
);

CREATE TABLE pagosfacturas(
idPago NUMBER NOT NULL,
idFactura NUMBER NOT NULL,
fecha DATE NOT NULL
);
CREATE TABLE facturas(
idPago NUMBER NOT NULL,
idFactura NUMBER NOT NULL
);

CREATE TABLE Bonos(
idBono NUMBER NOT NULL,
cantidad NUMBER,
estado CHAR(2) NOT NULL,
fecha DATE NOT NULL
);


CREATE TABLE profesionalClientes (
documento NUMBER NOT NULL,
tipo CHAR(2) NOT NULL,
tarjetaDeCredito NUMBER NOT NULL,
experiencia NUMBER
);

CREATE TABLE historialesTrabajos(
idHistorial NUMBER NOT NULL,
calificación NUMBER(1) NOT NULL,
contratosActivos NUMBER NOT NULL,
contratosTotal NUMBER NOT NULL,
documento NUMBER NOT NULL
); 

CREATE TABLE entrenador(
documento NUMBER NOT NULL,
especialidad CHAR(50) NOT NULL
);   

CREATE TABLE nutricionista(
documento NUMBER NOT NULL,
especialidad CHAR(50) NOT NULL
);   

CREATE TABLE certificaciones(
idCertificacion NUMBER NOT NULL,
documento NUMBER NOT NULL,
instituto CHAR(50) NOT NULL,
ciudad CHAR(50) NOT NULL,
categoría CHAR(3) NOT NULL,
descripcion CHAR(50) NOT NULL
);
CREATE TABLE horariosClases(
horario CHAR(50),
documento NUMBER NOT NULL
);


-- Llaves Primarias (PK)
//CLIENTES
ALTER TABLE clientes ADD CONSTRAINT PK_CLIENTES
    PRIMARY KEY (documento);
//USUARIOCLIENTES
ALTER TABLE usuarioclientes ADD CONSTRAINT PK_USUARIOCLIENTES
    PRIMARY KEY (documento);
//CONDICIONESI
ALTER TABLE condicionesI ADD CONSTRAINT PK_CONDICIONESI
    PRIMARY KEY (documento);
//PROCESOS
ALTER TABLE procesos ADD CONSTRAINT PK_PROCESOS
    PRIMARY KEY (idProceso);
//CONTRATOS
ALTER TABLE contratos ADD CONSTRAINT PK_CONTRATOS
    PRIMARY KEY (idContrato);
//CLASES
ALTER TABLE clases ADD CONSTRAINT PK_CLASES
    PRIMARY KEY (idContrato);
//PAGO
ALTER TABLE pago ADD CONSTRAINT PK_PAGO
    PRIMARY KEY (idPago);
//PAGOSFACTURAS
ALTER TABLE pagosfacturas ADD CONSTRAINT PK_PAGOSFACTURAS
    PRIMARY KEY (idPago,idFactura);
//FACTURAS
ALTER TABLE facturas ADD CONSTRAINT PK_FACTURAS
    PRIMARY KEY (idFactura);
//BONOS
ALTER TABLE bonos ADD CONSTRAINT PK_BONOS
    PRIMARY KEY (idBono);
//PROFESIONALCLIENTES
ALTER TABLE profesionalclientes ADD CONSTRAINT PK_PROFESIONALCLIENTES
    PRIMARY KEY (documento);
//HISTORIALESTRABAJOS
ALTER TABLE historialestrabajos ADD CONSTRAINT PK_HISTORIALESTRABAJOS
    PRIMARY KEY (idHistorial);
//ENTRENADOR
ALTER TABLE entrenador ADD CONSTRAINT PK_ENTRENADOR
    PRIMARY KEY (documento);
//NUTRICIONISTA
ALTER TABLE nutricionista ADD CONSTRAINT PK_NUTRICIONISTA
    PRIMARY KEY (documento);
//CERTIFICACIONES
ALTER TABLE certificaciones ADD CONSTRAINT PK_CERTIFICACIONES
    PRIMARY KEY (idCertificacion, documento);
//HORARIOSCLASES
ALTER TABLE horariosclases ADD CONSTRAINT PK_HORARIOSCLASES
    PRIMARY KEY (documento);

-- Llaves foráneas (FK)
ALTER TABLE usuarioclientes ADD CONSTRAINT FK_UsuarioClientes_Clientes FOREIGN KEY (documento) REFERENCES Clientes(documento);
ALTER TABLE usuarioclientes ADD CONSTRAINT FK_UsuarioClientes_Procesos FOREIGN KEY (idProceso) REFERENCES Procesos(idProceso);
ALTER TABLE usuarioclientes ADD CONSTRAINT FK_UsuarioClientes_Contratos FOREIGN KEY (idContrato) REFERENCES Contratos(idContrato);
ALTER TABLE condicionesI ADD CONSTRAINT FK_UsuarioClientes_CondicionesI FOREIGN KEY (documento) REFERENCES UsuarioClientes(documento); 
ALTER TABLE clases ADD CONSTRAINT FK_Clases_Contratos FOREIGN KEY (idContrato) REFERENCES Contratos(idContrato);
ALTER TABLE pago ADD CONSTRAINT FK_Pago_Contratos FOREIGN KEY (idContrato) REFERENCES Contratos(idContrato);
ALTER TABLE pago ADD CONSTRAINT FK_Pago_Bonos FOREIGN KEY (idBono) REFERENCES Bonos(idBono);
ALTER TABLE pagosfacturas ADD CONSTRAINT FK_PagosFacturas_Pago FOREIGN KEY (idPago) REFERENCES Pago(idPago);
ALTER TABLE pagosfacturas ADD CONSTRAINT FK_PagosFacturas_Facturas FOREIGN KEY (idFactura) REFERENCES Facturas(idFactura);
ALTER TABLE facturas ADD CONSTRAINT FK_Facturas_Pago FOREIGN KEY (idPago) REFERENCES Pago(idPago);
ALTER TABLE profesionalclientes ADD CONSTRAINT FK_ProfesionalClientes_Clientes FOREIGN KEY (documento) REFERENCES Clientes(documento);
ALTER TABLE historialestrabajos ADD CONSTRAINT FK_HistorialesTrabajos_ProfesionalClientes FOREIGN KEY (documento) REFERENCES profesionalClientes(documento);
ALTER TABLE entrenador ADD CONSTRAINT FK_Entrenador_ProfesionalClientes FOREIGN KEY (documento) REFERENCES profesionalClientes(documento);
ALTER TABLE nutricionista ADD CONSTRAINT FK_Nutricionista_ProfesionalClientes FOREIGN KEY (documento) REFERENCES profesionalClientes(documento);
ALTER TABLE  certificaciones ADD CONSTRAINT FK_Certificaciones_ProfesionalClientes FOREIGN KEY (documento) REFERENCES profesionalClientes(documento);
ALTER TABLE horariosClases ADD CONSTRAINT FK_HorariosClases_ProfesionalClientes FOREIGN KEY (documento) REFERENCES profesionalClientes(documento);

//TIPOS

//TAsistencia

ALTER TABLE clases ADD CONSTRAINT TIPO_TASISTENCIA 
CHECK (asistencia IN ('SI', 'NO'));

//TCalifiacion

ALTER TABLE historialesTrabajos ADD CONSTRAINT TIPO_TCALIFICACION
	CHECK (5 >= calificacion and calificacion >= 0);

//TCategoría

ALTER TABLE certificaciones ADD CONSTRAINT TIPO_TCATEGORIA 
CHECK (categoria  IN ('LIC','TEC', 'TIT','CUR'));

//TCorreo

ALTER TABLE clientes ADD CONSTRAINT TIPO_TCORREO 
CHECK (INSTR(correo, '@') > 0 AND INSTR(SUBSTR(correo, INSTR(correo, '@') + 1), '.') > 0);

//TEstado

ALTER TABLE contratos ADD CONSTRAINT TIPO_TESTADO 
CHECK (estado IN ('IN', 'AC'));

//TNivel

ALTER TABLE condicionesI ADD CONSTRAINT TIPO_TNIVEL 
CHECK (nivel  IN ('P','I', 'E'));

//TTipo

ALTER TABLE profesionalclientes ADD CONSTRAINT TIPO_TTipo 
CHECK (tipo  IN ('EN', 'NU'));

-- Borra Tablas
drop table condicionesI;
drop table clases;
drop table pagosfacturas;
drop table facturas;
drop table historialestrabajos;
drop table entrenador;
drop table nutricionista;
drop table certificaciones;
drop table horariosClases;
drop table usuarioclientes;
drop table procesos;
drop table pago;
drop table bonos;
drop table profesionalclientes;
drop table clientes;
drop table contratos;

