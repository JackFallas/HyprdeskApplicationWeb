<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Producto" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mantenimiento de Productos - Hyprdesk</title>
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/bootstrap-icons.min.css" rel="stylesheet">
        <!-- Enlace al archivo CSS del dashboard -->
        <link rel="stylesheet" href="resources/css/dashboardU.css"/> 
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <style>
            /* Variables globales para el diseño moderno del dashboard y colores originales */
            :root {
                --sidebar-collapsed: 80px;
                --sidebar-expanded: 260px;
                --primary: #0d6efd; /* Azul principal del nuevo diseño para el sidebar */
                --bg: #ffffff; /* Fondo blanco del sidebar y header */
                --text: #4b5563; /* Color de texto general del nuevo diseño */
                --muted: #9ca3af; /* Color de texto más claro del nuevo diseño */
                --radius: 18px; /* Radio de bordes del nuevo diseño */

                --original-primary-blue: #3498DB;
                --original-light-blue-1: #5DADE2;
                --original-light-blue-2: #AED6F1;
                --original-light-blue-3: #D6EAF8;
                --original-gray-text: #717D7E;
            }
            body {
                background-color: var(--original-light-blue-3);
                font-family: 'Poppins', sans-serif;
                display: flex; /* **Esencial:** Habilitar flexbox para el layout principal con sidebar */
                color: var(--original-gray-text);
                margin: 0; /* Elimina márgenes por defecto del body */
                min-height: 100vh;
                overflow-x: hidden; /* Evitar scroll horizontal */
            }
            /* Estilos del main-content que se ajusta al sidebar y al header fijo */
            .main-content {
                margin-left: var(--sidebar-collapsed); /* Espacio inicial para el sidebar colapsado */
                transition: margin-left .35s ease;
                flex-grow: 1; /* Ocupa el espacio restante */
                /* Padding superior para que el contenido no quede oculto bajo el header fijo */
                padding: 65px 30px 30px 30px; /* Ajustado para compensar la altura del header fijo */
            }
            #nav-toggle:checked ~ .main-content {
                margin-left: var(--sidebar-expanded); /* Ajuste para el sidebar expandido */
            }
            
            /* Estilos del Header superior (adaptados de dashboardU.css) */
            .header {
                position: fixed;
                top: 0;
                left: var(--sidebar-collapsed); /* Posición inicial alineada con sidebar colapsado */
                width: calc(100% - var(--sidebar-collapsed)); /* Ancho ajustado */
                padding: 18px 30px; /* Padding del header */
                background: var(--bg); /* Fondo blanco del header */
                box-shadow: 0 2px 5px rgba(0, 0, 0, .05);
                display: flex;
                justify-content: space-between;
                align-items: center;
                z-index: 999; /* Asegura que esté por encima de otros elementos */
                transition: left .35s ease, width .35s ease;
            }
            #nav-toggle:checked ~ .header {
                left: var(--sidebar-expanded); /* Se mueve con el sidebar expandido */
                width: calc(100% - var(--sidebar-expanded)); /* Ancho ajustado */
            }
            .header .logo-text { /* Estilo para el texto del logo "Mantenimiento de Productos" */
                font-size: 22px;
                color: var(--text);
                text-decoration: none;
                font-weight: 600;
            }
            .header .social-media { /* Sección de íconos sociales en el header */
                display: flex;
                gap: 15px;
            }
            .header .social-media a {
                color: var(--text);
                font-size: 1.4rem;
                transition: color 0.3s ease;
            }
            .header .social-media a:hover {
                color: var(--primary);
            }

            /* Estilos del Sidebar (adaptados de dashboardU.css) */
            .sidebar {
                position: fixed; /* **Esencial:** Fijo en la pantalla para que no se desplace con el scroll */
                inset: 0 auto 0 0; /* Fijo a la izquierda */
                width: var(--sidebar-collapsed);
                background: var(--bg);
                border-right: 1px solid rgba(0,0,0,.05);
                box-shadow: 5px 0 15px rgba(0,0,0,.05);
                padding: 24px 14px 90px;
                transition: width .35s;
                z-index: 1000;
                display: flex;
                flex-direction: column;
                overflow: hidden; /* Ocultar contenido desbordado al colapsar */
            }
            #nav-toggle:checked ~ .sidebar {
                width: var(--sidebar-expanded);
                box-shadow: 0 0 0 100vmax rgba(0,0,0,0.4); /* Overlay cuando está expandido */
            }

            .toggle-btn { /* Botón para abrir/cerrar el sidebar */
                position: fixed;
                top: 18px;
                left: 18px;
                z-index: 1100;
                width: 44px;
                height: 44px;
                background: var(--primary);
                color: #fff;
                border-radius: 10px;
                display: grid;
                place-items: center;
                cursor: pointer;
                transition: background .25s;
            }
            .toggle-btn:hover{ background:#5DADE2; }
            .toggle-btn i{
                font-size: 22px;
                transition: transform .3s;
            }
            #nav-toggle:checked + .toggle-btn i{
                transform: rotate(90deg);
            }

            /* Sección de marca en el sidebar */
            .sidebar .brand{
                display: flex;
                align-items: center;
                gap: 10px;
                height: 48px;
                margin-bottom: 26px;
            }
            .sidebar .brand i{
                font-size: 32px;
                color: var(--primary);
            }
            .sidebar .brand__name{
                font-weight: 600;
                font-size: 20px;
                opacity: 0;
                transform: translateX(-10px);
                transition: .2s;
            }
            #nav-toggle:checked ~ .sidebar .brand__name{
                opacity: 1;
                transform: none;
            }

            /* Menú del sidebar */
            .sidebar .menu{
                display: grid;
                gap: 6px;
            }
            .sidebar .menu__item{
                display: flex;
                align-items: center;
                gap: 14px;
                height: 46px;
                border-radius: var(--radius);
                color: var(--text);
                text-decoration: none;
                padding: 0 12px;
                transition: background .2s, color .2s;
                white-space: nowrap;
            }
            .sidebar .menu__item i{
                font-size: 22px;
                min-width: 22px;
                text-align: center;
            }
            .sidebar .menu__item span{
                opacity: 0;
                transform: translateX(-10px);
                transition: .2s;
            }
            #nav-toggle:checked ~ .sidebar .menu__item span{
                opacity: 1;
                transform: none;
            }
            .sidebar .menu__item:hover{
                background: rgba(13,110,253,.08);
                color: var(--primary);
            }
            .sidebar .menu__item.active{
                background: rgba(13,110,253,.12);
                color: var(--primary);
            }

            /* Perfil en el sidebar */
            .sidebar .profile{
                position: absolute;
                left: 14px;
                right: 14px;
                bottom: 18px;
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 10px;
                border-radius: var(--radius);
                background: rgba(13,110,253,.05);
            }
            .profile img {
                display: none; /* Ocultar la imagen del logo en el perfil */
            }
            .profile__info {
                display: none; /* Ocultar el texto "Admin" y "Derechos Reservados" */
            }


            /* Estilos del CRUD de Productos (originales de tu archivo - se mantienen) */
            .container-main {
                background-color: white;
                border-radius: .5rem;
                padding: 2rem;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }
            h1, h2, h3, h4, h5, h6 {
                color: var(--original-primary-blue);
            }
            .table-custom th {
                background-color: var(--original-light-blue-1);
                color: white;
                border-color: var(--original-primary-blue);
            }
            .table-custom td {
                border-color: var(--original-light-blue-2);
            }
            .btn-edit {
                background-color: var(--original-primary-blue);
                border-color: var(--original-primary-blue);
                color: white;
            }
            .btn-edit:hover {
                background-color: var(--original-light-blue-1);
                border-color: var(--original-light-blue-1);
            }
            .btn-delete {
                background-color: #dc3545;
                border-color: #dc3545;
                color: white;
            }
            .btn-delete:hover {
                background-color: #c82333;
                border-color: #bd2130;
            }
            .btn-add {
                background-color: var(--original-primary-blue);
                border-color: var(--original-primary-blue);
                color: white;
            }
            .btn-add:hover {
                background-color: var(--light-blue-1);
                border-color: var(--light-blue-1);
            }
            .btn-add-to-cart {
                background-color: #28a745;
                border-color: #28a745;
                color: white;
            }
            .btn-add-to-cart:hover {
                background-color: #218838;
                border-color: #1e7e34;
            }
            .btn-report { /* Nuevo estilo para el botón de reporte */
                background-color: #17a2b8; /* Un color diferente para el reporte, como teal */
                border-color: #17a2b8;
                color: white;
            }
            .btn-report:hover {
                background-color: #138496;
                border-color: #117a8b;
            }
            .modal-content {
                border-radius: .5rem;
                border: none;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }
            .modal-header {
                background-color: var(--original-primary-blue);
                color: white;
                border-bottom: 1px solid var(--original-light-blue-1);
            }
            .modal-header .btn-close {
                filter: invert(1);
            }
            .modal-footer {
                border-top: 1px solid var(--original-light-blue-2);
                justify-content: flex-end;
            }

            /* Estilos de los formularios dentro del modal */
            .form-label {
                font-weight: 500;
                margin-bottom: 8px;
                color: var(--original-gray-text);
            }
            .form-control {
                border-radius: 6px;
                padding: 10px 15px;
                transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }
            .form-control:focus {
                border-color: var(--original-primary-blue);
                box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
                outline: none;
            }

            /* Media queries para responsividad */
            @media (max-width: 991px) {
                .sidebar {
                    width: 80px;
                    left: 0;
                }
                #nav-toggle:checked + .toggle-btn + .sidebar {
                    left: 0;
                }
                .main-content {
                    padding-left: calc(var(--sidebar-collapsed) + 20px);
                }
                #nav-toggle:checked ~ .main-content {
                    padding-left: calc(var(--sidebar-expanded) + 20px);
                }
                .toggle-btn {
                    left: 18px;
                    color: var(--text);
                }
                #nav-toggle:checked + .toggle-btn {
                    left: 18px;
                }
            }

            @media (max-width: 767px) {
                .sidebar {
                    width: 0;
                    left: -80px;
                }
                #nav-toggle:checked + .toggle-btn + .sidebar {
                    width: 200px;
                    left: 0;
                }
                .main-content {
                    padding-left: 20px;
                }
                #nav-toggle:checked ~ .main-content {
                    padding-left: calc(200px + 20px);
                }
                .toggle-btn {
                    left: 10px;
                    top: 10px;
                    font-size: 1.8rem;
                    width: 38px;
                    height: 38px;
                    background: var(--original-primary-blue);
                }
                #nav-toggle:checked + .toggle-btn {
                    left: calc(200px + 10px);
                }
                h1 {
                    font-size: 1.5rem;
                    margin-bottom: 15px !important;
                }
                .btn-add, .btn-report { /* Aplicar a ambos botones */
                    padding: 8px 15px;
                    font-size: 0.9rem;
                }
                .table-custom th, .table-custom td {
                    font-size: 0.8rem;
                    padding: 6px;
                }
                .btn-edit {
                    padding: 4px 8px;
                    font-size: 0.75rem;
                }
                .modal-dialog.modal-lg {
                    margin: 10px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Input y botón de toggle para el sidebar -->
        <input type="checkbox" id="nav-toggle">
        <label for="nav-toggle" class="toggle-btn">
            <i class='bx bx-menu'></i>
        </label>

        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="brand">
                <i class='bx bxl-css3'></i>
                <span class="brand__name">Hyprdesk</span>
            </div>

            <nav class="menu">
                <a href="dashboardAdmin.jsp" class="menu__item">
                    <i class='bx bx-home-alt'></i><span>Dashboard</span>
                </a>
                <a href="ServletUsuario" class="menu__item">
                    <i class='bx bx-user'></i><span>Usuarios</span>
                </a>
                <a href="ServletMarcas" class="menu__item">
                    <i class='bx bx-building-house'></i><span>Marcas</span>
                </a>
                <a href="ServletCategorias" class="menu__item">
                    <i class='bx bx-category'></i><span>Categorías</span>
                </a>
                <a href="ServletProducto" class="menu__item active"> <!-- PRODUCTOS ACTIVO -->
                    <i class='bx bx-package'></i><span>Productos</span>
                </a>
                <a href="ServletTarjetas" class="menu__item">
                    <i class='bx bx-credit-card'></i><span>Tarjetas</span>
                </a>
                <a href="ServletRecibos" class="menu__item">
                    <i class='bx bx-receipt'></i><span>Recibos</span>
                </a>
                <a href="ServletPedidos" class="menu__item">
                    <i class='bx bx-cart'></i><span>Pedidos</span>
                </a>
                <a href="ServletDetallePedido" class="menu__item">
                    <i class='bx bx-list-ul'></i><span>Detalle de Pedidos</span>
                </a>
                <a href="login.jsp" class="menu__item">
                    <i class='bx bx-power-off'></i><span>Cerrar sesión</span>
                </a>
            </nav>

            <div class="profile">
                <!-- Se elimina la imagen del logo -->
                <div class="profile__info">
                    <!-- Se elimina el texto "Admin" y "Kinal - Derechos Reservados" -->
                </div>
            </div>
        </aside>

        <!-- Contenido principal de la página (a la derecha del sidebar) -->
        <main class="main-content">
            <!-- Navbar original (ahora dentro de main-content) -->
            <nav class="navbar navbar-expand-lg navbar-dark mb-4">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">
                        <!-- LOGO ELIMINADO -->
                    </a>
                    <span class="navbar-text ms-3 h4" style="color: black !important;">
                        Mantenimiento de Productos
                    </span>
                </div>
            </nav>
            <div class="container">
                <div class="container-main">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1>Listado de Productos</h1>
                        <div> <!-- Contenedor para los botones -->
                            <c:if test="${rol == 'Admin'}">
                                <button type="button" class="btn btn-add me-2" data-bs-toggle="modal" data-bs-target="#elementoModal" 
                                        onclick="prepararModalAgregar()">
                                    <i class="bi bi-plus-circle"></i> Agregar Producto
                                </button>
                                <!-- Nuevo botón para descargar el reporte -->
                                <a href="${pageContext.request.contextPath}/ServletReportes?nombre=productos" class="btn btn-report" target="_blank">
                                    <i class='bx bx-download'></i> Descargar Reporte
                                </a>
                            </c:if>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered table-custom" id="tablaElementos">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Descripción</th>
                                    <th scope="col">Precio</th>
                                    <th scope="col">Stock</th>
                                    <th scope="col">Fecha Entrada</th>
                                    <th scope="col">Fecha Salida</th>
                                    <th scope="col">Código Marca</th>
                                    <th scope="col">Código Categoría</th>
                                    <th scope="col">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- Itera sobre la lista de productos obtenida del Servlet --%>
                                <c:forEach var="producto" items="${listaProductos}">
                                    <tr data-id="${producto.codigoProducto}"
                                        data-nombre="${producto.nombre}"
                                        data-descripcion="${producto.descripcion}"
                                        data-precio="${producto.precio}"
                                        data-stock="${producto.stock}"
                                        data-fechaentrada="${producto.fechaEntrada}"
                                        data-fechasalida="${producto.fechaSalida}"
                                        data-codigomarca="${producto.marca.codigoMarca}"
                                        data-codigocategoria="${producto.categoria.codigoCategoria}">
                                        <td>${producto.codigoProducto}</td>
                                        <td>${producto.nombre}</td>
                                        <td>${producto.descripcion}</td>
                                        <td>${producto.precio}</td>
                                        <td>${producto.stock}</td>
                                        <td>${producto.fechaEntrada}</td>
                                        <td>${producto.fechaSalida}</td>
                                        <td>${producto.marca.codigoMarca}</td>
                                        <td>${producto.categoria.codigoCategoria}</td>
                                        <td>
                                            <c:if test="${rol == 'Admin'}">
                                                <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#elementoModal" 
                                                        onclick="prepararModalEditar(this)">Editar</button>
                                                <a href="${pageContext.request.contextPath}/ServletProducto?accion=eliminar&id=${producto.codigoProducto}" class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este producto?');">Eliminar</a>
                                            </c:if>
                                            <c:if test="${rol == 'Usuario'}">
                                                <button type="button" class="btn btn-add-to-cart btn-sm"
                                                        onclick="abrirModalAgregarCarrito(${producto.codigoProducto}, ${producto.precio})">
                                                    Añadir al carrito
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="elementoModal" tabindex="-1" aria-labelledby="elementoModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="elementoModalLabel"></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="elementoForm" action="${pageContext.request.contextPath}/ServletProducto" method="post">
                                <input type="hidden" name="accion" id="formAccion" value="agregar">
                                <input type="hidden" name="codigoProducto" id="formIdElemento">
                                <div class="mb-3">
                                    <label for="modalNombreProducto" class="form-label">Nombre:</label>
                                    <input type="text" name="nombreProducto" id="modalNombreProducto" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalDescripcion" class="form-label">Descripción:</label>
                                    <input type="text" name="descripcionProducto" id="modalDescripcion" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalPrecio" class="form-label">Precio:</label>
                                    <input type="number" step="0.01" name="precioProducto" id="modalPrecio" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalStock" class="form-label">Stock:</label>
                                    <input type="number" name="stock" id="modalStock" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalFechaEntrada" class="form-label">Fecha Entrada:</label>
                                    <input type="date" name="fechaEntrada" id="modalFechaEntrada" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalFechaSalida" class="form-label">Fecha Salida:</label>
                                    <input type="date" name="fechaSalida" id="modalFechaSalida" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalCodigoMarca" class="form-label">Código Marca:</label>
                                    <input type="number" name="codigoMarca" id="modalCodigoMarca" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalCodigoCategoria" class="form-label">Código Categoría:</label>
                                    <input type="number" name="codigoCategoria" id="modalCodigoCategoria" class="form-control" required>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <button type="submit" class="btn btn-primary">Guardar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalAgregarCarrito" tabindex="-1" aria-labelledby="modalAgregarCarritoLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form id="formAgregarCarrito" action="${pageContext.request.contextPath}/ServletDetallePedido" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalAgregarCarritoLabel">Agregar al carrito</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="accion" value="guardar">
                                <input type="hidden" name="codigoProducto" id="modalCodigoProducto">
                                <input type="hidden" name="precio" id="modalPrecioProducto">
                                <input type="hidden" name="subtotal" id="modalSubtotalProducto">
                                <input type="hidden" name="codigoPedido" value="1"> <!-- Cambia esto según tu pedido actual -->

                                <div class="mb-3">
                                    <label for="modalCantidad" class="form-label">Cantidad:</label>
                                    <input type="number" class="form-control" id="modalCantidad" name="cantidad" min="1" value="1" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Agregar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>

        <script src="resources/js/bootstrap.bundle.min.js"></script>
        <script>
            function prepararModalAgregar() {
                document.getElementById('elementoModalLabel').innerText = 'Agregar Nuevo Producto';
                document.getElementById('elementoForm').reset();
                document.getElementById('formAccion').value = 'agregar';
                document.getElementById('formIdElemento').value = '';
            }
            function prepararModalEditar(button) {
                const row = button.closest('tr');
                const id = row.dataset.id;
                const nombre = row.dataset.nombre;
                const descripcion = row.dataset.descripcion;
                const precio = row.dataset.precio;
                const stock = row.dataset.stock;
                const fechaEntrada = row.dataset.fechaentrada;
                const fechaSalida = row.dataset.fechasalida;
                const codigoMarca = row.dataset.codigomarca;
                const codigoCategoria = row.dataset.codigocategoria;

                document.getElementById('elementoModalLabel').innerText = 'Editar Producto ID: ' + id;
                document.getElementById('formIdElemento').value = id;
                document.getElementById('modalNombreProducto').value = nombre;
                document.getElementById('modalDescripcion').value = descripcion;
                document.getElementById('modalPrecio').value = precio;
                document.getElementById('modalStock').value = stock;
                document.getElementById('modalFechaEntrada').value = fechaEntrada;
                document.getElementById('modalFechaSalida').value = fechaSalida;
                document.getElementById('modalCodigoMarca').value = codigoMarca;
                document.getElementById('modalCodigoCategoria').value = codigoCategoria;
                document.getElementById('formAccion').value = 'actualizar';
            }
            function abrirModalAgregarCarrito(codigoProducto, precioUnitario) {
                document.getElementById('modalCodigoProducto').value = codigoProducto;
                document.getElementById('modalPrecioProducto').value = precioUnitario.toFixed(2);
                document.getElementById('modalCantidad').value = 1;
                document.getElementById('modalSubtotalProducto').value = precioUnitario.toFixed(2);

                // Abrir modal con Bootstrap 5
                var modal = new bootstrap.Modal(document.getElementById('modalAgregarCarrito'));
                modal.show();

                document.getElementById('modalCantidad').oninput = function () {
                    let cantidad = parseInt(this.value);
                    if (cantidad < 1) {
                        cantidad = 1;
                        this.value = cantidad;
                    }
                    document.getElementById('modalSubtotalProducto').value = (precioUnitario * cantidad).toFixed(2);
                };
            }
        </script>
    </body>
</html>
