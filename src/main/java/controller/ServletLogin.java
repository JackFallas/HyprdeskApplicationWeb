package controller;

import com.hyprdesk.servicios.EmailService; 
import dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Usuario;

@WebServlet("/loginController")
public class ServletLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String contrasena = request.getParameter("contrasena");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.validarCredenciales(email, contrasena);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);

            String rol = usuario.getRol();
            
            session.setAttribute("rol", rol);
            session.setAttribute("idUsuario", usuario.getCodigoUsuario());
            
            EmailService emailService = new EmailService();
            emailService.enviarNotificacionLogin(usuario.getEmail(), usuario.getNombreUsuario());

            if ("Admin".equalsIgnoreCase(rol)) {
                request.setAttribute("confirmacion", "guardado");
                request.getRequestDispatcher("dashboardAdmin.jsp").forward(request, response);
            } else if ("Usuario".equalsIgnoreCase(rol)) {
                request.setAttribute("confirmacion", "guardado");
                request.getRequestDispatcher("dashboardUsuario.jsp").forward(request, response);
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            request.setAttribute("error", "Credenciales incorrectas");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("logout")) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();    
            }
            response.sendRedirect("login.jsp?mensaje=logout");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}