<%-- 
    Document   : Categoria
    Created on : 30/07/2025, 17:44:40
    Author     : andya
--%>

<%@ page import="java.util.List" %>
<%@ page import="model.Categorias" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mantenimiento - Categorías</title>
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
                    <img src="${pageContext.request.contextPath}/resources/img/Logo con nombre.png" alt="Hyprdesk Logo">
                </a>
                <span class="navbar-text text-white ms-3 h4">
                    Categorías
                </span>
            </div>
        </nav>
        <div class="container">
            <div class="container-main">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Listado de Elementos</h1>
                    <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#elementoModal"
                            onclick="prepararModalAgregar()">
                        <i class="bi bi-plus-circle"></i> Agregar Elemento
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered table-custom" id="tablaElementos">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                List<Categorias> listaCategorias = (List<Categorias>) request.getAttribute("listaCategorias");
                                if (listaCategorias != null && !listaCategorias.isEmpty()) {
                                    for (Categorias c : listaCategorias) {
                            %>
                            <tr data-id="<%= c.getCodigoCategoria()%>" 
                                data-nombre="<%= c.getNombreCategoria()%>" 
                                data-descripcion="<%= c.getDescripcionCategoria()%>">
                                <td><%= c.getCodigoCategoria()%></td>
                                <td><%= c.getNombreCategoria()%></td>
                                <td><%= c.getDescripcionCategoria()%></td>
                                <td>
                                    <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#elementoModal"
                                            onclick="prepararModalEditar(this)">Editar</button>
                                    <a href="${pageContext.request.contextPath}/ServletCategorias?accion=eliminar&id=<%= c.getCodigoCategoria()%>" 
                                       class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar esta categoría?');">Eliminar</a>
                                </td>
                            </tr>
                            <%
                                }   
                            } else {
                            %>
                            <tr>
                                <td colspan="4" class="text-center">No hay categorías registradas.</td>
                            </tr>
                            <%
                                }
                            %>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal fade" id="elementoModal" tabindex="-1" aria-labelledby="elementoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="elementoModalLabel"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="elementoForm" action="${pageContext.request.contextPath}/ServletCategorias" method="post">
                            <input type="hidden" name="accion" id="formAccion" value="agregar">
                            <input type="hidden" name="id" id="formIdElemento">

                            <div class="mb-3">
                                <label for="modalNombre" class="form-label">Nombre de Categoría:</label>
                                <input type="text" name="nombreCategoria" id="modalNombre" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalDescripcion" class="form-label">Descripción:</label>
                                <input type="text" name="descripcionCategoria" id="modalDescripcion" class="form-control" required>
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
                                               document.getElementById('elementoModalLabel').innerText = 'Agregar Nuevo Elemento';
                                               document.getElementById('elementoForm').reset();
                                               document.getElementById('formAccion').value = 'agregar';
                                               document.getElementById('formIdElemento').value = '';
                                           }
                                           function prepararModalEditar(button) {
                                               const row = button.closest('tr');
                                               const id = row.dataset.id;
                                               const nombre = row.dataset.nombre;
                                               const descripcion = row.dataset.descripcion;

                                               document.getElementById('elementoModalLabel').innerText = 'Editar Categoría ID: ' + id;
                                               document.getElementById('formIdElemento').value = id;
                                               document.getElementById('modalNombre').value = nombre;
                                               document.getElementById('modalDescripcion').value = descripcion;
                                               document.getElementById('formAccion').value = 'actualizar';
                                           }

        </script>
    </body>
</html>