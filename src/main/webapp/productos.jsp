<%-- 
    Document   : productos
    Created on : 30 jul 2025
    Author     :
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos - Hyprland</title>

   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="resources/css/dashboardU.css"/>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

<body>
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
                <a href="dashboardUsuario.jsp" class="menu__item">
                    <i class='bx bx-home-alt'></i><span>Inicio</span>
                </a>
                <a href="ServletProducto" class="menu__item active">
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

        <header class="header">
            <a href="#" class="logo">Hyperdesk.</a>
            <div class="social-media">
                <a href="#" style="--i:1;"><i class='bx bxl-twitter'></i></a>
                <a href="#" style="--i:2;"><i class='bx bxl-facebook'></i></a>
                <a href="#" style="--i:3;"><i class='bx bxl-instagram-alt'></i></a>
                <a href="#" style="--i:3;"><i class='bx bx-user'></i></a>
            </div>
        </header>

        <main class="flex-grow-1 main-content p-5">
            <section class="products-section pt-5 mt-5">
                <div class="container">
                    <h2 class="text-center mb-5" style="color: #222; font-weight: 600;">Nuestros Productos</h2>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/compu1.jpg" class="card-img-top p-3 rounded-4" alt="PC Gaming RTX 4090">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">PC Gaming Max</h5>
                                    <p class="card-text text-muted">CPU: Intel Core i9-14900K, GPU: NVIDIA RTX 4090, RAM: 64GB DDR5, SSD: 2TB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$3,999.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/compu2.jpg" class="card-img-top p-3 rounded-4" alt="PC Gaming RTX 4070">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">PC Gaming Pro</h5>
                                    <p class="card-text text-muted">CPU: AMD Ryzen 7 7800X3D, GPU: NVIDIA RTX 4070 Ti, RAM: 32GB DDR5, SSD: 1TB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$2,299.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/compu3.jpg" class="card-img-top p-3 rounded-4" alt="Laptop Gaming 4080">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">Laptop Gaming Top</h5>
                                    <p class="card-text text-muted">CPU: Intel Core i9-14900HX, GPU: NVIDIA RTX 4080 Laptop, RAM: 32GB DDR5, SSD: 1TB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$2,899.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/compu4.jpg" class="card-img-top p-3 rounded-4" alt="PC Oficina Intel i7">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">PC Workstation</h5>
                                    <p class="card-text text-muted">CPU: Intel Core i7-13700, Gráficos: Integrados UHD 770, RAM: 32GB DDR4, SSD: 1TB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$1,199.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>
                    
                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/compu5.jpg" class="card-img-top p-3 rounded-4" alt="Laptop Creator RTX 3050">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">Laptop Creator</h5>
                                    <p class="card-text text-muted">CPU: AMD Ryzen 9 7940HS, GPU: NVIDIA RTX 3050 Laptop, RAM: 16GB DDR5, SSD: 1TB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$1,799.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <!-- Producto 6: PC para Gaming de Entrada -->
                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/compu6.webp" class="card-img-top p-3 rounded-4" alt="PC Gaming RX 6600">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">PC Gaming Esencial</h5>
                                    <p class="card-text text-muted">CPU: Intel Core i5-12400F, GPU: AMD Radeon RX 6600, RAM: 16GB DDR4, SSD: 500GB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$949.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/compu7.webp" class="card-img-top p-3 rounded-4" alt="Laptop Ultra i7">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">Laptop Productividad</h5>
                                    <p class="card-text text-muted">CPU: Intel Core i7-1360P, RAM: 16GB LPDDR5, SSD: 512GB NVMe, Pantalla: 14" OLED.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$1,499.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/pccompacta.png" class="card-img-top p-3 rounded-4" alt="PC Mini RTX 4060">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">PC Gaming Compacta</h5>
                                    <p class="card-text text-muted">CPU: AMD Ryzen 5 7600, GPU: NVIDIA RTX 4060, RAM: 16GB DDR5, SSD: 1TB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$1,699.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/laptopbasica.jpg" class="card-img-top p-3 rounded-4" alt="Laptop Economica Ryzen 3">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">Laptop Básica</h5>
                                    <p class="card-text text-muted">CPU: AMD Ryzen 3 7320U, Gráficos: Radeon Graphics, RAM: 8GB LPDDR5, SSD: 256GB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$499.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/compu8.webp" class="card-img-top p-3 rounded-4" alt="PC Diseño Ryzen 9">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">PC Diseño Gráfico</h5>
                                    <p class="card-text text-muted">CPU: AMD Ryzen 9 7900X, GPU: NVIDIA RTX 4070, RAM: 64GB DDR5, SSD: 4TB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$2,999.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/laptopestudiante.png" class="card-img-top p-3 rounded-4" alt="Laptop Estudiante i5">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">Laptop Estudiante</h5>
                                    <p class="card-text text-muted">CPU: Intel Core i5-1235U, Gráficos: Iris Xe, RAM: 8GB DDR4, SSD: 512GB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$749.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <img src="resources/image/cpuoficina.jpeg" class="card-img-top p-3 rounded-4" alt="PC Oficina Basica i3">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title" style="color: #222; font-weight: 600;">PC Oficina Básica</h5>
                                    <p class="card-text text-muted">CPU: Intel Core i3-12100, Gráficos: Integrados UHD 730, RAM: 8GB DDR4, SSD: 256GB NVMe.</p>
                                    <h4 class="mt-auto mb-3" style="color: #3498DB; font-weight: 700;">$599.00</h4>
                                    <a href="#" class="btn btn-primary" style="background: #5DADE2; border: none;">Añadir al carrito <i class='bx bx-cart'></i></a>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </section>
        </main>
    </div>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
