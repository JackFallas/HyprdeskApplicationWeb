package controller;

import com.hyprdesk.servicios.EmailService;
import dao.UsuarioDAO;
import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuario;

@WebServlet("/guardarUsuario")
public class ServletRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException {
        respuesta.setContentType("text/html; charset=UTF=8");

        String nombreUsuario = solicitud.getParameter("nombreUsuario");
        String apellidoUsuario = solicitud.getParameter("apellidoUsuario");
        String telefono = solicitud.getParameter("telefono");
        String direccionUsuario = solicitud.getParameter("direccionUsuario");
        String email = solicitud.getParameter("email");
        String contrasena = solicitud.getParameter("contrasena");
        String estadoUsuario = "Activo";
        String rol = "Usuario";
        String fechaNacimientoS = solicitud.getParameter("fechaNacimiento");
        
        LocalDate fechaNacimiento = null;
        try {
            fechaNacimiento = LocalDate.parse(fechaNacimientoS);
        } catch (Exception e) {
            solicitud.setAttribute("error", "Formato de fecha de nacimiento inválido.");
            solicitud.getRequestDispatcher("register.jsp").forward(solicitud, respuesta);
            return;
        }

        if (!contrasenaValida(contrasena)) {
            solicitud.setAttribute("error", "La contraseña debe tener al menos 8 caracteres, "
                                     + "una letra mayúscula, un número y un carácter especial.");
            solicitud.getRequestDispatcher("register.jsp").forward(solicitud, respuesta);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        if (dao.erorEmail(email)) {
            solicitud.setAttribute("error", "El correo ya está registrado.");
            solicitud.getRequestDispatcher("register.jsp").forward(solicitud, respuesta);
            return;
        }
        
        Usuario usuario = new Usuario(nombreUsuario, apellidoUsuario, telefono, direccionUsuario, email, contrasena, estadoUsuario, rol, fechaNacimiento);

        try {
            dao.guardar(usuario);
            EmailService emailService = new EmailService();
            emailService.enviarCorreoBienvenida(usuario.getEmail(), usuario.getNombreUsuario());

            solicitud.setAttribute("confirma", "guardado");
            solicitud.getRequestDispatcher("login.jsp").forward(solicitud, respuesta);
        } catch (Exception e) {
            System.err.println("Error al registrar usuario o enviar correo: " + e.getMessage());
            solicitud.setAttribute("error", "Ocurrió un error al registrar el usuario.");
            solicitud.getRequestDispatcher("register.jsp").forward(solicitud, respuesta);
        }
    }

    private boolean contrasenaValida(String contrasena) {
        String patron = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&.,_\\-])[A-Za-z\\d@$!%*?&.,_\\-]{8,}$";
        return contrasena != null && contrasena.matches(patron);
    }
}