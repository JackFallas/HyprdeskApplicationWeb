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
        body { background-color: var(--light-blue-3); color: var(--gray-text); }
        .navbar { background-color: var(--primary-blue); }
        .navbar-brand img { height: 50px; }
        .container-main { background-color: white; border-radius: .5rem; padding: 2rem; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15); }
        h1, h2, h3, h4, h5, h6 { color: var(--primary-blue); }
        .table-custom th { background-color: var(--light-blue-1); color: white; border-color: var(--primary-blue); }
        .table-custom td { border-color: var(--light-blue-2); }
        .btn-edit, .btn-add { background-color: var(--primary-blue); border-color: var(--primary-blue); color: white; }
        .btn-edit:hover, .btn-add:hover { background-color: var(--light-blue-1); border-color: var(--light-blue-1); }
        .btn-delete { background-color: #dc3545; border-color: #dc3545; color: white; }
        .btn-delete:hover { background-color: #c82333; border-color: #bd2130; }
        .modal-header { background-color: var(--primary-blue); color: white; border-bottom: 1px solid var(--light-blue-1); }
        .modal-header .btn-close { filter: invert(1); }
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
            <div class="alert alert-danger" role="alert">${error}</div>
        </c:if>
        <c:if test="${param.success eq 'true'}">
            <div class="alert alert-success" role="alert">¡Tarjeta guardada exitosamente!</div>
        </c:if>
        <c:if test="${param.deleted eq 'true'}">
            <div class="alert alert-success" role="alert">¡Tarjeta eliminada exitosamente!</div>
        </c:if>

        <div class="table-responsive">
            <table class="table table-striped table-hover table-bordered table-custom" id="tablaTarjetas">
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Cód. Usuario</th>
                        <th>Titular</th>
                        <th>Marca</th>
                        <th>Terminación</th>
                        <th>Expira</th>
                        <th>Tipo</th>
                        <th>Registrada</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tarjeta" items="${listaTarjetas}">
                        <tr data-codigotarjeta="${tarjeta.codigoTarjeta}"
                            data-codigousuario="${tarjeta.codigoUsuario}"
                            data-ultimos4="${tarjeta.ultimos4}"
                            data-marca="${tarjeta.marca}"
                            data-fechaexpiracion="<fmt:formatDate value='${tarjeta.fechaExpiracion}' pattern='yyyy-MM-dd'/>"
                            data-nombretitular="${tarjeta.nombreTitular}"
                            data-tipotarjeta="${tarjeta.tipoTarjeta}">
                            <td>${tarjeta.codigoTarjeta}</td>
                            <td>${tarjeta.codigoUsuario}</td>
                            <td>${tarjeta.nombreTitular}</td>
                            <td>${tarjeta.marca}</td>
                            <td>**** ${tarjeta.ultimos4}</td>
                            <td><fmt:formatDate value="${tarjeta.fechaExpiracion}" pattern="MM/yy"/></td>
                            <td>${tarjeta.tipoTarjeta}</td>
                            <td><fmt:formatDate value="${tarjeta.fechaRegistro}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#tarjetaModal" onclick="prepararModalEditar(this)">Editar</button>
                                <a href="${pageContext.request.contextPath}/ServletTarjetas?accion=eliminar&id=${tarjeta.codigoTarjeta}"
                                   class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar esta tarjeta?');">Eliminar</a>
                            </td>
                        </tr>
                    </c:forEach>
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
                    <input type="hidden" name="accion" id="formAccion">
                    <input type="hidden" name="codigoTarjeta" id="formCodigoTarjeta">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="modalNombreTitular" class="form-label">Nombre del Titular:</label>
                            <input type="text" name="nombreTitular" id="modalNombreTitular" class="form-control" required maxlength="40">
                        </div>
                        <div class="col-md-6 mb-3">
                             <label for="modalCodigoUsuario" class="form-label">Código de Usuario:</label>
                             <input type="number" name="codigoUsuario" id="modalCodigoUsuario" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="row">
                         <div class="col-md-6 mb-3">
                            <label for="modalUltimos4" class="form-label">Últimos 4 Dígitos:</label>
                            <input type="text" name="ultimos4" id="modalUltimos4" class="form-control" required pattern="\d{4}" title="Debe ingresar 4 dígitos numéricos">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="modalFechaExpiracion" class="form-label">Fecha de Expiración:</label>
                            <input type="date" name="fechaExpiracion" id="modalFechaExpiracion" class="form-control" required>
                        </div>
                    </div>

                    <div class="row">
                         <div class="col-md-6 mb-3">
                            <label for="modalMarca" class="form-label">Marca:</label>
                            <select name="marca" id="modalMarca" class="form-select" required>
                                <option value="Visa">Visa</option>
                                <option value="MasterCard">MasterCard</option>
                                <option value="Amex">Amex</option>
                                <option value="Discover">Discover</option>
                                <option value="Otro">Otro</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                             <label for="modalTipoTarjeta" class="form-label">Tipo de Tarjeta:</label>
                             <select name="tipoTarjeta" id="modalTipoTarjeta" class="form-select" required>
                                 <option value="Crédito">Crédito</option>
                                 <option value="Débito">Débito</option>
                                 <option value="Prepago">Prepago</option>
                             </select>
                        </div>
                    </div>

                    <div class="modal-footer mt-4">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
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
    }

    function prepararModalEditar(button) {
        const row = button.closest('tr');
        const codigoTarjeta = row.dataset.codigotarjeta;
        
        document.getElementById('tarjetaModalLabel').innerText = 'Editar Tarjeta Código: ' + codigoTarjeta;
        document.getElementById('formAccion').value = 'actualizar';
        
        // Poblar el formulario
        document.getElementById('formCodigoTarjeta').value = codigoTarjeta;
        document.getElementById('modalCodigoUsuario').value = row.dataset.codigousuario;
        document.getElementById('modalNombreTitular').value = row.dataset.nombretitular;
        document.getElementById('modalUltimos4').value = row.dataset.ultimos4;
        document.getElementById('modalFechaExpiracion').value = row.dataset.fechaexpiracion;
        document.getElementById('modalMarca').value = row.dataset.marca;
        document.getElementById('modalTipoTarjeta').value = row.dataset.tipotarjeta;
    }
</script>

</body>
</html>