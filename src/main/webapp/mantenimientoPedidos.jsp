<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Pedido"%>
<%@ page import="model.Tarjeta"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Gestión de Pedidos - Hyprdesk</title>
        <!-- Bootstrap CSS -->
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
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
            .header .logo-text { /* Estilo para el texto del logo "Gestión de Pedidos" */
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


            /* Estilos del CRUD de Pedidos (originales de tu archivo - se mantienen) */
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
            .status-disponible {
                color: #28a745;
                font-weight: bold;
            }
            .status-no-disponible {
                color: #dc3545;
                font-weight: bold;
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
                .btn-add {
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
                <a href="ServletProducto" class="menu__item">
                    <i class='bx bx-package'></i><span>Productos</span>
                </a>
                <a href="ServletTarjetas" class="menu__item">
                    <i class='bx bx-credit-card'></i><span>Tarjetas</span>
                </a>
                <a href="ServletRecibos" class="menu__item">
                    <i class='bx bx-receipt'></i><span>Recibos</span>
                </a>
                <a href="ServletPedidos" class="menu__item active"> <!-- PEDIDOS ACTIVO -->
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
                    <span class="navbar-text ms-3 h4" style="color: black !important;">Gestión de Pedidos</span>
                </div>
            </nav>

            <div class="container">
            <div class="container-main">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Listado de Pedidos</h1>
                    <c:if test="${rol == 'Admin'}">
                        <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#pedidoModal" onclick="prepararModalAgregar()">
                            <i class="bi bi-plus-circle"></i> Agregar Pedido
                        </button>
                    </c:if>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>
                <c:if test="${param.success eq 'true'}">
                    <div class="alert alert-success" role="alert">
                        ¡Pedido guardado exitosamente!
                    </div>
                </c:if>
                <c:if test="${param.deleted eq 'true'}">
                    <div class="alert alert-success" role="alert">
                        ¡Pedido eliminado exitosamente!
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered table-custom" id="tablaPedidos">
                        <thead>
                            <tr>
                                <th scope="col">Código Pedido</th>
                                <th scope="col">Fecha</th>
                                <th scope="col">Estado</th>
                                <th scope="col">Total</th>
                                <th scope="col">Dirección</th>
                                <th scope="col">Código Recibo</th>
                                    <c:if test="${rol == 'Admin' || rol == 'Usuario'}">
                                    <th scope="col">Acciones</th>
                                    </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pedido" items="${listaPedidos}">
                                <tr data-codigo="${pedido.codigoPedido}" data-fecha="${pedido.fechaPedido}" data-estado="${pedido.estadoPedido}" data-total="${pedido.totalPedido}" data-direccion="${pedido.direccionPedido}" data-usuario="${pedido.usuario.codigoUsuario}" data-recibo="${pedido.recibo != null ? pedido.recibo.codigoRecibo : ''}">
                                    <td>${pedido.codigoPedido}</td>
                                    <td>${pedido.fechaPedido}</td>
                                    <td>${pedido.estadoPedido}</td>
                                    <td>${pedido.totalPedido}</td>
                                    <td>${pedido.direccionPedido}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${pedido.recibo != null}">
                                                ${pedido.recibo.codigoRecibo}
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <c:choose>
                                        <c:when test="${rol == 'Admin'}">
                                            <td>
                                                <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#pedidoModal"
                                                        onclick="prepararModalEditar(this)">Editar</button>
                                                <a href="${pageContext.request.contextPath}/ServletPedidos?accion=eliminar&id=${pedido.codigoPedido}"
                                                   class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este pedido?');">Eliminar</a>
                                            </td>
                                        </c:when>
                                        <c:when test="${rol == 'Usuario'}">
                                            <td>
                                                <c:if test="${pedido.estadoPedido != 'Entregado'}">
                                                    <button type="button"
                                                            class="btn btn-success btn-sm"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#modalFinalizarCompra"
                                                            data-codigopedido="${pedido.codigoPedido}"
                                                            data-totalpedido="${pedido.totalPedido}"
                                                            data-direccionpedido="${pedido.direccionPedido}">
                                                        Finalizar Compra
                                                    </button>
                                                </c:if>
                                            </td>
                                        </c:when>
                                        <c:otherwise>
                                            <td></td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal para agregar/editar pedido -->
        <div class="modal fade" id="pedidoModal" tabindex="-1" aria-labelledby="pedidoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="pedidoModalLabel"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="pedidoForm" action="${pageContext.request.contextPath}/ServletPedidos" method="post">
                            <input type="hidden" name="accion" id="formAccion" value="insertar">
                            <input type="hidden" name="codigoPedido" id="formCodigoPedido">

                            <!-- Fecha Pedido -->
                            <div class="mb-3">
                                <label for="modalFechaPedido" class="form-label">Fecha Pedido:</label>
                                <input type="datetime-local" name="fechaPedido" id="modalFechaPedido" class="form-control" required>
                            </div>

                            <!-- Estado Pedido -->
                            <div class="mb-3">
                                <label for="modalEstadoPedido" class="form-label">Estado Pedido:</label>
                                <select id="modalEstadoPedido" name="estadoPedido" class="form-select" required>
                                    <option value="Pendiente">Pendiente</option>
                                    <option value="En_proceso">En proceso</option>
                                    <option value="Enviado">Enviado</option>
                                    <option value="Entregado">Entregado</option>
                                    <option value="Cancelado">Cancelado</option>
                                </select>
                            </div>

                            <!-- Total Pedido -->
                            <div class="mb-3">
                                <label for="modalTotalPedido" class="form-label">Total Pedido:</label>
                                <input type="number" name="totalPedido" id="modalTotalPedido" class="form-control" required>
                            </div>

                            <!-- Dirección Pedido -->
                            <div class="mb-3">
                                <label for="modalDireccionPedido" class="form-label">Dirección:</label>
                                <input type="text" name="direccionPedido" id="modalDireccionPedido" class="form-control" required>
                            </div>

                            <!-- Código Usuario -->
                            <div class="mb-3">
                                <label for="modalCodigoUsuario" class="form-label">Código Usuario:</label>
                                <input type="number" name="codigoUsuario" id="modalCodigoUsuario" class="form-control" required>
                            </div>

                            <!-- Código Recibo -->
                            <div class="mb-3">
                                <label for="modalCodigoRecibo" class="form-label">Código Recibo:</label>
                                <input type="number" name="codigoRecibo" id="modalCodigoRecibo" class="form-control" required>
                            </div>

                            <c:if test="${rol == 'Admin'}">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <button type="submit" class="btn btn-primary">Guardar</button>
                                </div>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Finalizar Compra -->
        <div class="modal fade" id="modalFinalizarCompra" tabindex="-1" aria-labelledby="modalFinalizarCompraLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form id="formFinalizarCompra" action="${pageContext.request.contextPath}/ServletRecibos" method="post">
                    <input type="hidden" name="accion" value="finalizarCompra">
                    <input type="hidden" name="codigoPedido" id="modalCodigoPedido">
                    <input type="hidden" name="metodoPago" value="Tarjeta">
                    <input type="hidden" name="codigoUsuario" value="${codigoUsuarioLogueado}">

                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="modalFinalizarCompraLabel">Finalizar Compra - Datos Recibo</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="modalMonto" class="form-label">Monto:</label>
                                <input type="text" id="modalMonto" name="monto" class="form-control" readonly>
                            </div>

                            <div class="mb-3 d-flex align-items-end">
                                <div class="flex-grow-1 me-2">
                                    <label for="modalCodigoTarjeta" class="form-label">Seleccione Tarjeta:</label>
                                    <select id="modalCodigoTarjeta" name="codigoTarjeta" class="form-select" required>
                                        <option value="">-- Seleccione una tarjeta --</option>
                                        <!-- Iteramos sobre la lista de tarjetas, que debe ser pasada al JSP -->
                                        <c:forEach var="tarjeta" items="${tarjetasUsuario}">
                                            <option value="${tarjeta.codigoTarjeta}">
                                                <c:out value="${tarjeta.marca} - ****${tarjeta.ultimos4}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <!-- Botón para agregar una nueva tarjeta -->
                                <button type="button" id="addCardBtn" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#addCardModal">
                                    <i class="bi bi-plus-circle"></i>
                                </button>
                            </div>

                            <div class="mb-3">
                                <label for="modalDireccionPedidoFinalizar" class="form-label">Dirección:</label>
                                <input type="text" id="modalDireccionPedidoFinalizar" name="direccionPedido" class="form-control" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Confirmar Compra</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal para agregar nueva tarjeta -->
        <div class="modal fade" id="addCardModal" tabindex="-1" aria-labelledby="addCardModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-info text-white">
                        <h5 class="modal-title" id="addCardModalLabel">Agregar Nueva Tarjeta</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <form id="addCardForm" action="ServletTarjetas?accion=agregar" method="POST">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="ultimos4" class="form-label">Últimos 4 Dígitos</label>
                                <input type="text" name="ultimos4" maxlength="4" pattern="\d{4}" title="Ingrese exactamente 4 dígitos" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="marca" class="form-label">Marca de Tarjeta</label>
                                <select name="marca" class="form-control" required>
                                    <option value="">-- Seleccione Marca --</option>
                                    <option value="Visa">Visa</option>
                                    <option value="MasterCard">MasterCard</option>
                                    <option value="Amex">Amex</option>
                                    <option value="Discover">Discover</option>
                                    <option value="Otro">Otro</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="mesExpiracion" class="form-label">Fecha de Expiración</label>
                                <div class="row">
                                    <div class="col-6">
                                        <select id="mesExpiracion" name="mesExpiracion" class="form-select" required>
                                            <option value="">Mes</option>
                                            <c:forEach begin="1" end="12" var="mes">
                                                <option value="${mes < 10 ? '0' : ''}${mes}">${mes}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-6">
                                        <select id="anioExpiracion" name="anioExpiracion" class="form-select" required>
                                            <option value="">Año</option>
                                            <c:forEach begin="${2024}" end="${2035}" var="anio">
                                                <option value="${anio}">${anio}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="nombreTitular" class="form-label">Nombre del Titular</label>
                                <input type="text" name="nombreTitular" maxlength="40" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="tipoTarjeta" class="form-label">Tipo de Tarjeta</label>
                                <select name="tipoTarjeta" class="form-control" required>
                                    <option value="">-- Seleccione Tipo --</option>
                                    <option value="Crédito">Crédito</option>
                                    <option value="Débito">Débito</option>
                                    <option value="Prepago">Prepago</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar Tarjeta</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="resources/js/bootstrap.bundle.min.js"></script>
        <script>
                                                       function prepararModalAgregar() {
                                                           document.getElementById('pedidoModalLabel').innerText = 'Agregar Nuevo Pedido';
                                                           document.getElementById('pedidoForm').reset();
                                                           document.getElementById('formAccion').value = 'insertar';
                                                           document.getElementById('formCodigoPedido').value = '';
                                                           document.getElementById('modalEstadoPedido').value = 'En_proceso';
                                                       }

                                                       function prepararModalEditar(button) {
                                                           const row = button.closest('tr');
                                                           const codigo = row.dataset.codigo;
                                                           const fecha = row.dataset.fecha;
                                                           const estado = row.dataset.estado;
                                                           const total = row.dataset.total;
                                                           const direccion = row.dataset.direccion;
                                                           const usuario = row.dataset.usuario;
                                                           const recibo = row.dataset.recibo;

                                                           document.getElementById('pedidoModalLabel').innerText = 'Editar Pedido Código: ' + codigo;
                                                           document.getElementById('formCodigoPedido').value = codigo;
                                                           document.getElementById('modalFechaPedido').value = fecha;
                                                           document.getElementById('modalEstadoPedido').value = estado;
                                                           document.getElementById('modalTotalPedido').value = total;
                                                           document.getElementById('modalDireccionPedido').value = direccion;
                                                           document.getElementById('modalCodigoUsuario').value = usuario;
                                                           document.getElementById('modalCodigoRecibo').value = recibo;
                                                           document.getElementById('formAccion').value = 'actualizar';
                                                       }

                                                       var modalFinalizarCompra = document.getElementById('modalFinalizarCompra');
                                                       modalFinalizarCompra.addEventListener('show.bs.modal', function (event) {
                                                           var button = event.relatedTarget;
                                                           var codigoPedido = button.getAttribute('data-codigopedido');
                                                           var totalPedido = button.getAttribute('data-totalpedido');
                                                           var direccionPedido = button.getAttribute('data-direccionpedido');

                                                           document.getElementById('modalCodigoPedido').value = codigoPedido;
                                                           document.getElementById('modalMonto').value = totalPedido;
                                                           document.getElementById('modalDireccionPedidoFinalizar').value = direccionPedido;

                                                           const cardSelect = document.getElementById('modalCodigoTarjeta');
                                                           const addCardBtn = document.getElementById('addCardBtn');

                                                           if (cardSelect.options.length <= 1) {
                                                               addCardBtn.style.display = 'block';
                                                           } else {
                                                               addCardBtn.style.display = 'block';
                                                           }
                                                       });
        </script>
    </body>
</html>
