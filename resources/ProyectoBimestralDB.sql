drop database if exists HyprDeskDB_PFB3;
create database HyprDeskDB_PFB3;
use HyprDeskDB_PFB3;

create table Usuarios(
	codigoUsuario int auto_increment,
    nombreUsuario varchar(64) not null,
    apellidoUsuario varchar(64) not null,
    telefono varchar(16) not null,
	direccionUsuario varchar(128) not null,
    email varchar(128) not null,
    contrasena varchar(64) not null,
    estadoUsuario varchar(32) default 'Activo',
    fechaCreacion datetime default current_timestamp,
    fechaNacimiento date,
    constraint pk_usuarios primary key (codigoUsuario)
);

create table Marcas(
	codigoMarca int auto_increment,
    nombreMarca varchar(64) not null,
    descripcion varchar(128) not null,
    estadoMarca varchar(32) default 'Disponible',
    constraint pk_marcas primary key (codigoMarca)
);

create table Categorias(
	codigoCategoria int auto_increment,
    nombreCategoria varchar(64) not null,
    descripcionCategoria varchar(128) not null,
    constraint pk_categorias primary key (codigoCategoria)
);

create table Productos(
	codigoProducto int auto_increment,
    nombreProducto varchar(64) not null,
    descripcionProducto varchar(128) not null,
    precioProducto decimal(10,2) default 0.00,
    stock int not null,
    fechaEntrada datetime default current_timestamp,
    fechaSalida datetime,
    codigoMarca int,
    codigoCategoria int,
    constraint pk_productos primary key (codigoProducto),
    constraint fk_Productos_Marcas foreign key (codigoMarca)
		references Marcas(codigoMarca),
	constraint fk_Productos_Categorias foreign key (codigoCategoria)
		references Categorias(codigoCategoria)
);

CREATE TABLE MetodoPagos (
    codigoMetodoPago int auto_increment,
    tipoMetodo VARCHAR(64) NOT NULL,
    CONSTRAINT pk_metodo_pagos PRIMARY KEY (codigoMetodoPago)
);

create table DetalleMetodoPagos(
	codigoDetalleMetodoPago int auto_increment,
    numeroCuenta varchar(128) not null,
    fechaExpiracion varchar(16) not null,
    nombreTitular varchar(64) not null,
    codigoUsuario int,
    codigoMetodoPago int,
    constraint pk_Detalle_Metodo_Pagos primary key (codigoDetalleMetodoPago),
    constraint fk_Detalle_Metodo_Pagos_Usuarios foreign key (codigoUsuario)
		references Usuarios(codigoUsuario),
	constraint fk_Detalle_Metodo_Pagos_Metodo_Pagos foreign key (CodigoMetodoPago)
		references MetodoPagos(CodigoMetodoPago)
);

create table Pedidos(
	codigoPedido int auto_increment,
    fechaPedido datetime,
    estadoPedido varchar(64) not null,
    totalPedido decimal(10,2) default 0.00,
    direccionPedido varchar(128) not null,
    codigoMetodoPago int,
    codigoDetalleMetodoPago int,
    codigoUsuario int,
    constraint pk_pedidos primary key (codigoPedido),
    constraint fk_Pedidos_Metodo_Pagos foreign key (codigoMetodoPago)
		references MetodoPagos(codigoMetodoPago),
	constraint fk_Pedidos_Detalle_Metodo_Pagos foreign key (CodigoDetalleMetodoPago)
		references DetalleMetodoPagos(CodigoDetalleMetodoPago),
	constraint fk_Pedidos_Usuarios foreign key (codigoUsuario)
		references Usuarios(codigoUsuario)
);

create table DetallePedidos(
	codigoDetallePedido int auto_increment,
    cantidad int not null,
    precio decimal(10,2) default 0.00,
    subtotal decimal(10,2) default 0.00,
    codigoPedido int,
    codigoProducto int,
    constraint pk_detalle_pedidos primary key (codigoDetallePedido),
    constraint fk_Detalle_Pedidos_Pedidos foreign key (codigoPedido)
		references Pedidos(codigoPedido),
	constraint fk_Detalle_Pedidos_Productos foreign key (codigoProducto)
		references Productos(codigoProducto)
);