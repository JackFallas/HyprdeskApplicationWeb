<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Pedidos - Hyprdesk</title>
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
        .status-disponible {
            color: #28a745;
            font-weight: bold;
        }
        .status-no-disponible {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="${pageContext.request.contextPath}/resources/image/Logo con nombre.png" alt="Hyprdesk Logo">
        </a>
        <span class="navbar-text text-white ms-3 h4">Gestión de Pedidos</span>
    </div>
</nav>

<div class="container">
    <div class="container-main">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Listado de Pedidos</h1>
            <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#pedidoModal" onclick="prepararModalAgregar()">
                <i class="bi bi-plus-circle"></i> Agregar Pedido
            </button>
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
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listaPedidos}">
                            <c:forEach var="pedido" items="${listaPedidos}">
                                <tr data-codigo="${pedido.codigoPedido}"
                                    data-fecha="${pedido.fechaPedido}"
                                    data-estado="${pedido.estadoPedido}"
                                    data-total="${pedido.totalPedido}"
                                    data-direccion="${pedido.direccionPedido}"
                                    data-usuario="${pedido.codigoUsuario}">
                                    <td>${pedido.codigoPedido}</td>
                                    <td>${pedido.fechaPedido}</td>
                                    <td>${pedido.estadoPedido}</td>
                                    <td>${pedido.totalPedido}</td>
                                    <td>${pedido.direccionPedido}</td>
                                    <td>
                                        <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#pedidoModal"
                                                onclick="prepararModalEditar(this)">Editar</button>
                                        <a href="${pageContext.request.contextPath}/ServletPedidos?accion=eliminar&id=${pedido.codigoPedido}"
                                           class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este pedido?');">Eliminar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="6" class="text-center">No hay pedidos registrados.</td></tr>
                        </c:otherwise>
                    </c:choose>
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
                            <option value="PENDIENTE">Pendiente</option>
                            <option value="ENVIADO">Enviado</option>
                            <option value="ENTREGADO">Entregado</option>
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
    function prepararModalAgregar() {
        document.getElementById('pedidoModalLabel').innerText = 'Agregar Nuevo Pedido';
        document.getElementById('pedidoForm').reset();
        document.getElementById('formAccion').value = 'insertar';
        document.getElementById('formCodigoPedido').value = '';
        document.getElementById('modalEstadoPedido').value = 'PENDIENTE';
    }

    function prepararModalEditar(button) {
        const row = button.closest('tr');
        const codigo = row.dataset.codigo;
        const fecha = row.dataset.fecha;
        const estado = row.dataset.estado;
        const total = row.dataset.total;
        const direccion = row.dataset.direccion;
        const usuario = row.dataset.usuario;

        document.getElementById('pedidoModalLabel').innerText = 'Editar Pedido Código: ' + codigo;
        document.getElementById('formCodigoPedido').value = codigo;
        document.getElementById('modalFechaPedido').value = fecha;
        document.getElementById('modalEstadoPedido').value = estado;
        document.getElementById('modalTotalPedido').value = total;
        document.getElementById('modalDireccionPedido').value = direccion;
        document.getElementById('modalCodigoUsuario').value = usuario;
        document.getElementById('formAccion').value = 'actualizar';
    }
</script>
</body>
</html>
