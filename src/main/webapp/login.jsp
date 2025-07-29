<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Iniciar Sesión</title>
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <style>
            body {
                background-color: #3498DB;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                font-family: "Verdana", sans-serif;
            }
            .login-container {
                padding: 0;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
                width: 100%;
                max-width: 450px;
                overflow: hidden;
                background: linear-gradient(135deg, #f8f8f8 0%, #e0f2f7 100%);
            }
            .logo-header {
                background-color: rgba(93, 173, 226, 0.9);
                padding: 30px 20px;
                text-align: center;
                position: relative;
                color: #ffffff;
                font-family: "Roboto", sans-serif;
            }
            .logo-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-size: cover;
                background-position: center;
                filter: blur(8px);
                z-index: 0;
            }
            .logo-placeholder {
                width: 120px;
                height: 120px;
                background-color: #333333;
                border-radius: 50%;
                margin: 0 auto 15px auto;
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
                z-index: 1;
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.3);
            }
            .form-content {
                padding: 40px;
            }
            .form-content h2 {
                margin-bottom: 30px;
                color: #3498DB;
                text-align: center;
                font-family: "Roboto", sans-serif;
            }
            .form-label {
                font-weight: 500;
                margin-bottom: 8px;
                color: #717D7E;
            }
            .form-control {
                border-radius: 6px;
                padding: 10px 15px;
                transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }
            .form-control:focus {
                border-color: #3498DB;
                box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
                outline: none;
            }
            .btn-primary {
                background-color: #3498DB;
                border-color: #3498DB;
                font-weight: 600;
                padding: 12px 20px;
                font-size: 1.1rem;
                border-radius: 6px;
                color: #ffffff;
                transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out, box-shadow 0.3s ease-in-out;
            }
            .btn-primary:hover {
                background-color: #2874A6;
                border-color: #2874A6;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }
            .btn-primary:active {
                transform: translateY(0);
                box-shadow: none;
            }
            .text-center a {
                color: #3498DB;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease-in-out;
            }
            .text-center a:hover {
                color: #717D7E;
                text-decoration: underline;
                -webkit-font-smoothing: antialiased;
            }
            hr {
                border-top: 1px solid rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="logo-header">
                <div class="logo-placeholder">
                    <img src="image/Logo.png" alt="Logo de Hyprdesk" class="img-fluid" style="max-width: 120px; height: auto; display: block; margin: 0 auto; position: relative; z-index: 1;"/>
                </div>
                <h3 class="mt-3" style="position: relative; z-index: 1;">Bienvenido a Hyprdesk</h3>
            </div>
            <div class="form-content">
                <h2 class="text-center mb-5 fw-bold">Iniciar Sesión</h2>
                <form action="loginController" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Correo</label>
                        <input type="text" class="form-control" id="email" name="email" placeholder="Ingresa tu correo" required>
                    </div>
                    <div class="mb-4">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Ingresa tu contraseña" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Ingresar</button>
                </form>
                <hr class="my-4">
                <p class="text-center">¿No tienes una cuenta? <a href="register.jsp">Regístrate aquí</a></p>
            </div>
        </div>
    </body>
</html>