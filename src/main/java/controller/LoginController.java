
package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Usuarios;

@WebServlet("/loginController")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String contrasena = request.getParameter("contrasena"); 

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuarios usuario = usuarioDAO.validarCredenciales(email, contrasena);

        if (usuario != null) {
            
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);

           
            response.sendRedirect("index.jsp"); 
        } else {
            response.sendRedirect("login.jsp?mensaje=error");
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
