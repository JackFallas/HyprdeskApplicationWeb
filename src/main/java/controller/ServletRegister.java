package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;
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
        LocalDate fechaNacimiento = LocalDate.parse(fechaNacimientoS);

        if (!contrasenaValida(contrasena)) {
            solicitud.setAttribute("error", "La contraseña debe tener al menos 8 caracteres, "
                    + "una letra mayúscula, un número y un carácter especial.");
            solicitud.getRequestDispatcher("register.jsp").forward(solicitud, respuesta);
            return;
        }

        Usuario usuario = new Usuario(nombreUsuario, apellidoUsuario, telefono, direccionUsuario, email, contrasena, estadoUsuario, rol, fechaNacimiento);

        UsuarioDAO dao = new UsuarioDAO();
        if (dao.erorEmail(email)) {
            solicitud.setAttribute("error", "El correo ya está registrado.");
            solicitud.getRequestDispatcher("register.jsp").forward(solicitud, respuesta);
            return;
        }
        dao.guardar(usuario);

        solicitud.setAttribute("confirmacion", "guardado");
        solicitud.getRequestDispatcher("login.jsp").forward(solicitud, respuesta);

    }

    private boolean contrasenaValida(String contrasena) {
        String patron = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&.,_\\-])[A-Za-z\\d@$!%*?&.,_\\-]{8,}$";
        return contrasena != null && contrasena.matches(patron);
    }
}
