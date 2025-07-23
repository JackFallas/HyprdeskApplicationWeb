package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuarios;

@WebServlet("/guardarUsuario")
public class RegisterController extends HttpServlet{
    
    @Override
    protected void doPost(HttpServletRequest solicitud, HttpServletResponse respuesta) throws IOException, ServletException{
        respuesta.setContentType("text/html; charset=UTF=8");
        
        String nombreUsuario = solicitud.getParameter("nombreUsuario");
        String apellidoUsuario = solicitud.getParameter("apellidoUsuario");
        String telefono = solicitud.getParameter("telefono");
        String direccionUsuario = solicitud.getParameter("direccionUsuario");
        String email = solicitud.getParameter("email");
        String contrasena = solicitud.getParameter("contrasena");
        
        Usuarios usuario = new Usuarios(nombreUsuario, apellidoUsuario, telefono, direccionUsuario, email, contrasena);
        
        UsuarioDAO dao = new UsuarioDAO();
        dao.guardar(usuario);
        
        //respuesta.sendRedirect("index.jsp?confirmacion=guardado");
        respuesta.sendRedirect("index.jsp?confirmacion=guardado");


    }
}
