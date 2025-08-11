<%-- 
    Document   : factura
    Created on : 10/08/2025, 14:52:20
    Author     : andya
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Factura Hyperdesk</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
                background-color: #f8f9fa;
                color: #333;
            }
            .factura-container {
                max-width: 800px;
                margin: auto;
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            .factura-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 3px solid #007BFF;
                padding-bottom: 15px;
                margin-bottom: 20px;
            }
            .factura-header img {
                height: 70px;
            }
            .empresa-info h1 {
                margin: 0;
                color: #007BFF;
            }
            .empresa-info p {
                margin: 3px 0;
                font-size: 14px;
                color: #555;
            }
            .datos-cliente {
                margin-bottom: 20px;
            }
            .datos-cliente p {
                margin: 5px 0;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            th {
                background-color: #007BFF;
                color: white;
                padding: 10px;
            }
            td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .total {
                text-align: right;
                font-size: 18px;
                font-weight: bold;
                margin-top: 15px;
            }
            .btn-pdf {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 15px;
                background-color: #28A745;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
            }
            .btn-pdf:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="factura-container">
            <div class="factura-header">
                <div class="empresa-info">
                    <h1>Hyperdesk</h1>
                    <p>Innovación,calidad, integridad y compromiso</p>
                    <p>www.hyperdesk.com</p>
                </div>
                    <img src="resources/image/Logo.png" alt="Logo de Hyprdesk" class="img-fluid"/>

            </div>

            <h2>Factura #${factura.codigoPedido}</h2>
            <div class="datos-cliente">
                <p><strong>Fecha:</strong> ${factura.fechaPedido}</p>
                <p><strong>Cliente:</strong> ${factura.nombreUsuario} ${factura.apellidoUsuario}</p>
                <p><strong>Email:</strong> ${factura.email}</p>
                <p><strong>Dirección:</strong> ${factura.direccionPedido}</p>
                <p><strong>Método de pago:</strong> ${factura.metodoPago}</p>
            </div>

            <table>
                <tr><th>Producto</th><th>Cantidad</th><th>Precio</th><th>Subtotal</th></tr>
                        <c:forEach var="det" items="${factura.detalles}">
                    <tr>
                        <td>${det.nombreProducto}</td>
                        <td>${det.cantidad}</td>
                        <td>Q${det.precio}</td>
                        <td>Q${det.subtotal}</td>
                    </tr>
                </c:forEach>
            </table>

            <p class="total">Total: Q${factura.totalPedido}</p>

            <a href="factura?formato=pdf&codigoPedido=${factura.codigoPedido}" class="btn-pdf">Descargar PDF</a>
        </div>
    </body>
</html>
