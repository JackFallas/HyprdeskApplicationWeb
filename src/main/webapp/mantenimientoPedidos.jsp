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
                        <input type="hidden" name="codigoUsuario" value="${codigoUsuarioLogueado}">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="ultimos4" class="form-label">Últimos 4 Dígitos</label>
                                <input type="text" name="ultimos4" maxlength="4" pattern="\d{4}" title="Ingrese exactamente 4 dígitos" required>
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
                                <label for="fechaExpiracion" class="form-label">Fecha de Expiración</label>
                                <input type="date" name="fechaExpiracion" class="form-control" required>
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
