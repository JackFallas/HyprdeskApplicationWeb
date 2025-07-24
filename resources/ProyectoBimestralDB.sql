--  drop database if exists ProyectoBimestralDB;
create database ProyectoBimestralDB;
use ProyectoBimestralDB;

create table Usuarios(
	codigoUsuario int auto_increment,
    nombreUsuario varchar(64) not null,
    apellidoUsuario varchar(64) not null,
    email varchar(128) not null,
    contraseñaUsuario varchar(64) not null,
    telefono varchar(16) not null,
	direccionUsuario varchar(128) not null,
    constraint pk_usuarios primary key (codigoUsuario)
);

create table Marcas(
	codigoMarca int auto_increment,
    nombreMarca varchar(64) not null,
    descripcion varchar(128) not null,
    constraint pk_marcas primary key (codigoMarca)
);

create table Categorias(
	codigoCategoria int auto_increment,
    nombreCategoria varchar(64)not null,
    descripcionCategoria varchar(128) not null,
    constraint pk_categorias primary key (codigoCategoria)
);

create table Productos(
	codigoProducto int auto_increment,
    nombreProducto varchar(64) not null,
    descripcionProducto varchar(128) not null,
    precioProducto decimal(10,2) default 0.00,
    stock int not null,
    codigoMarca int,
    codigoCategoria int,
    constraint pk_productos primary key (codigoProducto),
    constraint fk_Productos_Marcas foreign key (codigoMarca)
		references Marcas(codigoMarca),
	constraint fk_Productos_Categorias foreign key (codigoCategoria)
		references Categorias(codigoCategoria)
);

create table MetodoPagos(
	codigoMetodoPago int auto_increment,
    tipoMetodo varchar(64) not null,
    numeroCuenta varchar(128) not null,
    fechaExpiracion varchar(16) not null,
    nombreTitular varchar(64) not null,
    codigoUsuario int,
    constraint pk_metodo_pagos primary key (codigoMetodoPago),
    constraint fk_Metodo_Pagos_Usuarios foreign key (codigoUsuario)
		references Usuarios(codigoUsuario)
);

create table Pedidos(
	codigoPedido int auto_increment,
    fechaPedido datetime,
    estadoPedido varchar(64) not null,
    totalPedido decimal(10,2) default 0.00,
    direccionPedido varchar(128) not null,
    codigoMetodoPago int,
    codigoUsuario int,
    constraint pk_pedidos primary key (codigoPedido),
    constraint fk_Pedidos_Metodo_Pagos foreign key (codigoMetodoPago)
		references MetodoPagos(codigoMetodoPago),
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


-- ----------------------------------- CRUD DE LA BASE DE DATOS ---------------------------------- --
-- ---------- USUARIOS ----------- -- 
-- Listar Usuarios
delimiter $$
	create procedure sp_ListarUsuarios()
		begin
			select
				U.codigoUsuario as ID,
				U.nombreUsuario as NOMBRE,
				U.apellidoUsuario as APELLIDO,
				U.email,
				U.contraseñaUsuario as CONTRASENA, 
				U.telefono,
				U.direccionUsuario as DIRECCION
			from Usuarios U;
		end$$
delimiter ;

-- Agregar Usuario
delimiter $$
	create procedure sp_AgregarUsuario(
			in _nombreUsuario varchar(64),
			in _apellidoUsuario varchar(64),
			in _email varchar(128),
			in _contraseñaUsuario varchar(64),
			in _telefono varchar(16),
			in _direccionUsuario varchar(128)
		)
		begin
			insert into Usuarios (nombreUsuario, apellidoUsuario, email, contraseñaUsuario, telefono, direccionUsuario)
			values (_nombreUsuario, _apellidoUsuario, _email, _contraseñaUsuario, _telefono, _direccionUsuario);
	end$$
delimiter ;

-- Buscar Usuario por ID
delimiter $$
	create procedure sp_BuscarUsuario(
		in _codigoUsuario int)
		begin
			select * from Usuarios
			where codigoUsuario = _codigoUsuario;
		end$$
delimiter ;

-- Actualizar Usuario
delimiter $$
	create procedure sp_ActualizarUsuario(
		in _codigoUsuario int,
		in _nombreUsuario varchar(64),
		in _apellidoUsuario varchar(64),
		in _email varchar(128),
		in _contraseñaUsuario varchar(64),
		in _telefono varchar(16),
		in _direccionUsuario varchar(128)
		)
		begin
			update Usuarios
			set nombreUsuario = _nombreUsuario,
				apellidoUsuario = _apellidoUsuario,
				email = _email,
				contraseñaUsuario = _contraseñaUsuario,
				telefono = _telefono,
				direccionUsuario = _direccionUsuario
			where codigoUsuario = _codigoUsuario;
		end$$
delimiter ;

-- Eliminar Usuario
delimiter $$
	create procedure sp_EliminarUsuario(
		in _codigoUsuario int)
		begin
			delete from Usuarios
			where codigoUsuario = _codigoUsuario;
		end$$
delimiter ;

-- -------------- MARCAS ------------- --
-- Listar Marcas
delimiter $$
	create procedure sp_ListarMarcas()
		begin
			select
				M.codigoMarca as ID,
				M.nombreMarca as NOMBRE,
				M.descripcion as DESCRIPCION
			from Marcas M;
		end$$
delimiter ;

-- Agregar Marca
delimiter $$
	create procedure sp_AgregarMarca(
			in _nombreMarca varchar(64),
			in _descripcion varchar(128)
		)
		begin
			insert into Marcas (nombreMarca, descripcion)
			values (_nombreMarca, _descripcion);
	end$$
delimiter ;

-- Buscar Marca por ID
delimiter $$
	create procedure sp_BuscarMarca(
		in _codigoMarca int)
		begin
			select * from Marcas
			where codigoMarca = _codigoMarca;
		end$$
delimiter ;

-- Actualizar Marca
delimiter $$
	create procedure sp_ActualizarMarca(
		in _codigoMarca int,
		in _nombreMarca varchar(64),
		in _descripcion varchar(128)
		)
		begin
			update Marcas
			set nombreMarca = _nombreMarca,
				descripcion = _descripcion
			where codigoMarca = _codigoMarca;
		end$$
delimiter ;

-- Eliminar Marca
delimiter $$
	create procedure sp_EliminarMarca(
		in _codigoMarca int)
		begin
			delete from Marcas
			where codigoMarca = _codigoMarca;
		end$$
delimiter ;

-- --------------------- CATEGORIAS -------------- --
-- Listar Categorias
delimiter $$
	create procedure sp_ListarCategorias()
		begin
			select
				C.codigoCategoria as ID,
				C.nombreCategoria as NOMBRE,
				C.descripcionCategoria as DESCRIPCION
			from Categorias C;
		end$$
delimiter ;

-- Agregar Categoria
delimiter $$
	create procedure sp_AgregarCategoria(
			in _nombreCategoria varchar(64),
			in _descripcionCategoria varchar(128)
		)
		begin
			insert into Categorias (nombreCategoria, descripcionCategoria)
			values (_nombreCategoria, _descripcionCategoria);
	end$$
delimiter ;

-- Buscar Categoria por ID
delimiter $$
	create procedure sp_BuscarCategoria(
		in _codigoCategoria int)
		begin
			select * from Categorias
			where codigoCategoria = _codigoCategoria;
		end$$
delimiter ;

-- Actualizar Categoria
delimiter $$
	create procedure sp_ActualizarCategoria(
		in _codigoCategoria int,
		in _nombreCategoria varchar(64),
		in _descripcionCategoria varchar(128)
		)
		begin
			update Categorias
			set nombreCategoria = _nombreCategoria,
				descripcionCategoria = _descripcionCategoria
			where codigoCategoria = _codigoCategoria;
		end$$
delimiter ;

-- Eliminar Categoria
delimiter $$
	create procedure sp_EliminarCategoria(
		in _codigoCategoria int)
		begin
			delete from Categorias
			where codigoCategoria = _codigoCategoria;
		end$$
delimiter ;

-- --------------------------- PRODUCTOS ----------- --
-- Listar Productos
delimiter $$
	create procedure sp_ListarProductos()
		begin
			select
				P.codigoProducto as ID,
				P.nombreProducto as NOMBRE,
				P.descripcionProducto as DESCRIPCION,
				P.precioProducto as PRECIO,
				P.stock,
				M.nombreMarca as MARCA, -- Nombre de la marca
				C.nombreCategoria as CATEGORIA -- Nombre de la categoría
			from Productos P
			join Marcas M on P.codigoMarca = M.codigoMarca
			join Categorias C on P.codigoCategoria = C.codigoCategoria;
		end$$
delimiter ;

-- Agregar Producto
delimiter $$
	create procedure sp_AgregarProducto(
			in _nombreProducto varchar(64),
			in _descripcionProducto varchar(128),
			in _precioProducto decimal(10,2),
			in _stock int,
			in _codigoMarca int,
			in _codigoCategoria int
		)
		begin
			insert into Productos (nombreProducto, descripcionProducto, precioProducto, stock, codigoMarca, codigoCategoria)
			values (_nombreProducto, _descripcionProducto, _precioProducto, _stock, _codigoMarca, _codigoCategoria);
	end$$
delimiter ;

-- Buscar Producto por ID
delimiter $$
	create procedure sp_BuscarProducto(
		in _codigoProducto int)
		begin
			select
				P.codigoProducto,
				P.nombreProducto,
				P.descripcionProducto,
				P.precioProducto,
				P.stock,
				P.codigoMarca,
				M.nombreMarca, -- Incluye el nombre de la marca
				P.codigoCategoria,
				C.nombreCategoria -- Incluye el nombre de la categoría
			from Productos P
			join Marcas M on P.codigoMarca = M.codigoMarca
			join Categorias C on P.codigoCategoria = C.codigoCategoria
			where P.codigoProducto = _codigoProducto;
		end$$
delimiter ;

-- Actualizar Producto
delimiter $$
	create procedure sp_ActualizarProducto(
		in _codigoProducto int,
		in _nombreProducto varchar(64),
		in _descripcionProducto varchar(128),
		in _precioProducto decimal(10,2),
		in _stock int,
		in _codigoMarca int,
		in _codigoCategoria int
		)
		begin
			update Productos
			set nombreProducto = _nombreProducto,
				descripcionProducto = _descripcionProducto,
				precioProducto = _precioProducto,
				stock = _stock,
				codigoMarca = _codigoMarca,
				codigoCategoria = _codigoCategoria
			where codigoProducto = _codigoProducto;
		end$$
delimiter ;

-- Eliminar Producto
delimiter $$
	create procedure sp_EliminarProducto(
		in _codigoProducto int)
		begin
			delete from Productos
			where codigoProducto = _codigoProducto;
		end$$
delimiter ;

-- ------------------------- METODOPAGOS --------------- --
-- Listar MetodoPagos 
delimiter $$
	create procedure sp_ListarMetodoPagos()
		begin
			select
				MP.codigoMetodoPago as ID,
				MP.tipoMetodo as TIPO,
				MP.numeroCuenta as NUMERO_CUENTA, 
				MP.fechaExpiracion as FECHA_EXPIRACION,
				MP.nombreTitular as TITULAR,
				U.nombreUsuario as USUARIO_NOMBRE,
				U.apellidoUsuario as USUARIO_APELLIDO
			from MetodoPagos MP
			join Usuarios U on MP.codigoUsuario = U.codigoUsuario;
		end$$
delimiter ;

-- Agregar MetodoPago
delimiter $$
	create procedure sp_AgregarMetodoPago(
			in _tipoMetodo varchar(64),
			in _numeroCuenta varchar(128),
			in _fechaExpiracion varchar(16),
			in _nombreTitular varchar(64),
			in _codigoUsuario int
		)
		begin
			insert into MetodoPagos (tipoMetodo, numeroCuenta, fechaExpiracion, nombreTitular, codigoUsuario)
			values (_tipoMetodo, _numeroCuenta, _fechaExpiracion, _nombreTitular, _codigoUsuario);
	end$$
delimiter ;

-- Buscar MetodoPago por ID
delimiter $$
	create procedure sp_BuscarMetodoPago(
		in _codigoMetodoPago int)
		begin
			select
				MP.*,
				U.nombreUsuario,
				U.apellidoUsuario
			from MetodoPagos MP
			join Usuarios U on MP.codigoUsuario = U.codigoUsuario
			where MP.codigoMetodoPago = _codigoMetodoPago;
		end$$
delimiter ;

-- Actualizar MetodoPago
delimiter $$
	create procedure sp_ActualizarMetodoPago(
		in _codigoMetodoPago int,
		in _tipoMetodo varchar(64),
		in _numeroCuenta varchar(128),
		in _fechaExpiracion varchar(16),
		in _nombreTitular varchar(64),
		in _codigoUsuario int
		)
		begin
			update MetodoPagos
			set tipoMetodo = _tipoMetodo,
				numeroCuenta = _numeroCuenta,
				fechaExpiracion = _fechaExpiracion,
				nombreTitular = _nombreTitular,
				codigoUsuario = _codigoUsuario
			where codigoMetodoPago = _codigoMetodoPago;
		end$$
delimiter ;

-- Eliminar MetodoPago
delimiter $$
	create procedure sp_EliminarMetodoPago(
		in _codigoMetodoPago int)
		begin
			delete from MetodoPagos
			where codigoMetodoPago = _codigoMetodoPago;
		end$$
delimiter ;

-- ----------------------- PEDIDOS ------------ --
-- Listar Pedidos 
delimiter $$
	create procedure sp_ListarPedidos()
		begin
			select
				P.codigoPedido as ID,
				P.fechaPedido as FECHA,
				P.estadoPedido as ESTADO,
				P.totalPedido as TOTAL,
				P.direccionPedido as DIRECCION_ENVIO,
				P.codigoMetodoPago as CODIGO_METODO_PAGO,
				P.codigoUsuario as CODIGO_USUARIO
			from Pedidos P;
		end$$
delimiter ;

-- Agregar Pedido
delimiter $$
	create procedure sp_AgregarPedido(
			in _fechaPedido datetime,
			in _estadoPedido varchar(64),
			in _totalPedido decimal(10,2),
			in _direccionPedido varchar(128),
			in _codigoMetodoPago int,
			in _codigoUsuario int
		)
		begin
			insert into Pedidos (fechaPedido, estadoPedido, totalPedido, direccionPedido, codigoMetodoPago, codigoUsuario)
			values (_fechaPedido, _estadoPedido, _totalPedido, _direccionPedido, _codigoMetodoPago, _codigoUsuario);
	end$$
delimiter ;

-- Buscar Pedido por ID
delimiter $$
	create procedure sp_BuscarPedido(
		in _codigoPedido int)
		begin
			select
				P.codigoPedido as ID,
				P.fechaPedido as FECHA,
				P.estadoPedido as ESTADO,
				P.totalPedido as TOTAL,
				P.direccionPedido as DIRECCION_ENVIO,
				P.codigoMetodoPago as CODIGO_METODO_PAGO,
				P.codigoUsuario as CODIGO_USUARIO
			from Pedidos P
			where P.codigoPedido = _codigoPedido;
		end$$
delimiter ;

-- Actualizar Pedido
delimiter $$
	create procedure sp_ActualizarPedido(
		in _codigoPedido int,
		in _fechaPedido datetime,
		in _estadoPedido varchar(64),
		in _totalPedido decimal(10,2),
		in _direccionPedido varchar(128),
		in _codigoMetodoPago int,
		in _codigoUsuario int
		)
		begin
			update Pedidos
			set fechaPedido = _fechaPedido,
				estadoPedido = _estadoPedido,
				totalPedido = _totalPedido,
				direccionPedido = _direccionPedido,
				codigoMetodoPago = _codigoMetodoPago,
				codigoUsuario = _codigoUsuario
			where codigoPedido = _codigoPedido;
		end$$
delimiter ;

-- Eliminar Pedido
delimiter $$
	create procedure sp_EliminarPedido(
		in _codigoPedido int)
		begin
			delete from Pedidos
			where codigoPedido = _codigoPedido;
		end$$
delimiter ;


-- -------------------- DETALLEPEDIDOS --------------- --
-- Listar DetallePedidos 
delimiter $$
	create procedure sp_ListarDetallePedidos()
		begin
			select
				DP.codigoDetallePedido as ID,
				DP.cantidad,
				DP.precio as PRECIO_UNITARIO,
				DP.subtotal,
				DP.codigoPedido as CODIGO_PEDIDO,
				DP.codigoProducto as CODIGO_PRODUCTO
			from DetallePedidos DP;
		end$$
delimiter ;

-- Agregar DetallePedido
delimiter $$
	create procedure sp_AgregarDetallePedido(
			in _cantidad int,
			in _precio decimal(10,2),
			in _subtotal decimal(10,2),
			in _codigoPedido int,
			in _codigoProducto int
		)
		begin
			insert into DetallePedidos (cantidad, precio, subtotal, codigoPedido, codigoProducto)
			values (_cantidad, _precio, _subtotal, _codigoPedido, _codigoProducto);
	end$$
delimiter ;

-- Buscar DetallePedido por ID
delimiter $$
	create procedure sp_BuscarDetallePedido(
		in _codigoDetallePedido int)
		begin
			select
				DP.codigoDetallePedido as ID,
				DP.cantidad,
				DP.precio as PRECIO_UNITARIO,
				DP.subtotal,
				DP.codigoPedido as CODIGO_PEDIDO,
				DP.codigoProducto as CODIGO_PRODUCTO
			from DetallePedidos DP
			where DP.codigoDetallePedido = _codigoDetallePedido;
		end$$
delimiter ;

-- Actualizar DetallePedido
delimiter $$
	create procedure sp_ActualizarDetallePedido(
		in _codigoDetallePedido int,
		in _cantidad int,
		in _precio decimal(10,2),
		in _subtotal decimal(10,2),
		in _codigoPedido int,
		in _codigoProducto int
		)
		begin
			update DetallePedidos
			set cantidad = _cantidad,
				precio = _precio,
				subtotal = _subtotal,
				codigoPedido = _codigoPedido,
				codigoProducto = _codigoProducto
			where codigoDetallePedido = _codigoDetallePedido;
		end$$
delimiter ;

-- Eliminar DetallePedido
delimiter $$
	create procedure sp_EliminarDetallePedido(
		in _codigoDetallePedido int)
		begin
			delete from DetallePedidos
			where codigoDetallePedido = _codigoDetallePedido;
		end$$
delimiter ;


