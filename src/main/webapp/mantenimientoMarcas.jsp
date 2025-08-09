<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Marca"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Marcas - Hyprdesk</title>
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
        <span class="navbar-text text-white ms-3 h4">Gestión de Marcas</span>
    </div>
</nav>

<div class="container">
    <div class="container-main">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Listado de Marcas</h1>
            <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#marcaModal" onclick="prepararModalAgregar()">
                <i class="bi bi-plus-circle"></i> Agregar Marca
            </button>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>
        <c:if test="${param.success eq 'true'}">
            <div class="alert alert-success" role="alert">
                ¡Marca guardada exitosamente!
            </div>
        </c:if>
        <c:if test="${param.deleted eq 'true'}">
            <div class="alert alert-success" role="alert">
                ¡Marca eliminada exitosamente!
            </div>
        </c:if>

        <div class="table-responsive">
            <table class="table table-striped table-hover table-bordered table-custom" id="tablaMarcas">
                <thead>
                    <tr>
                        <th scope="col">Código Marca</th>
                        <th scope="col">Nombre Marca</th>
                        <th scope="col">Descripción</th>
                        <th scope="col">Estado</th>
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listaMarcas}">
                            <c:forEach var="marca" items="${listaMarcas}">
                                <tr data-codigo="${marca.codigoMarca}"
                                    data-nombre="${marca.nombreMarca}"
                                    data-descripcion="${marca.descripcion}"
                                    data-estado="${marca.estadoMarca}">
                                    <td>${marca.codigoMarca}</td>
                                    <td>${marca.nombreMarca}</td>
                                    <td>${marca.descripcion}</td>
                                    <td>
                                        <span class="${marca.estadoMarca eq 'Disponible' ? 'status-disponible' : 'status-no-disponible'}">
                                            ${marca.estadoMarca}
                                        </span>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#marcaModal"
                                                onclick="prepararModalEditar(this)">Editar</button>
                                        <a href="${pageContext.request.contextPath}/ServletMarcas?accion=eliminar&id=${marca.codigoMarca}"
                                           class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar esta marca?');">Eliminar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="5" class="text-center">No hay marcas registradas.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="marcaModal" tabindex="-1" aria-labelledby="marcaModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="marcaModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="marcaForm" action="${pageContext.request.contextPath}/ServletMarcas" method="post">
                    <input type="hidden" name="accion" id="formAccion" value="insertar">
                    <input type="hidden" name="codigoMarca" id="formCodigoMarca">
                    <div class="mb-3">
                        <label for="modalNombreMarca" class="form-label">Nombre de la Marca:</label>
                        <input type="text" name="nombreMarca" id="modalNombreMarca" class="form-control" maxlength="64" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalDescripcion" class="form-label">Descripción:</label>
                        <input type="text" name="descripcion" id="modalDescripcion" class="form-control" maxlength="128" required>
                    </div>
                    <div class="mb-3">
                        <label for="modalEstadoMarca" class="form-label">Estado:</label>
                        <select id="modalEstadoMarca" name="estadoMarca" class="form-select" required>
                            <option value="Disponible">Disponible</option>
                            <option value="No disponible">No disponible</option>
                        </select>
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
        document.getElementById('marcaModalLabel').innerText = 'Agregar Nueva Marca';
        document.getElementById('marcaForm').reset();
        document.getElementById('formAccion').value = 'insertar';
        document.getElementById('formCodigoMarca').value = '';
        document.getElementById('modalEstadoMarca').value = 'Disponible';
    }

    function prepararModalEditar(button) {
        const row = button.closest('tr');
        const codigo = row.dataset.codigo;
        const nombre = row.dataset.nombre;
        const descripcion = row.dataset.descripcion;
        const estado = row.dataset.estado;

        document.getElementById('marcaModalLabel').innerText = 'Editar Marca Código: ' + codigo;
        document.getElementById('formCodigoMarca').value = codigo;
        document.getElementById('modalNombreMarca').value = nombre;
        document.getElementById('modalDescripcion').value = descripcion;
        document.getElementById('modalEstadoMarca').value = estado;
        document.getElementById('formAccion').value = 'actualizar';
    }
</script>
</body>
</html>
