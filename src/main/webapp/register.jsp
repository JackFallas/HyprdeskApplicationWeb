<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Regístrate - Hyprdesk</title>
   
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/bootstrap-icons.min.css" rel="stylesheet">
       
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <style>
           
            :root {
                --primary: #0d6efd; 
                --accent-blue: #5DADE2; 
                --bg-light: #eaeaea; 
                --text-dark: #222; 
                --text-muted: #4b5563; 
                --card-bg: #ffffff;
                --radius: 12px; 
            }

            body {
                background-color: var(--bg-light);
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                font-family: 'Poppins', sans-serif; 
                overflow-y: auto;
                padding: 20px 0; 
            }
            .register-container {
                padding: 0;
                border-radius: var(--radius);
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 480px; 
                overflow: hidden;
                background: var(--card-bg);
                transition: transform 0.3s ease;
                transform: translateY(0);
                opacity: 1;
                margin: auto; 
            }
          
            @keyframes fadeInSlideUp {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
            .register-container {
                animation: fadeInSlideUp 0.8s ease-out forwards;
            }

            .logo-header {
                background: linear-gradient(135deg, var(--accent-blue) 0%, var(--primary) 100%);
                padding: 15px 15px; 
                text-align: center;
                position: relative;
                color: #ffffff;
                font-family: 'Poppins', sans-serif;
                overflow: hidden;
                border-top-left-radius: var(--radius);
                border-top-right-radius: var(--radius);
            }
            .logo-header::before {
                content: none; 
            }
            .logo-placeholder {
                width: 80px; 
                height: 80px;
                background-color: rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                margin: 0 auto 5px auto; 
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
                z-index: 1;
                border: 2px solid rgba(255, 255, 255, 0.5);
            }
            .logo-placeholder img {
                max-width: 60px; 
                height: auto;
                display: block;
            }
            .logo-header h3 {
                font-size: 1.1rem;
                margin-top: 5px !important; 
                font-weight: 600;
            }

            .form-content {
                padding: 20px 25px; 
            }
            .form-content h2 {
                margin-bottom: 15px; 
                color: var(--accent-blue);
                text-align: center;
                font-family: 'Poppins', sans-serif;
                font-weight: 700;
                font-size: 1.6rem;
            }
            .form-label {
                font-weight: 500;
                margin-bottom: 3px; 
                color: var(--text-muted);
                font-size: 0.85rem;
            }
            .form-control {
                border-radius: 8px;
                padding: 8px 12px; 
                transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                border: 1px solid #ced4da;
                font-size: 0.9rem;
            }
            .form-control:focus {
                border-color: var(--accent-blue);
                box-shadow: 0 0 0 0.25rem rgba(93, 173, 226, 0.25);
                outline: none;
            }
           
            .btn-success { 
                background-color: var(--accent-blue) !important;
                border-color: var(--accent-blue) !important;
                font-weight: 600;
                padding: 10px 15px;
                font-size: 1rem;
                border-radius: 8px;
                color: #ffffff;
                transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out, box-shadow 0.3s ease-in-out;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            .btn-success:hover {
                background-color: var(--primary) !important;
                border-color: var(--primary) !important;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            }
            .btn-success:active {
                transform: translateY(0);
                box-shadow: none;
                background-color: #4A9DC7 !important;
                border-color: #4A9DC7 !important;
            }

            .text-center.mt-3 a { 
                text-decoration: none;
                font-weight: 500;
                color: var(--accent-blue);
                transition: color 0.3s ease-in-out;
                font-size: 0.85rem;
            }
            .text-center.mt-3 a:hover {
                color: var(--primary);
                text-decoration: underline;
                -webkit-font-smoothing: antialiased;
            }
            
            .mb-3 {
                margin-bottom: 0.75rem !important; 
            }
          
            @media (max-height: 800px) { 
                .register-container {
                    margin: 10px auto;
                }
                body {
                    padding: 10px 0; 
                }
            }
            @media (max-height: 650px) { 
                .form-content {
                    padding: 15px 20px; 
                }
                .form-control {
                    padding: 6px 10px; 
                }
                .btn-success {
                    padding: 8px 12px;
                }
                .form-label {
                    font-size: 0.8rem;
                }
                .text-center.mt-3 a {
                    font-size: 0.8rem;
                }
                .mb-3 {
                    margin-bottom: 0.6rem !important;
                }
            }
        </style>
    </head>
    <body>

        <%
            String confirmacion = request.getParameter("confirmacion");
            if ("guardado".equals(confirmacion)) {
        %>
        <div class="alert alert-success alert-compact" role="alert">
            ¡Registro completo! Inicia sesión.
        </div>
        <%
            }
        %>

        <div class="register-container">
            <div class="logo-header">
                <div class="logo-placeholder">
                    <img src="resources/image/Logo.png" alt="Logo de Hyprdesk" class="img-fluid"/>
                </div>
                <h3 class="mt-3">Bienvenido a Hyprdesk</h3>
            </div>
            <div class="form-content">
                <h2 class="text-center mb-4">Crear una cuenta</h2>
            <form id="formulario" action="guardarUsuario" method="POST">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="nombreUsuario" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombreUsuario" name="nombreUsuario" required>
                    </div>
                    <div class="col-md-6 mb-3">
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
                    <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento</label>
                    <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required>
                </div>
                <div class="mb-3">
                    <label for="direccionUsuario" class="form-label">Dirección</label>
                    <input type="text" class="form-control" id="direccionUsuario" name="direccionUsuario" required>
                </div>
                <div class="mb-3">
                    <label for="contrasena" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                </div>
                <div class="mb-3">
                    <label for="confirmarContrasena" class="form-label">Confirmar Contraseña</label>
                    <input type="password" class="form-control" id="confirmarContrasena" oninput="this.setCustomValidity(this.value !== contrasena.value ? 'Las contraseñas no coinciden' : '')">
                </div>
                <%
                    String error = (String) request.getAttribute("error");
                    String confirma = (String) request.getAttribute("confirmacion");
                    if (error != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%= error%>
                </div>
                <%
                } else if ("guardado".equals(confirmacion)) {
                %>
                <div class="alert alert-success mt-3" role="alert">
                    ¡Registro exitoso! Ahora puedes iniciar sesión.
                </div>
                <%
                    }
                %>
                <button type="submit" class="btn btn-success w-100 mt-3">Registrarse</button>
                <p class="text-center mt-3">
                    ¿Ya tienes una cuenta? <a href="login.jsp">Inicia Sesión aquí</a>
                </p>
                </form>
            </div>
        </div>
    </body>
</html>
