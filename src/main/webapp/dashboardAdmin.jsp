<%-- 
    Document   : dashboardAdmin
    Created on : 30 jul 2025, 12:07:23
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Admin</title>

    <!-- Agregar Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="resources/css/dashboardU.css"/>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <style>
        .stat-card {
            border-radius: 10px;
            background-color: #f9f9f9;
            padding: 20px;
            margin: 10px 0;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .stat-card .stat-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
        }

        .stat-card .stat-value {
            font-size: 2.5rem;
            font-weight: 600;
            color: #0056b3;
        }

        .stat-card i {
            font-size: 2rem;
            color: #007bff;
        }

        .dashboard {
            padding: 30px;
        }

        .stat-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .stat-container .col-md-4 {
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <div class="d-flex">
        <input type="checkbox" id="nav-toggle" hidden>
        <label for="nav-toggle" class="toggle-btn">
            <i class='bx bx-menu'></i>
        </label>

        <!-- Sidebar -->
        <aside class="sidebar d-flex flex-column">
            <div class="brand d-flex align-items-center justify-content-start">
                <i class='bx bxl-css3'></i>
                <span class="brand__name"></span>
            </div>

            <nav class="menu">
                <a href="#" class="menu__item active">
                    <i class='bx bx-home-alt'></i><span>Dashboard</span>
                </a>
                <a href="#usuarios" class="menu__item">
                    <i class='bx bx-user'></i><span>Usuarios</span>
                </a>
                <a href="#marcas" class="menu__item">
                    <i class='bx bx-cogs'></i><span>Marcas</span>
                </a>
                <a href="#categorias" class="menu__item">
                    <i class='bx bx-category'></i><span>Categorías</span>
                </a>
                <a href="#productos" class="menu__item">
                    <i class='bx bx-package'></i><span>Productos</span>
                </a>
                <a href="#tarjetas" class="menu__item">
                    <i class='bx bx-credit-card'></i><span>Tarjetas</span>
                </a>
                <a href="#recibos" class="menu__item">
                    <i class='bx bx-receipt'></i><span>Recibos</span>
                </a>
                <a href="#pedidos" class="menu__item">
                    <i class='bx bx-cart'></i><span>Pedidos</span>
                </a>
                <a href="#detalle-pedidos" class="menu__item">
                    <i class='bx bx-list-ul'></i><span>Detalle de Pedidos</span>
                </a>
                <a href="#" class="menu__item">
                    <i class='bx bx-power-off'></i><span>Cerrar sesión</span>
                </a>
            </nav>

            <div class="profile d-flex align-items-center">
                <img src="Logo.png" alt="avatar" class="rounded-circle">
                <div class="profile__info ms-3">
                    <p class="name">Admin</p>
                    <p class="plan">Kinal - Derechos Reservados</p>
                </div>
            </div>
        </aside>

        <!-- Contenedor principal (header + dashboard) -->
        <main class="flex-grow-1">
            <header class="header">
                <a href="#" class="logo">Admin Dashboard</a>
            </header>

            <!-- Dashboard Section (contenedor) -->
            <section class="dashboard">
                <h2 class="text-center mb-4">Estadísticas de Administración</h2>

                <!-- Bloques Estadísticos -->
                <div class="container">
                    <div class="row stat-container">
                        <!-- Bloque: Usuarios recientes -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-user'></i>
                                <div class="stat-title">Usuarios Activos</div>
                                <div class="stat-value">120</div>
                            </div>
                        </div>

                        <!-- Bloque: Pedidos recientes -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-cart'></i>
                                <div class="stat-title">Pedidos Recientes</div>
                                <div class="stat-value">85</div>
                            </div>
                        </div>

                        <!-- Bloque: Productos modificados -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-package'></i>
                                <div class="stat-title">Productos Modificados</div>
                                <div class="stat-value">47</div>
                            </div>
                        </div>

                        <!-- Bloque: Tarjetas activas -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-credit-card'></i>
                                <div class="stat-title">Tarjetas Activas</div>
                                <div class="stat-value">310</div>
                            </div>
                        </div>

                        <!-- Bloque: Recibos Generados -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-receipt'></i>
                                <div class="stat-title">Recibos Generados</div>
                                <div class="stat-value">$12,500</div>
                            </div>
                        </div>

                        <!-- Bloque: Pagos procesados -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-credit-card'></i>
                                <div class="stat-title">Pagos Procesados</div>
                                <div class="stat-value">$8,750</div>
                            </div>
                        </div>
                    </div>

                    <!-- Bloques de Últimas Acciones Generales -->
                    <div class="row stat-container">
                        <!-- Última Acción General -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-history'></i>
                                <div class="stat-title">Última Acción</div>
                                <div class="stat-value">Usuario #120 actualizado</div>
                            </div>
                        </div>

                        <!-- Último Producto Agregado -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-package'></i>
                                <div class="stat-title">Último Producto</div>
                                <div class="stat-value">PC Gamer Blue</div>
                            </div>
                        </div>

                        <!-- Último Usuario Registrado -->
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class='bx bx-user'></i>
                                <div class="stat-title">Último Usuario</div>
                                <div class="stat-value">Ana López</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <!-- Agregar Bootstrap JS (para posibles interacciones dinámicas) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>