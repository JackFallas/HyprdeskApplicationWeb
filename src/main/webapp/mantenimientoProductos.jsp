<%--
    Document    : mantenimientoProductos
    Created on : 30 jul 2025, 22:32:53
    Author     : J Craxker
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
            .btn-add-to-cart {
                background-color: #28a745;
                border-color: #28a745;
                color: white;
            }
            .btn-add-to-cart:hover {
                background-color: #218838;
                border-color: #1e7e34;
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
                    Mantenimiento de Productos
                </span>
            </div>
        </nav>
        <div class="container">
            <div class="container-main">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1>Listado de Productos</h1>
                    <c:if test="${rol == 'Admin'}">
                        <button type="button" class="btn btn-add" data-bs-toggle="modal" data-bs-target="#elementoModal" 
                                onclick="prepararModalAgregar()">
                            <i class="bi bi-plus-circle"></i> Agregar Producto
                        </button>
                    </c:if>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered table-custom" id="tablaElementos">
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
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Itera sobre la lista de productos obtenida del Servlet --%>
                            <c:forEach var="producto" items="${listaProductos}">
                                <tr data-id="${producto.codigoProducto}"
                                    data-nombre="${producto.nombre}"
                                    data-descripcion="${producto.descripcion}"
                                    data-precio="${producto.precio}"
                                    data-stock="${producto.stock}"
                                    data-fechaentrada="${producto.fechaEntrada}"
                                    data-fechasalida="${producto.fechaSalida}"
                                    data-codigomarca="${producto.marca.codigoMarca}"
                                    data-codigocategoria="${producto.categoria.codigoCategoria}">
                                    <td>${producto.codigoProducto}</td>
                                    <td>${producto.nombre}</td>
                                    <td>${producto.descripcion}</td>
                                    <td>${producto.precio}</td>
                                    <td>${producto.stock}</td>
                                    <td>${producto.fechaEntrada}</td>
                                    <td>${producto.fechaSalida}</td>
                                    <td>${producto.marca.codigoMarca}</td>
                                    <td>${producto.categoria.codigoCategoria}</td>
                                    <td>
                                        <c:if test="${rol == 'Admin'}">
                                            <button type="button" class="btn btn-edit btn-sm me-2" data-bs-toggle="modal" data-bs-target="#elementoModal" 
                                                    onclick="prepararModalEditar(this)">Editar</button>
                                            <a href="${pageContext.request.contextPath}/ServletProducto?accion=eliminar&id=${producto.codigoProducto}" class="btn btn-delete btn-sm" onclick="return confirm('¿Está seguro de eliminar este producto?');">Eliminar</a>
                                        </c:if>
                                        <c:if test="${rol == 'Usuario'}">
                                            <c:if test="${rol == 'Usuario'}">
                                                <button type="button" class="btn btn-add-to-cart btn-sm"
                                                        onclick="abrirModalAgregarCarrito(${producto.codigoProducto}, ${producto.precio})">
                                                    Añadir al carrito
                                                </button>
                                            </c:if>

                                            <script>
                                                function preguntarCantidad(codigoProducto, precioUnitario) {
                                                    let cantidad = prompt("¿Cuántas unidades quieres comprar?", "1");
                                                    cantidad = parseInt(cantidad);
                                                    if (cantidad && cantidad > 0) {
                                                        document.getElementById("cantidad" + codigoProducto).value = cantidad;
                                                        document.getElementById("subtotal" + codigoProducto).value = (precioUnitario * cantidad).toFixed(2);
                                                        document.getElementById("formAgregarCarrito" + codigoProducto).submit();
                                                    } else {
                                                        alert("Cantidad inválida");
                                                    }
                                                }
                                            </script>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
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
                        <form id="elementoForm" action="${pageContext.request.contextPath}/ServletProducto" method="post">
                            <input type="hidden" name="accion" id="formAccion" value="agregar">
                            <input type="hidden" name="codigoProducto" id="formIdElemento">
                            <div class="mb-3">
                                <label for="modalNombreProducto" class="form-label">Nombre:</label>
                                <input type="text" name="nombreProducto" id="modalNombreProducto" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalDescripcion" class="form-label">Descripción:</label>
                                <input type="text" name="descripcionProducto" id="modalDescripcion" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalPrecio" class="form-label">Precio:</label>
                                <input type="number" step="0.01" name="precioProducto" id="modalPrecio" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalStock" class="form-label">Stock:</label>
                                <input type="number" name="stock" id="modalStock" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalFechaEntrada" class="form-label">Fecha Entrada:</label>
                                <input type="date" name="fechaEntrada" id="modalFechaEntrada" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalFechaSalida" class="form-label">Fecha Salida:</label>
                                <input type="date" name="fechaSalida" id="modalFechaSalida" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalCodigoMarca" class="form-label">Código Marca:</label>
                                <input type="number" name="codigoMarca" id="modalCodigoMarca" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="modalCodigoCategoria" class="form-label">Código Categoría:</label>
                                <input type="number" name="codigoCategoria" id="modalCodigoCategoria" class="form-control" required>
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

        <div class="modal fade" id="modalAgregarCarrito" tabindex="-1" aria-labelledby="modalAgregarCarritoLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="formAgregarCarrito" action="${pageContext.request.contextPath}/ServletDetallePedido" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalAgregarCarritoLabel">Agregar al carrito</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="accion" value="guardar">
                            <input type="hidden" name="codigoProducto" id="modalCodigoProducto">
                            <input type="hidden" name="precio" id="modalPrecioProducto">
                            <input type="hidden" name="subtotal" id="modalSubtotalProducto">
                            <input type="hidden" name="codigoPedido" value="1"> <!-- Cambia esto según tu pedido actual -->

                            <div class="mb-3">
                                <label for="modalCantidad" class="form-label">Cantidad:</label>
                                <input type="number" class="form-control" id="modalCantidad" name="cantidad" min="1" value="1" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Agregar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="resources/js/bootstrap.bundle.min.js"></script>
        <script>
    function prepararModalAgregar() {
        document.getElementById('elementoModalLabel').innerText = 'Agregar Nuevo Producto';
        document.getElementById('elementoForm').reset();
        document.getElementById('formAccion').value = 'agregar';
        document.getElementById('formIdElemento').value = '';
    }
    function prepararModalEditar(button) {
        const row = button.closest('tr');
        const id = row.dataset.id;
        const nombre = row.dataset.nombre;
        const descripcion = row.dataset.descripcion;
        const precio = row.dataset.precio;
        const stock = row.dataset.stock;
        const fechaEntrada = row.dataset.fechaentrada;
        const fechaSalida = row.dataset.fechasalida;
        const codigoMarca = row.dataset.codigomarca;
        const codigoCategoria = row.dataset.codigocategoria;

        document.getElementById('elementoModalLabel').innerText = 'Editar Producto ID: ' + id;
        document.getElementById('formIdElemento').value = id;
        document.getElementById('modalNombreProducto').value = nombre;
        document.getElementById('modalDescripcion').value = descripcion;
        document.getElementById('modalPrecio').value = precio;
        document.getElementById('modalStock').value = stock;
        document.getElementById('modalFechaEntrada').value = fechaEntrada;
        document.getElementById('modalFechaSalida').value = fechaSalida;
        document.getElementById('modalCodigoMarca').value = codigoMarca;
        document.getElementById('modalCodigoCategoria').value = codigoCategoria;
        document.getElementById('formAccion').value = 'actualizar';
    }
        </script>
        <script>
            function abrirModalAgregarCarrito(codigoProducto, precioUnitario) {
                document.getElementById('modalCodigoProducto').value = codigoProducto;
                document.getElementById('modalPrecioProducto').value = precioUnitario.toFixed(2);
                document.getElementById('modalCantidad').value = 1;
                document.getElementById('modalSubtotalProducto').value = precioUnitario.toFixed(2);

                // Abrir modal con Bootstrap 5
                var modal = new bootstrap.Modal(document.getElementById('modalAgregarCarrito'));
                modal.show();

                document.getElementById('modalCantidad').oninput = function () {
                    let cantidad = parseInt(this.value);
                    if (cantidad < 1) {
                        cantidad = 1;
                        this.value = cantidad;
                    }
                    document.getElementById('modalSubtotalProducto').value = (precioUnitario * cantidad).toFixed(2);
                };
            }
        </script>
    </body>
</html>
