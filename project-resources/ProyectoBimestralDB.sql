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
    estadoUsuario enum('Activo', 'Inactivo', 'Suspendido') default 'Activo',
    fechaCreacion datetime default current_timestamp,
    fechaNacimiento date,
    constraint pk_usuarios primary key (codigoUsuario)
);

create table Marcas(
	codigoMarca int auto_increment,
    nombreMarca varchar(64) not null,
    descripcion varchar(128) not null,
    estadoMarca enum('Disponible', 'No disponible') default 'Disponible',
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

create table Tarjetas (
    codigoTarjeta int auto_increment,
    codigoUsuario int not null,
    ultimos_4 char(4) not null,
    marca enum('Visa', 'MasterCard', 'Amex', 'Discover', 'Otro') not null,
    token varchar(36) not null,
    fechaExpiracion date not null,
    nombreTitular varchar(40) not null,
    tipoTarjeta enum('Crédito', 'Débito', 'Prepago') default 'Crédito',
    fechaRegistro datetime default current_timestamp,
    constraint pk_tarjetas primary key (codigoTarjeta),
    constraint fk_tarjeta_usuario foreign key (codigoUsuario) references Usuarios(codigoUsuario)
);


create table Recibos(
	codigoRecibo int auto_increment,
    fechaPago datetime default current_timestamp,
    monto decimal(10,2) not null,
    metodoPago varchar(64) not null,
    codigoUsuario int,
    codigoTarjeta int,
    constraint pk_recibos primary key (codigoRecibo),
    constraint fk_recibo_usuario foreign key (codigoUsuario)
		references Usuarios(codigoUsuario),
	constraint fk_recibo_tarjetas foreign key (codigoTarjeta)
		references Tarjetas(codigoTarjeta)
);

create table Pedidos(
	codigoPedido int auto_increment,
    fechaPedido datetime default current_timestamp,
    estadoPedido enum('Pendiente', 'En proceso', 'Enviado', 'Entregado', 'Cancelado') not null,
    totalPedido decimal(10,2) default 0.00,
    direccionPedido varchar(128) not null,
    codigoRecibo int,
    codigoUsuario int,
	constraint pk_pedidos primary key (codigoPedido),
    constraint fk_pedido_recibos foreign key (codigoRecibo)
		references Recibos(codigoRecibo),
	constraint fk_pedido_usuario foreign key (codigoUsuario)
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