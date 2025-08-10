<%--
    Document     : mantenimientoProductos
    Created on   : 30 jul 2025, 22:32:53
    Author       : J Craxker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Producto" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mantenimiento de Productos - Hyprdesk</title>
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
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark mb-4">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <img src="resources/img/Logo con nombre.png" alt="Hyprdesk Logo"> 
                </a>
                <span class="navbar-text text-white ms-3 h4">
                    Mantenimiento de Productos
                </span>
            </div>
        </nav>
        <div class="container">
            <div class="container-main">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Listado de Productos</h1>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered table-custom">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Descripción</th>
                                <th scope="col">Precio</th>
                                <th scope="col">Stock</th>
                                <th scope="col">Fecha Entrada</th>
                                <th scope="col">Fecha Salida</th>
                                <th scope="col">Código Marca</th>
                                <th scope="col">Código Categoría</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Itera sobre la lista de productos obtenida del Servlet --%>
                            <c:forEach var="producto" items="${listaProductos}">
                                <tr>
                                    <td>${producto.codigoProducto}</td>
                                    <td>${producto.nombre}</td>
                                    <td>${producto.descripcion}</td>
                                    <td>${producto.precio}</td>
                                    <td>${producto.stock}</td>
                                    <td>${producto.fechaEntrada}</td>
                                    <td>${producto.fechaSalida}</td>
                                    <td>${producto.marca.codigoMarca}</td>
                                    <td>${producto.categoria.codigoCategoria}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="resources/js/bootstrap.bundle.min.js"></script>
    </body>
</html>