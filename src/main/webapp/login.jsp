<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Iniciar Sesión - Hyprdesk</title>
   
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
     
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
            }
            .login-container {
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
             
                margin: 20px auto; 
            }
           
            @keyframes fadeInSlideUp {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
            .login-container {
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
                margin-bottom: 0px;
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
            .btn-primary {
                background-color: var(--accent-blue);
                border-color: var(--accent-blue);
                font-weight: 600;
                padding: 10px 15px;
                font-size: 1rem;
                border-radius: 8px;
                color: #ffffff;
                transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out, box-shadow 0.3s ease-in-out;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            .btn-primary:hover {
                background-color: var(--primary);
                border-color: var(--primary);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            }
            .btn-primary:active {
                transform: translateY(0);
                box-shadow: none;
                background-color: #4A9DC7;
                border-color: #4A9DC7;
            }
            .text-center a {
                color: var(--accent-blue);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease-in-out;
                font-size: 0.85rem;
            }
            .text-center a:hover {
                color: var(--primary);
                text-decoration: underline;
                -webkit-font-smoothing: antialiased;
            }
            hr {
                border-top: 1px solid rgba(0, 0, 0, 0.08);
                margin-top: 0.8rem;
                margin-bottom: 0.8rem;
            }
            
            .mb-3 {
                margin-bottom: 0.5rem !important; 
            }
            .mb-4 {
                margin-bottom: 0.8rem !important; 
            }

            @media (max-height: 600px) {
                body {
                    align-items: flex-start; 
                    padding-top: 10px;
                    padding-bottom: 10px;
                }
                .login-container {
                    margin: 0 auto;
                    max-width: 380px;
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="logo-header">
                <div class="logo-placeholder">
                    <img src="resources/image/Logo.png" alt="Logo de Hyprdesk" class="img-fluid"/>
                </div>
                <h3 class="mt-3">Bienvenido a Hyprdesk</h3>
            </div>
            <div class="form-content">
                <h2 class="text-center mb-5">Iniciar Sesión</h2>
                <!-- Tu formulario (sin cambios en action o nombres) -->
                <form action="loginController" method="post">
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo</label>
                        <input type="text" class="form-control" id="email" name="email" placeholder="Ingresa tu correo" required>
                    </div>
                    <div class="mb-4">
                        <label for="contrasena" class="form-label">Contraseña</label>
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
