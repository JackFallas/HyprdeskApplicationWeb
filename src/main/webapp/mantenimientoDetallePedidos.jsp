<%--
    Document   : listarDetallePedidos.jsp
    Created on : 29 jul 2025
    Author     : Diego Leiva
--%>

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
        <style>
            :root {
                --primary-blue: #3498DB;
                --light-blue-1: #5DADE2;
                --light-blue-2: #AED6F1;
                --light-blue-3: #D6EAF8;
                --gray-text: #717D7E;
            }
            body {
                background-color: var(--light-blue-3);
                color: var(--gray-text);
            }
            .navbar {
                background-color: var(--primary-blue);
            }
            .navbar-brand img {
                height: 50px;
            }
            .container-main {
                background-color: white;
                border-radius: .5rem;
                padding: 2rem;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }
            h1, h2, h3, h4, h5, h6 {
                color: var(--primary-blue);
            }
            .table-custom th {
                background-color: var(--light-blue-1);
                color: white;
                border-color: var(--primary-blue);
            }
            .table-custom td {
                border-color: var(--light-blue-2);
            }
            .btn-edit {
                background-color: var(--primary-blue);
                border-color: var(--primary-blue);
                color: white;
            }
            .btn-edit:hover {
                background-color: var(--light-blue-1);
                border-color: var(--light-blue-1);
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
                background-color: var(--primary-blue);
                border-color: var(--primary-blue);
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
                background-color: var(--primary-blue);
                color: white;
                border-bottom: 1px solid var(--light-blue-1);
            }
            .modal-header .btn-close {
                filter: invert(1);
            }
            .modal-footer {
                border-top: 1px solid var(--light-blue-2);
                justify-content: flex-end;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark mb-4">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <img src="resources/img/Logo con nombre.png" alt="Hyprdesk Logo">
                </a>
                <span class="navbar-text text-white ms-3 h4">
                    Gestión de Detalles de Pedido
                </span>
            </div>
        </nav>
        <div class="container">
            <div class="container-main">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Listado de Detalles de Pedido</h1>
                    <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#detallePedidoModal"
                            onclick="prepararModalAgregar()">
                        <i class="bi bi-plus-circle"></i> Agregar Detalle
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered table-custom" id="tablaDetallePedidos">
                        <thead>
                            <tr>
                                <th scope="col">ID Detalle</th>
                                <th scope="col">Cantidad</th>
                                <th scope="col">Precio</th>
                                <th scope="col">Subtotal</th>
                                <th scope="col">Código Pedido</th>
                                <th scope="col">Código Producto</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detalle" items="${listaDetallePedidos}">
                                <tr data-codigoDetallePedido="${detalle.codigoDetallePedido}"
                                    data-cantidad="${detalle.cantidad}"
                                    data-precio="${detalle.precio}"
                                    data-subtotal="${detalle.subtotal}"
                                    data-codigopedido="${detalle.pedido.codigoPedido}"
                                    data-codigoproducto="${detalle.producto.codigoProducto}">
                                    <td>${detalle.codigoDetallePedido}</td>
                                    <td>${detalle.cantidad}</td>
                                    <td>${detalle.precio}</td>
                                    <td>${detalle.subtotal}</td>
                                    <td>${detalle.pedido.codigoPedido}</td>
                                    <td>${detalle.producto.codigoProducto}</td>
                                    <td>
                                        <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#detallePedidoModal"
                                                onclick="prepararModalEditar(this)">Editar</button>
                                        <a href="${pageContext.request.contextPath}/ServletDetallePedido?accion=eliminar&id=${detalle.codigoDetallePedido}" class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este detalle de pedido?');">Eliminar</a>
                                    </td>
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

        <script src="resources/js/bootstrap.bundle.min.js"></script>
        <script>
            /**
             * Prepara el modal para la operación de "Agregar nuevo Detalle de Pedido".
             * Limpia el formulario y establece la acción a "guardar".
             */
            function prepararModalAgregar() {
                document.getElementById('detallePedidoModalLabel').innerText = 'Agregar Nuevo Detalle de Pedido';
                document.getElementById('detallePedidoForm').reset();
                document.getElementById('formAccion').value = 'guardar';
                document.getElementById('formCodigoDetallePedido').value = ''; // Asegura que el ID esté vacío para agregar
            }

            /**
             * Prepara el modal para la operación de "Editar Detalle de Pedido".
             * Carga los datos del detalle seleccionado en el formulario y establece la acción a "actualizar".
             * @param {HTMLButtonElement} button El botón "Editar" que fue clickeado.
             */
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
    </body>
</html>
