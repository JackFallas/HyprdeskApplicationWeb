<%@ page import="java.util.List" %>
<%@ page import="model.Usuario" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mantenimiento - Usuarios</title>
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

                --original-primary-blue: #3498DB; /* Azul principal de tu diseño original */
                --original-light-blue-1: #5DADE2;
                --original-light-blue-2: #AED6F1;
                --original-light-blue-3: #D6EAF8;
                --original-gray-text: #717D7E;
            }

            body {
                background-color: var(--original-light-blue-3); /* Fondo principal de la página con tu color original */
                font-family: 'Poppins', sans-serif; /* Asegurar la fuente Poppins */
                display: flex; /* **Esencial:** Habilitar flexbox para el layout principal con sidebar */
                color: var(--original-gray-text);
                margin: 0; /* Elimina márgenes por defecto del body */
                min-height: 100vh;
                overflow-x: hidden; /* Evitar scroll horizontal */
            }

            /* No se necesita .d-flex como wrapper principal si body ya es flex */

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

            .header .logo-text { /* Estilo para el texto del logo "Usuarios" */
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
            .profile img{
                /* Se elimina el logo del perfil */
                display: none; /* Ocultar la imagen del logo en el perfil */
            }
            .profile__info{
                /* Este div se mantiene pero su contenido se vacía según la solicitud */
                opacity: 1; /* Asegurar que el contenedor sea visible si tiene otros elementos */
                transform: none; /* No aplicar transformaciones de ocultamiento */
            }
            .profile__info .name, .profile__info .plan {
                display: none; /* Ocultar los textos "Admin" y "Derechos Reservados" */
            }


            /* Estilos del CRUD de Usuarios (originales de tu archivo - se mantienen) */
            .container-main {
                background-color: white;
                border-radius: .5rem;
                padding: 2rem; /* Mantener padding original del container-main */
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
            .btn-primary { /* Estilo para el botón de agregar usuario */
                background-color: var(--original-primary-blue);
                border-color: var(--original-primary-blue);
                color: white;
            }
            .btn-primary:hover {
                background-color: var(--original-light-blue-1);
                border-color: var(--original-light-blue-1);
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
                /* Ajustes para tablets y pantallas medianas */
                .sidebar {
                    width: 80px; /* Colapsado por defecto */
                    left: 0;
                }
                #nav-toggle:checked + .toggle-btn + .sidebar {
                    left: 0; /* Asegurar que se muestre al chequear */
                }
                .main-content {
                    padding-left: calc(var(--sidebar-collapsed) + 20px); /* Compensar sidebar colapsado + padding */
                }
                #nav-toggle:checked ~ .main-content { /* Corregido para usar ~ en lugar de + en el selector */
                    padding-left: calc(var(--sidebar-expanded) + 20px); /* Compensar sidebar expandido + padding */
                }
                .toggle-btn {
                    left: 18px; /* Mantener a la izquierda de la pantalla */
                    color: var(--text); /* Cambiar color para que contraste con la navbar original si es necesario */
                }
                #nav-toggle:checked + .toggle-btn {
                    left: 18px; /* No mover el botón toggle en esta resolución */
                }
            }

            @media (max-width: 767px) {
                /* Ajustes para móviles */
                .sidebar {
                    width: 0; /* Ocultar sidebar por defecto en móviles */
                    left: -80px; /* Asegurarse de que esté fuera de la vista */
                }
                #nav-toggle:checked + .toggle-btn + .sidebar {
                    width: 200px; /* Un poco más pequeño que el tamaño expandido de escritorio */
                    left: 0;
                }
                .main-content {
                    padding-left: 20px; /* Sin margen inicial debido al sidebar oculto */
                }
                #nav-toggle:checked ~ .main-content { /* Corregido para usar ~ en lugar de + en el selector */
                    padding-left: calc(200px + 20px); /* Ajuste para el sidebar expandido en móvil */
                }
                .toggle-btn {
                    left: 10px; /* Mover el botón más a la izquierda en pantallas pequeñas */
                    top: 10px;
                    font-size: 1.8rem;
                    width: 38px;
                    height: 38px;
                    background: var(--original-primary-blue); /* Color del botón acorde a la navbar */
                }
                #nav-toggle:checked + .toggle-btn {
                    left: calc(200px + 10px); /* Mover el botón cuando el sidebar se expande */
                }
                h1 {
                    font-size: 1.5rem;
                    margin-bottom: 15px !important;
                }
                .btn-primary, .btn-report { /* Ajuste para los botones */
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
        <!-- Input y botón de toggle para el sidebar (ahora están al principio del body) -->
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
                <a href="ServletUsuario" class="menu__item active"> <!-- USUARIOS ACTIVO -->
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
            <!-- Navbar original (RESTAURADA, ahora dentro de main-content para el flujo normal) -->
            <nav class="navbar navbar-expand-lg navbar-dark mb-4">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">
                        <!-- LOGO ELIMINADO -->
                    </a>
                    <span class="navbar-text ms-3 h4" style="color: black !important;">
                        Usuarios
                    </span>
                </div>
            </nav>
            <div class="container">
                <div class="container-main">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1>Listado de Usuarios</h1>
                        <div> <!-- Contenedor para los botones -->
                            <!-- Botón de Agregar Usuario (modificado para usar el modal) -->
                            <button type="button" class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#usuarioModal" onclick="prepararModalAgregar()">
                                <i class="bi bi-plus-circle"></i> Agregar Usuario
                            </button>
                            <!-- Nuevo botón para descargar el reporte -->
                            <a href="${pageContext.request.contextPath}/ServletReportes?nombre=usuarios" class="btn btn-report" target="_blank">
                                <i class='bx bx-download'></i> Descargar Reporte
                            </a>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered table-custom" id="tablaUsuarios">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Apellido</th>
                                    <th>Teléfono</th>
                                    <th>Dirección</th>
                                    <th>Email</th>
                                    <th>Contraseña</th>
                                    <th>Estado</th>
                                    <th>Rol</th>
                                    <th>Fecha de Nacimiento</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="usuario" items="${listaUsuarios}">
                                    <tr>
                                        <td>${usuario.codigoUsuario}</td>
                                        <td>${usuario.nombreUsuario}</td>
                                        <td>${usuario.apellidoUsuario}</td>
                                        <td>${usuario.telefono}</td>
                                        <td>${usuario.direccionUsuario}</td>
                                        <td>${usuario.email}</td>
                                        <td>${usuario.contrasena}</td>
                                        <td>${usuario.estadoUsuario}</td>
                                        <td>${usuario.rol}</td>
                                        <td>${usuario.fechaNacimiento}</td>
                                        <td>
                                            <!-- Botón Editar abre el modal con datos -->
                                            <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#usuarioModal"
                                                    onclick="prepararModalEditar('${usuario.codigoUsuario}', '${usuario.nombreUsuario}', '${usuario.apellidoUsuario}', '${usuario.telefono}', '${usuario.direccionUsuario}', '${usuario.email}', '${usuario.contrasena}', '${usuario.estadoUsuario}', '${usuario.rol}', '${usuario.fechaNacimiento}')">
                                                Editar
                                            </button>
                                            <a href="${pageContext.request.contextPath}/ServletUsuario?accion=eliminar&id=${usuario.codigoUsuario}" class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este usuario?');">Eliminar</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listaUsuarios}">
                                    <tr>
                                        <td colspan="11" class="text-center">No hay usuarios registrados.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <c:if test="${not empty usuarioEditar}">
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const usuarioModal = new bootstrap.Modal(document.getElementById('usuarioModal'));
                        usuarioModal.show();
                    });
                </script>
            </c:if>

            <div class="modal fade" id="usuarioModal" tabindex="-1" aria-labelledby="usuarioModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="usuarioModalLabel">
                                <c:if test="${not empty usuarioEditar}">Editar Usuario ID: ${usuarioEditar.codigoUsuario}</c:if>
                                <c:if test="${empty usuarioEditar}">Agregar Nuevo Usuario</c:if>
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="usuarioForm" action="${pageContext.request.contextPath}/ServletUsuario" method="post">
                                <input type="hidden" name="accion" id="formAccion" value="actualizar">
                                <input type="hidden" name="codigoUsuario" id="formCodigoUsuario" value="${usuarioEditar.codigoUsuario}">

                                <div class="mb-3">
                                    <label for="modalNombre" class="form-label">Nombre:</label>
                                    <input type="text" name="nombreUsuario" id="modalNombre" class="form-control" value="${usuarioEditar.nombreUsuario}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalApellido" class="form-label">Apellido:</label>
                                    <input type="text" name="apellidoUsuario" id="modalApellido" class="form-control" value="${usuarioEditar.apellidoUsuario}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalTelefono" class="form-label">Teléfono:</label>
                                    <input type="text" name="telefono" id="modalTelefono" class="form-control" value="${usuarioEditar.telefono}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalDireccion" class="form-label">Dirección:</label>
                                    <input type="text" name="direccionUsuario" id="modalDireccion" class="form-control" value="${usuarioEditar.direccionUsuario}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="modalEmail" class="form-label">Email:</label>
                                        <input type="email" name="email" id="modalEmail" class="form-control" value="${usuarioEditar.email}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="modalContrasena" class="form-label">Contraseña:</label>
                                        <input type="password" name="contrasena" id="modalContrasena" class="form-control" value="${usuarioEditar.contrasena}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="modalEstadoUsuario" class="form-label">Estado:</label>
                                        <select name="estadoUsuario" id="modalEstadoUsuario" class="form-select" required>
                                            <option value="Activo" <c:if test="${usuarioEditar.estadoUsuario == 'Activo'}">selected</c:if>>Activo</option>
                                            <option value="Inactivo" <c:if test="${usuarioEditar.estadoUsuario == 'Inactivo'}">selected</c:if>>Inactivo</option>
                                            <option value="Suspendido" <c:if test="${usuarioEditar.estadoUsuario == 'Suspendido'}">selected</c:if>>Suspendido</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="modalRol" class="form-label">Rol:</label>
                                        <select name="rol" id="modalRol" class="form-select" required>
                                            <option value="Admin" <c:if test="${usuarioEditar.rol == 'Admin'}">selected</c:if>>Admin</option>
                                            <option value="Empleado" <c:if test="${usuarioEditar.rol == 'Empleado'}">selected</c:if>>Empleado</option>
                                            <option value="Usuario" <c:if test="${usuarioEditar.rol == 'Usuario'}">selected</c:if>>Usuario</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="modalFechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                                        <input type="date" name="fechaNacimiento" id="modalFechaNacimiento" class="form-control" value="${usuarioEditar.fechaNacimiento}">
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
        <script>
            // Función para preparar el modal de "Agregar Usuario"
            function prepararModalAgregar() {
                document.getElementById('usuarioModalLabel').innerText = 'Agregar Nuevo Usuario';
                document.getElementById('usuarioForm').reset(); // Limpia el formulario
                document.getElementById('formAccion').value = 'agregar'; // Establece la acción a 'agregar'
                document.getElementById('formCodigoUsuario').value = ''; // Vacía el ID
            }

            // Función para preparar el modal de "Editar Usuario"
            function prepararModalEditar(codigoUsuario, nombreUsuario, apellidoUsuario, telefono, direccionUsuario, email, contrasena, estadoUsuario, rol, fechaNacimiento) {
                document.getElementById('usuarioModalLabel').innerText = 'Editar Usuario ID: ' + codigoUsuario;
                document.getElementById('formAccion').value = 'actualizar';
                document.getElementById('formCodigoUsuario').value = codigoUsuario;
                document.getElementById('modalNombre').value = nombreUsuario;
                document.getElementById('modalApellido').value = apellidoUsuario;
                document.getElementById('modalTelefono').value = telefono;
                document.getElementById('modalDireccion').value = direccionUsuario;
                document.getElementById('modalEmail').value = email;
                document.getElementById('modalContrasena').value = contrasena; // Puede que necesites manejar esto de forma segura
                document.getElementById('modalEstadoUsuario').value = estadoUsuario;
                document.getElementById('modalRol').value = rol;
                document.getElementById('modalFechaNacimiento').value = fechaNacimiento;
            }
        </script>
    </body>
</html>
