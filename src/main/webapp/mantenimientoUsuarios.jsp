
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
                                <tr data-codigo="${usuario.codigoUsuario}" 
                                    data-nombre="${usuario.nombreUsuario}" 
                                    data-apellido="${usuario.apellidoUsuario}"
                                    data-telefono="${usuario.telefono}"
                                    data-direccion="${usuario.direccionUsuario}"
                                    data-email="${usuario.email}"
                                    data-contrasena="${usuario.contrasena}"
                                    data-estado="${usuario.estadoUsuario}"
                                    data-rol="${usuario.rol}"
                                    data-nacimiento="${usuario.fechaNacimiento}">
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
                                        <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#usuarioModal"
                                                onclick="prepararModalEditar(this)">Editar</button>
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


        <div class="modal fade" id="usuarioModal" tabindex="-1" aria-labelledby="usuarioModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="usuarioModalLabel">Editar Usuario</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="usuarioForm" action="${pageContext.request.contextPath}/ServletUsuario" method="post">
                            <input type="hidden" name="accion" id="formAccion" value="actualizar">
                            <input type="hidden" name="codigoUsuario" id="formCodigoUsuario">

                            <div class="mb-3">
                                <label for="modalNombre" class="form-label">Nombre:</label>
                                <input type="text" name="nombreUsuario" id="modalNombre" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalApellido" class="form-label">Apellido:</label>
                                <input type="text" name="apellidoUsuario" id="modalApellido" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalTelefono" class="form-label">Teléfono:</label>
                                <input type="text" name="telefono" id="modalTelefono" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalDireccion" class="form-label">Dirección:</label>
                                <input type="text" name="direccionUsuario" id="modalDireccion" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalEmail" class="form-label">Email:</label>
                                <input type="email" name="email" id="modalEmail" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalContrasena" class="form-label">Contraseña:</label>
                                <input type="password" name="contrasena" id="modalContrasena" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalEstadoUsuario" class="form-label">Estado:</label>
                                <select name="estadoUsuario" id="modalEstadoUsuario" class="form-select" required>
                                    <option value="Activo">Activo</option>
                                    <option value="Inactivo">Inactivo</option>
                                    <option value="Suspendido">Suspendido</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="modalRol" class="form-label">Rol:</label>
                                <select name="rol" id="modalRol" class="form-select" required>
                                    <option value="Admin">Admin</option>
                                    <option value="Empleado">Empleado</option>
                                    <option value="Usuario">Usuario</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="modalFechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                                <input type="date" name="fechaNacimiento" id="modalFechaNacimiento" class="form-control">
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
        <script>
                                                    function prepararModalAgregar() {
                                                        document.getElementById('usuarioModalLabel').innerText = 'Agregar Nuevo Usuario';
                                                        document.getElementById('usuarioForm').reset();
                                                        document.getElementById('formAccion').value = 'agregar';
                                                        document.getElementById('formCodigoUsuario').value = '';
                                                        document.getElementById('modalEstadoUsuario').value = 'Activo';
                                                        document.getElementById('modalRol').value = 'Usuario';
                                                    }

                                                    function prepararModalEditar(button) {
                                                        const row = button.closest('tr');

                                                        const id = row.dataset.codigo;
                                                        const nombre = row.dataset.nombre;
                                                        const apellido = row.dataset.apellido;
                                                        const telefono = row.dataset.telefono;
                                                        const direccion = row.dataset.direccion;
                                                        const email = row.dataset.email;
                                                        const contrasena = row.dataset.contrasena;
                                                        const estado = row.dataset.estado;
                                                        const rol = row.dataset.rol;
                                                        let nacimiento = row.dataset.nacimiento;

                                                        console.log("Datos obtenidos de la fila para edición:");
                                                        console.log("ID:", id);
                                                        console.log("Nombre:", nombre);
                                                        console.log("Apellido:", apellido);
                                                        console.log("Teléfono:", telefono);
                                                        console.log("Dirección:", direccion);
                                                        console.log("Email:", email);
                                                        console.log("Contraseña:", contrasena);
                                                        console.log("Estado:", estado);
                                                        console.log("Rol:", rol);
                                                        console.log("Fecha Nacimiento (original):", nacimiento);

                                                        document.getElementById('usuarioModalLabel').innerText = 'Editar Usuario ID: ' + id;
                                                        document.getElementById('formCodigoUsuario').value = id;
                                                        document.getElementById('formAccion').value = 'actualizar';

                                                        document.getElementById('modalNombre').value = nombre;
                                                        document.getElementById('modalApellido').value = apellido;
                                                        document.getElementById('modalTelefono').value = telefono;
                                                        document.getElementById('modalDireccion').value = direccion;
                                                        document.getElementById('modalEmail').value = email;
                                                        document.getElementById('modalContrasena').value = contrasena;

                                                        document.getElementById('modalEstadoUsuario').value = estado;
                                                        document.getElementById('modalRol').value = rol;

                                                        if (nacimiento && nacimiento.includes(' ')) {
                                                            nacimiento = nacimiento.split(' ')[0];
                                                        }
                                                        document.getElementById('modalFechaNacimiento').value = nacimiento;

                                                        console.log("Valores asignados al formulario del modal:");
                                                        console.log("ID Form:", document.getElementById('formCodigoUsuario').value);
                                                        console.log("Nombre Form:", document.getElementById('modalNombre').value);
                                                        console.log("Fecha Nacimiento Form:", document.getElementById('modalFechaNacimiento').value);
                                                    }

                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        var myModalEl = document.getElementById('usuarioModal');
                                                        if (myModalEl) {
                                                            myModalEl.addEventListener('show.bs.modal', function (event) {
                                                                console.log('Modal de Bootstrap se está abriendo.');
                                                            });
                                                            myModalEl.addEventListener('shown.bs.modal', function (event) {
                                                                console.log('Modal de Bootstrap ya está abierto.');
                                                            });
                                                            myModalEl.addEventListener('hide.bs.modal', function (event) {
                                                                console.log('Modal de Bootstrap se está cerrando.');
                                                            });
                                                        } else {
                                                            console.error('El elemento del modal con ID "usuarioModal" no fue encontrado.');
                                                        }

                                                        if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
                                                            console.log('Bootstrap JS (Modal) cargado correctamente.');
                                                        } else {
                                                            console.error('Bootstrap JS (Modal) NO cargado. Verifica la ruta del script.');
                                                        }
                                                    });
        </script>
    </body>
</html>
