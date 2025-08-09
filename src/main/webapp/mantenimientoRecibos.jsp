<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Recibos - Hyprdesk</title>
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
            <img src="${pageContext.request.contextPath}/resources/image/Logo con nombre.png" alt="Hyprdesk Logo">
        </a>
        <span class="navbar-text text-white ms-3 h4">Gestión de Recibos</span>
    </div>
</nav>

<div class="container">
    <div class="container-main">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Listado de Recibos</h1>
            <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#reciboModal" onclick="prepararModalAgregar()">
                <i class="bi bi-plus-circle"></i> Agregar Recibo
            </button>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>
        <c:if test="${param.success eq 'true'}">
            <div class="alert alert-success" role="alert">
                ¡Recibo guardado exitosamente!
            </div>
        </c:if>
        <c:if test="${param.deleted eq 'true'}">
            <div class="alert alert-success" role="alert">
                ¡Recibo eliminado exitosamente!
            </div>
        </c:if>

        <div class="table-responsive">
            <table class="table table-striped table-hover table-bordered table-custom" id="tablaRecibos">
                <thead>
                    <tr>
                        <th scope="col">Código Recibo</th>
                        <th scope="col">Monto</th>
                        <th scope="col">Método de Pago</th>
                        <th scope="col">Código Usuario</th>
                        <th scope="col">Código Tarjeta</th>
                        <th scope="col">Fecha de Pago</th>
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listaRecibos}">
                            <c:forEach var="recibo" items="${listaRecibos}">
                                <tr data-codigo="${recibo.codigoRecibo}"
                                    data-monto="${recibo.monto}"
                                    data-metodopago="${recibo.metodoPago}"
                                    data-codigousuario="${recibo.codigoUsuario}"
                                    data-codigotarjeta="${recibo.codigoTarjeta}">
                                    <td>${recibo.codigoRecibo}</td>
                                    <td><fmt:formatNumber value="${recibo.monto}" type="currency" currencySymbol="Q"/></td>
                                    <td>${recibo.metodoPago}</td>
                                    <td>${recibo.codigoUsuario}</td>
                                    <td>${recibo.codigoTarjeta}</td>
                                    <td><fmt:formatDate value="${recibo.fechaPago}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>
                                        <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#reciboModal"
                                                onclick="prepararModalEditar(this)">Editar</button>
                                        <a href="${pageContext.request.contextPath}/ServletRecibos?accion=eliminar&id=${recibo.codigoRecibo}"
                                           class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este recibo?');">Eliminar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="7" class="text-center">No hay recibos registrados.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="reciboModal" tabindex="-1" aria-labelledby="reciboModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reciboModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="reciboForm" action="${pageContext.request.contextPath}/ServletRecibos" method="post">
                    <input type="hidden" name="accion" id="formAccion" value="insertar">
                    <input type="hidden" name="codigoRecibo" id="formCodigoRecibo">
                    
                    <div class="mb-3">
                        <label for="modalMonto" class="form-label">Monto:</label>
                        <input type="number" step="0.01" name="monto" id="modalMonto" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalMetodoPago" class="form-label">Método de Pago:</label>
                        <input type="text" name="metodoPago" id="modalMetodoPago" class="form-control" maxlength="64" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalCodigoUsuario" class="form-label">Código de Usuario:</label>
                        <input type="number" name="codigoUsuario" id="modalCodigoUsuario" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalCodigoTarjeta" class="form-label">Código de Tarjeta:</label>
                        <input type="number" name="codigoTarjeta" id="modalCodigoTarjeta" class="form-control">
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

<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script>
    function prepararModalAgregar() {
        document.getElementById('reciboModalLabel').innerText = 'Agregar Nuevo Recibo';
        document.getElementById('reciboForm').reset();
        document.getElementById('formAccion').value = 'insertar';
        document.getElementById('formCodigoRecibo').value = '';
    }

    function prepararModalEditar(button) {
        const row = button.closest('tr');
        const codigoRecibo = row.dataset.codigo;
        const monto = row.dataset.monto;
        const metodoPago = row.dataset.metodopago;
        const codigoUsuario = row.dataset.codigousuario;
        const codigoTarjeta = row.dataset.codigotarjeta;

        document.getElementById('reciboModalLabel').innerText = 'Editar Recibo Código: ' + codigoRecibo;
        document.getElementById('formCodigoRecibo').value = codigoRecibo;
        document.getElementById('modalMonto').value = monto;
        document.getElementById('modalMetodoPago').value = metodoPago;
        document.getElementById('modalCodigoUsuario').value = codigoUsuario;
        document.getElementById('modalCodigoTarjeta').value = codigoTarjeta;
        document.getElementById('formAccion').value = 'actualizar';
    }
</script>
</body>
</html>
