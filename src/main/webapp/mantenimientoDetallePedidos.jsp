<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Gestión de Detalles de Pedido - Hyprdesk</title>
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
            .header .logo-text { /* Estilo para el texto del logo "Gestión de Detalles de Pedido" */
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

            /* Estilos del CRUD de Detalles de Pedido (originales de tu archivo - se mantienen) */
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
                <a href="ServletPedidos" class="menu__item">
                    <i class='bx bx-cart'></i><span>Pedidos</span>
                </a>
                <a href="ServletDetallePedido" class="menu__item active"> <!-- DETALLE DE PEDIDOS ACTIVO -->
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
            <nav class="navbar navbar-expand-lg navbar-dark mb-4">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">
                        <!-- LOGO ELIMINADO -->
                    </a>
                    <span class="navbar-text ms-3 h4" style="color: black !important;">
                        Gestión de Detalles de Pedido
                    </span>
                </div>
            </nav>
            <div class="container">
                <div class="container-main">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1>Listado de Detalles de Pedido</h1>
                        <%-- JSTL para mostrar el botón solo si el rol es 'Admin' --%>
                        <c:if test="${rol == 'Admin'}">
                            <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#detallePedidoModal"
                                    onclick="prepararModalAgregar()">
                                <i class="bi bi-plus-circle"></i> Agregar Detalle
                            </button>
                        </c:if>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered table-custom" id="tablaDetallePedidos">
                            <thead>
                                <tr>
                                    <th scope="col">ID Detalle</th>
                                    <th scope="col">Producto</th>
                                    <th scope="col">Cantidad</th>
                                    <th scope="col">Precio</th>
                                    <th scope="col">Subtotal</th>
                                    <th scope="col">Código Pedido</th>
                                    <%-- JSTL para mostrar la columna 'Acciones' solo si el rol es 'Admin' --%>
                                    <c:if test="${rol == 'Admin'}">
                                        <th scope="col">Acciones</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detalle" items="${listaDetallePedidos}">
                                    <tr data-codigoDetallePedido="${detalle.codigoDetallePedido}"
                                        data-codigoproducto="${detalle.producto.codigoProducto}"
                                        data-cantidad="${detalle.cantidad}"
                                        data-precio="${detalle.precio}"
                                        data-subtotal="${detalle.subtotal}"
                                        data-codigopedido="${detalle.pedido.codigoPedido}">
                                        <td>${detalle.codigoDetallePedido}</td>
                                        <td>${detalle.producto.nombre}</td>
                                        <td>${detalle.cantidad}</td>
                                        <td>${detalle.precio}</td>
                                        <td>${detalle.subtotal}</td>
                                        <td>${detalle.pedido.codigoPedido}</td>
                                        <%-- JSTL para mostrar las acciones por fila solo si el rol es 'Admin' --%>
                                        <c:if test="${rol == 'Admin'}">
                                            <td>
                                                <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#detallePedidoModal"
                                                        onclick="prepararModalEditar(this)">Editar</button>
                                                <a href="${pageContext.request.contextPath}/ServletDetallePedido?accion=eliminar&id=${detalle.codigoDetallePedido}" class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este detalle de pedido?');">Eliminar</a>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <%-- Modal para Agregar/Editar Detalle de Pedido --%>
            <div class="modal fade" id="detallePedidoModal" tabindex="-1" aria-labelledby="detallePedidoModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="detallePedidoModalLabel"></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="detallePedidoForm" action="${pageContext.request.contextPath}/ServletDetallePedido" method="post">
                                <input type="hidden" name="accion" id="formAccion" value="guardar">
                                <input type="hidden" name="codigoDetallePedido" id="formCodigoDetallePedido">
                                <div class="mb-3">
                                    <label for="modalCantidad" class="form-label">Cantidad:</label>
                                    <input type="number" name="cantidad" id="modalCantidad" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalPrecio" class="form-label">Precio:</label>
                                    <input type="number" step="0.01" name="precio" id="modalPrecio" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalSubtotal" class="form-label">Subtotal:</label>
                                    <input type="number" step="0.01" name="subtotal" id="modalSubtotal" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalCodigoPedido" class="form-label">Código Pedido:</label>
                                    <input type="number" name="codigoPedido" id="modalCodigoPedido" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalCodigoProducto" class="form-label">Código Producto:</label>
                                    <input type="number" name="codigoProducto" id="modalCodigoProducto" class="form-control" required>
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
            
            <div class="modal fade" id="finalizarCompraModal" tabindex="-1" aria-labelledby="finalizarCompraModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <form id="formFinalizarCompra" action="${pageContext.request.contextPath}/ServletRecibos" method="post">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="finalizarCompraModalLabel">Finalizar Compra - Datos del Recibo</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="codigoPedido" id="modalCodigoPedido">
                                <input type="hidden" name="codigoUsuario" id="modalCodigoUsuario" value="${codigoUsuarioLogueado}">
                                <input type="hidden" name="metodoPago" value="Tarjeta">

                                <div class="mb-3">
                                    <label for="modalMonto" class="form-label">Monto:</label>
                                    <input type="number" name="monto" id="modalMonto" class="form-control" step="0.01" readonly>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="modalCodigoTarjeta" class="form-label">Código Tarjeta (opcional):</label>
                                    <input type="number" name="codigoTarjeta" id="modalCodigoTarjeta" class="form-control" placeholder="Ingrese código tarjeta si aplica">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Confirmar Pago</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <script src="resources/js/bootstrap.bundle.min.js"></script>
        <script>
            function prepararModalAgregar() {
                document.getElementById('detallePedidoModalLabel').innerText = 'Agregar Nuevo Detalle de Pedido';
                document.getElementById('detallePedidoForm').reset();
                document.getElementById('formAccion').value = 'guardar';
                document.getElementById('formCodigoDetallePedido').value = ''; // Asegura que el ID esté vacío para agregar
            }

            function prepararModalEditar(button) {
                const row = button.closest('tr'); // Obtiene la fila completa
                const codigoDetallePedido = row.dataset.codigodetallepedido;
                const cantidad = row.dataset.cantidad;
                const precio = row.dataset.precio;
                const subtotal = row.dataset.subtotal;
                const codigoPedido = row.dataset.codigopedido;
                const codigoProducto = row.dataset.codigoproducto;

                document.getElementById('detallePedidoModalLabel').innerText = 'Editar Detalle de Pedido ID: ' + codigoDetallePedido;
                document.getElementById('formCodigoDetallePedido').value = codigoDetallePedido;
                document.getElementById('modalCantidad').value = cantidad;
                document.getElementById('modalPrecio').value = precio;
                document.getElementById('modalSubtotal').value = subtotal;
                document.getElementById('modalCodigoPedido').value = codigoPedido;
                document.getElementById('modalCodigoProducto').value = codigoProducto;
                document.getElementById('formAccion').value = 'actualizar'; // Cambia la acción a 'actualizar'
            }
        </script>
        
        <script>
            var finalizarModal = document.getElementById('finalizarCompraModal');

            finalizarModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var codigoPedido = button.getAttribute('data-codigopedido');
                var totalPedido = button.getAttribute('data-totalpedido');

                document.getElementById('modalCodigoPedido').value = codigoPedido;
                document.getElementById('modalMonto').value = totalPedido;
                document.getElementById('modalCodigoTarjeta').value = '';
            });
        </script>
    </body>
</html>
