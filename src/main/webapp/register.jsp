<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Regístrate</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background-color: #3498DB;
                font-family: "Verdana", sans-serif;
            }
            .register-container {
                max-width: 500px;
                padding: 0;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                background: linear-gradient(135deg, #f8f8f8 0%, #e0f2f7 100%);
            }
            .logo-header {
                background-color: rgba(93, 173, 226, 0.9);
                padding: 30px 20px;
                text-align: center;
                position: relative;
                color: #ffffff;
                font-family: "Papyrus", fantasy;
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
                color: #3498DB;
                font-family: "Papyrus", fantasy;
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
            .btn {
                padding: 12px 20px;
                font-size: 1.1rem;
                border-radius: 6px;
                background-color: #3498DB;
                border-color: #3498DB;
                color: #ffffff;
                transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out;
            }
            .btn:hover {
                background-color: #2874A6 !important;
                border-color: #2874A6 !important;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }
            .btn:active {
                transform: translateY(0);
                box-shadow: none;
            }
            .btn-success {
                background-color: #3498DB !important;
                border-color: #3498DB !important;
            }
            .btn-success:hover {
                background-color: #2874A6 !important;
                border-color: #2874A6 !important;
            }
            .text-center.mt-4 a {
                text-decoration: none;
                font-weight: 500;
                color: #3498DB;
                transition: color 0.3s ease-in-out;
            }
            .text-center.mt-4 a:hover {
                color: #717D7E;
                text-decoration: underline;
                -webkit-font-smoothing: antialiased;
            }
        </style>
    </head>
    <body style="background-color: #3498DB;">

        <%
           
            String confirmacion = request.getParameter("confirmacion");
            if ("guardado".equals(confirmacion)) {
        %>
        <div class="alert alert-success" role="alert">
            ¡Registro exitoso! Ahora puedes iniciar sesión.
        </div>
        <%
            }
        %>

        <div class="register-container">
            <div class="logo-header">
                <div class="logo-placeholder">
                    <img src="image/Logo.png" alt="Logo de Hyprdesk" class="img-fluid" style="max-width: 120px; height: auto; display: block; margin: 0 auto; position: relative; z-index: 1;"/>
                </div>
                <h3 class="mt-3" style="position: relative; z-index: 1;">Bienvenido a Hyprdesk</h3>
            </div>
            <div class="form-content">
                <h2 class="text-center mb-5 fw-bold">Crear una Cuenta</h2>
                <form id="formulario" action="guardarUsuario" method="POST"> 
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="nombreUsuario" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombreUsuario" name="nombreUsuario" required>
                        </div>
                        <div class="col-md-6">
                            <label for="apellidoUsuario" class="form-label">Apellido</label>
                            <input type="text" class="form-control" id="apellidoUsuario" name="apellidoUsuario" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono" required>
                    </div>
                    <div class="mb-3">
                        <label for="direccionUsuario" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="direccionUsuario" name="direccionUsuario" required>
                    </div>
                    <div class="mb-3">
                        <label for="contrasena" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                    </div>
                    <div class="mb-4">
                        <label for="confirmarContrasena" class="form-label">Confirmar Contraseña</label>
                        <input type="password" class="form-control" id="confirmarContrasena" oninput="this.setCustomValidity(this.value !== contrasena.value ? 'Las contraseñas no coinciden' : '')" required> <%-- **Validación de contraseña añadida** --%>
                    </div>
                    <button type="submit" class="btn btn-success w-100 mt-3">Registrarse</button>
                    <p class="text-center mt-4">
                        ¿Ya tienes una cuenta? <a href="login.jsp">Inicia Sesión aquí</a>
                    </p>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>