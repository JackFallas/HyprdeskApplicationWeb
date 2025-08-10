<%-- 
    Document   : dashboardUsuario
    Created on : 30 jul 2025, 12:03:48
    Author     : informatica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pagina Principal - Hyprland</title>

    <!-- Agregar Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="resources/css/dashboardU.css"/>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

<body>
    <!-- Contenedor de la barra lateral (sidebar) usando Bootstrap -->
    <div class="d-flex">
        <input type="checkbox" id="nav-toggle" hidden>

        <label for="nav-toggle" class="toggle-btn">
            <i class='bx bx-menu'></i>
        </label>

        <aside class="sidebar d-flex flex-column">
            <div class="brand d-flex align-items-center justify-content-start">
                <i class='bx bxl-css3'></i>
                <span class="brand__name"></span>
            </div>

            <nav class="menu">
                <a href="#" class="menu__item active">
                    <i class='bx bx-home-alt'></i><span>Inicio</span>
                </a>
                <a href="productos.jsp" class="menu__item">
                    <i class='bx bx-shopping-bag'></i><span>Productos</span>
                </a>
                <a href="#" class="menu__item">
                    <i class='bx bx-cart'></i><span>Carrito</span>
                </a>
                <a href="#" class="menu__item">
                    <i class='bx bx-shopping-bag'></i><span>Pedidos</span>
                </a>
                <a href="login.jsp" class="menu__item">
                    <i class='bx bx-power-off'></i><span>Cerrar sesión</span>
                </a>
            </nav>

            <div class="profile d-flex align-items-center">
                <img src="Logo.png" alt="avatar" class="rounded-circle">
                <div class="profile__info ms-3">
                    <p class="name">Hyperdesk.</p>
                    <p class="plan">Kinal - Derechos Reservados</p>
                </div>
            </div>
        </aside>

        <!-- Contenedor principal (header + home) -->
        <main class="flex-grow-1">
            <header class="header">
        <a href="#" class="logo">Hyperdesk.</a>

        <nav class="navbar">
            <a href="#" style="--i:1;" class="active">Inicio</a>
            <a href="#" style="--i:2;">Acerca De</a>
            <a href="#" style="--i:3;">Contacto</a>
        </nav>

        <div class="social-media">
            <a href="#" style="--i:1;"><i class='bx bxl-twitter'></i></a>
            <a href="#" style="--i:2;"><i class='bx bxl-facebook'></i></a>
            <a href="#" style="--i:3;"><i class='bx bxl-instagram-alt'></i></a>
            <a href="#" style="--i:3;"><i class='bx bx-user'></i></a>
        </div>  
    </header>

            <!-- Home Section (contenedor) -->
            <section class="home d-flex justify-content-between align-items-center py-5">
                <div class="home-content">
                    <h1>Experiencia en Computación.</h1>
                    <h3>Redefined!</h3>
                    <p>Somos un equipo profesional de computación encargado de entregarte las mejores computadoras y componentes del mercado y llevártelos hasta la puerta de tu casa.</p>
                    <a href="#" class="btn btn-primary">Explora Computadoras</a>
                </div>

                <div class="home-img">
                    <div class="rhombus">
                        <img src="pcgamerblue.png" alt="PC Gamer" class="img-fluid"/>
                    </div>
                </div>

                <div class="rhombus2"></div>
            </section>
        </main>
    </div>

    <!-- Agregar Bootstrap JS (para posibles interacciones dinámicas) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>