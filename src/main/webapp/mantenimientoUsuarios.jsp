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
                <span class="navbar-text text-white ms-3 h4">
                    Usuarios
                </span>
            </div>
        </nav>
        <div class="container">
            <div class="container-main">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Listado de Usuarios</h1>
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
                                        <a href="ServletUsuario?accion=editar&codigoUsuario=${usuario.codigoUsuario}" class="btn btn-edit btn-sm me-2">Editar</a>
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

        <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
    </body>
</html>