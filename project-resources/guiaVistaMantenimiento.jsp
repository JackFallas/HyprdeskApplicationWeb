<%-- 
    Document   : guitaVistaMantenimiento
    Created on : 29 jul 2025, 09:11:14
    Author     : JackFallas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Guia de la vista de Mantenimiento (Demo) - Hyprdesk</title>
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
                    Guía de Mantenimiento
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
                                <th scope="col">ID</th>
                                <th scope="col">Espacio 1</th>
                                <th scope="col">Espacio 2</th>
                                <th scope="col">Espacio 3</th>
                                <th scope="col">Espacio 4</th>
                                <th scope="col">Espacio 5</th>
                                <th scope="col">Espacio 6</th>
                                <th scope="col">Espacio 7</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%--
                                Aquí es donde tu lista de objetos se iteraría.
                                Por ejemplo, si tienes una lista de objetos 'Elemento' en el request:
                                <c:forEach var="elemento" items="${listaElementos}">
                                    <tr data-id="${elemento.id}"
                                        data-espacio1="${elemento.espacio1}"
                                        data-espacio2="${elemento.espacio2}"
                                        data-espacio3="${elemento.espacio3}"
                                        data-espacio4="${elemento.espacio4}"
                                        data-espacio5="${elemento.espacio5}"
                                        data-espacio6="${elemento.espacio6}"
                                        data-espacio7="${elemento.espacio7}">
                                        <td>${elemento.id}</td>
                                        <td>${elemento.espacio1}</td>
                                        <td>${elemento.espacio2}</td>
                                        <td>${elemento.espacio3}</td>
                                        <td>${elemento.espacio4}</td>
                                        <td>${elemento.espacio5}</td>
                                        <td>${elemento.espacio6}</td>
                                        <td>${elemento.espacio7}</td>
                                        <td>
                                            <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#elementoModal" 
                                                    onclick="prepararModalEditar(this)">Editar</button>
                                            <a href="${pageContext.request.contextPath}/TuControlador?accion=eliminar&id=${elemento.id}" class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este elemento?');">Eliminar</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            --%>
                            
                            <%-- EJEMPLO DE FILA ESTATICA PARA VISUALIZACION --%>
                            <tr data-id="101" data-espacio1="Dato A1" data-espacio2="Dato B1" data-espacio3="Dato C1" data-espacio4="Dato D1" data-espacio5="Dato E1" data-espacio6="Dato F1" data-espacio7="Dato G1">
                                <td>101</td>
                                <td>Dato A1</td>
                                <td>Dato B1</td>
                                <td>Dato C1</td>
                                <td>Dato D1</td>
                                <td>Dato E1</td>
                                <td>Dato F1</td>
                                <td>Dato G1</td>
                                <td>
                                    <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#elementoModal" 
                                            onclick="prepararModalEditar(this)">Editar</button>
                                    <a href="#" class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este elemento?');">Eliminar</a>
                                </td>
                            </tr>
                            <tr data-id="102" data-espacio1="Item X" data-espacio2="Valor Y" data-espacio3="Config Z" data-espacio4="Parámetro 1" data-espacio5="Parámetro 2" data-espacio6="Estado OK" data-espacio7="Tipo Beta">
                                <td>102</td>
                                <td>Item X</td>
                                <td>Valor Y</td>
                                <td>Config Z</td>
                                <td>Parámetro 1</td>
                                <td>Parámetro 2</td>
                                <td>Estado OK</td>
                                <td>Tipo Beta</td>
                                <td>
                                    <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#elementoModal" 
                                            onclick="prepararModalEditar(this)">Editar</button>
                                    <a href="#" class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este elemento?');">Eliminar</a>
                                </td>
                            </tr>
                            <%-- FIN EJEMPLO DE FILA ESTATICA --%>
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
                        <form id="elementoForm" action="${pageContext.request.contextPath}/TuControlador" method="post">
                            <input type="hidden" name="accion" id="formAccion" value="insertar">
                            <input type="hidden" name="idElemento" id="formIdElemento">
                            <div class="mb-3">
                                <label for="modalEspacio1" class="form-label">Espacio 1:</label>
                                <input type="text" name="espacio1" id="modalEspacio1" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalEspacio2" class="form-label">Espacio 2:</label>
                                <input type="text" name="espacio2" id="modalEspacio2" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalEspacio3" class="form-label">Espacio 3:</label>
                                <input type="text" name="espacio3" id="modalEspacio3" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalEspacio4" class="form-label">Espacio 4:</label>
                                <input type="text" name="espacio4" id="modalEspacio4" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalEspacio5" class="form-label">Espacio 5:</label>
                                <input type="text" name="espacio5" id="modalEspacio5" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalEspacio6" class="form-label">Espacio 6:</label>
                                <input type="text" name="espacio6" id="modalEspacio6" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalEspacio7" class="form-label">Espacio 7:</label>
                                <input type="text" name="espacio7" id="modalEspacio7" class="form-control" required>
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
                document.getElementById('elementoModalLabel').innerText = 'Agregar Nuevo Elemento';
                document.getElementById('elementoForm').reset();
                document.getElementById('formAccion').value = 'insertar';
                document.getElementById('formIdElemento').value = '';
            }
            function prepararModalEditar(button) {
                const row = button.closest('tr');
                const id = row.dataset.id;
                const espacio1 = row.dataset.espacio1;
                const espacio2 = row.dataset.espacio2;
                const espacio3 = row.dataset.espacio3;
                const espacio4 = row.dataset.espacio4;
                const espacio5 = row.dataset.espacio5;
                const espacio6 = row.dataset.espacio6;
                const espacio7 = row.dataset.espacio7;
                
                document.getElementById('elementoModalLabel').innerText = 'Editar Elemento ID: ' + id;
                document.getElementById('formIdElemento').value = id;
                document.getElementById('modalEspacio1').value = espacio1;
                document.getElementById('modalEspacio2').value = espacio2;
                document.getElementById('modalEspacio3').value = espacio3;
                document.getElementById('modalEspacio4').value = espacio4;
                document.getElementById('modalEspacio5').value = espacio5;
                document.getElementById('modalEspacio6').value = espacio6;
                document.getElementById('modalEspacio7').value = espacio7;
                document.getElementById('formAccion').value = 'actualizar';
            }
        </script>
    </body>
</html>