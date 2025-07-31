package controller;

import dao.UsuarioDAO;
import model.Usuarios;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class CrearAdmin implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuarios admin = usuarioDAO.buscarPorEmail("admin@miempresa.com");

        if (admin == null) {
            admin = new Usuarios();
            admin.setNombreUsuario("Admin");
            admin.setApellidoUsuario("Admin");
            admin.setTelefono("1234567890");
            admin.setDireccionUsuario("Calle Ficticia 123");
            admin.setEmail("admin@miempresa.com");
            admin.setFechaNacimiento(LocalDate.parse("1983-07-15"));
            admin.setContrasena("admin123");
            admin.setRol("Admin");

            usuarioDAO.guardar(admin);
            System.out.println("Administrador creado automáticamente al iniciar la aplicación.");
        } else {
            System.out.println("El administrador ya existe. No se creó uno nuevo.");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Puedes dejar esto vacío si no necesitas hacer limpieza
    }
}