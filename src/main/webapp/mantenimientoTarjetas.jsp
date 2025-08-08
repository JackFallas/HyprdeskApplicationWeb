<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Tarjetas - Hyprdesk</title>
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
        <span class="navbar-text text-white ms-3 h4">Gestión de Tarjetas</span>
    </div>
</nav>

<div class="container">
    <div class="container-main">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Listado de Tarjetas</h1>
            <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#tarjetaModal" onclick="prepararModalAgregar()">
                <i class="bi bi-plus-circle"></i> Agregar Tarjeta
            </button>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>
        <c:if test="${param.success eq 'true'}">
            <div class="alert alert-success" role="alert">
                ¡Tarjeta guardada exitosamente!
            </div>
        </c:if>
        <c:if test="${param.deleted eq 'true'}">
            <div class="alert alert-success" role="alert">
                ¡Tarjeta eliminada exitosamente!
            </div>
        </c:if>

        <div class="table-responsive">
            <table class="table table-striped table-hover table-bordered table-custom" id="tablaTarjetas">
                <thead>
                    <tr>
                        <th scope="col">Código Tarjeta</th>
                        <th scope="col">Últimos 4 Dígitos</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Nombre Titular</th>
                        <th scope="col">Tipo Tarjeta</th>
                        <th scope="col">Fecha Expiración</th>
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listaTarjetas}">
                            <c:forEach var="tarjeta" items="${listaTarjetas}">
                                <tr data-codigo="${tarjeta.codigoTarjeta}"
                                    data-ultimos4="${tarjeta.ultimos4}"
                                    data-marca="${tarjeta.marca}"
                                    data-nombretitular="${tarjeta.nombreTitular}"
                                    data-tipotarjeta="${tarjeta.tipoTarjeta}"
                                    data-fechaexpiracion="<fmt:formatDate value='${tarjeta.fechaExpiracion}' pattern='yyyy-MM-dd'/>"
                                    data-token="${tarjeta.token}">
                                    <td>${tarjeta.codigoTarjeta}</td>
                                    <td>${tarjeta.ultimos4}</td>
                                    <td>${tarjeta.marca}</td>
                                    <td>${tarjeta.nombreTitular}</td>
                                    <td>${tarjeta.tipoTarjeta}</td>
                                    <td><fmt:formatDate value="${tarjeta.fechaExpiracion}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#tarjetaModal"
                                                onclick="prepararModalEditar(this)">Editar</button>
                                        <a href="${pageContext.request.contextPath}/ServletTarjetas?accion=eliminar&id=${tarjeta.codigoTarjeta}"
                                           class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar esta tarjeta?');">Eliminar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="7" class="text-center">No hay tarjetas registradas.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="tarjetaModal" tabindex="-1" aria-labelledby="tarjetaModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tarjetaModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="tarjetaForm" action="${pageContext.request.contextPath}/ServletTarjetas" method="post">
                    <input type="hidden" name="accion" id="formAccion" value="insertar">
                    <input type="hidden" name="codigoTarjeta" id="formCodigoTarjeta">
                    <%-- Eliminar o manejar este campo si el usuario ya no es un filtro --%>
                    <%-- <input type="hidden" name="codigoUsuario" id="formCodigoUsuario" value=""> --%>

                    <div class="mb-3">
                        <label for="modalUltimos4" class="form-label">Últimos 4 Dígitos:</label>
                        <input type="text" name="ultimos4" id="modalUltimos4" class="form-control" maxlength="4" pattern="[0-9]{4}" title="Debe contener exactamente 4 dígitos numéricos" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalMarca" class="form-label">Marca:</label>
                        <select id="modalMarca" name="marca" class="form-select" required>
                            <option value="Visa">Visa</option>
                            <option value="MasterCard">MasterCard</option>
                            <option value="Amex">Amex</option>
                            <option value="Discover">Discover</option>
                            <option value="Otro">Otro</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="modalToken" class="form-label">Token:</label>
                        <input type="text" name="token" id="modalToken" class="form-control" maxlength="36" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalNombreTitular" class="form-label">Nombre del Titular:</label>
                        <input type="text" name="nombreTitular" id="modalNombreTitular" class="form-control" maxlength="40" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalTipoTarjeta" class="form-label">Tipo de Tarjeta:</label>
                        <select id="modalTipoTarjeta" name="tipoTarjeta" class="form-select" required>
                            <option value="Crédito">Crédito</option>
                            <option value="Débito">Débito</option>
                            <option value="Prepago">Prepago</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="modalFechaExpiracion" class="form-label">Fecha de Expiración:</label>
                        <input type="date" name="fechaExpiracion" id="modalFechaExpiracion" class="form-control" required>
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
        document.getElementById('tarjetaModalLabel').innerText = 'Agregar Nueva Tarjeta';
        document.getElementById('tarjetaForm').reset();
        document.getElementById('formAccion').value = 'insertar';
        document.getElementById('formCodigoTarjeta').value = '';
        document.getElementById('modalMarca').value = 'Visa';
        document.getElementById('modalTipoTarjeta').value = 'Crédito';
    }

    function prepararModalEditar(button) {
        const row = button.closest('tr');
        const codigoTarjeta = row.dataset.codigo;
        const ultimos4 = row.dataset.ultimos4;
        const marca = row.dataset.marca;
        const token = row.dataset.token;
        const nombreTitular = row.dataset.nombretitular;
        const tipoTarjeta = row.dataset.tipotarjeta;
        const fechaExpiracion = row.dataset.fechaexpiracion; 

        document.getElementById('tarjetaModalLabel').innerText = 'Editar Tarjeta Código: ' + codigoTarjeta;
        document.getElementById('formCodigoTarjeta').value = codigoTarjeta;
        document.getElementById('modalUltimos4').value = ultimos4;
        document.getElementById('modalMarca').value = marca;
        document.getElementById('modalToken').value = token;
        document.getElementById('modalNombreTitular').value = nombreTitular;
        document.getElementById('modalTipoTarjeta').value = tipoTarjeta;
        document.getElementById('modalFechaExpiracion').value = fechaExpiracion;
        document.getElementById('formAccion').value = 'actualizar';
    }
</script>
</body>
</html>