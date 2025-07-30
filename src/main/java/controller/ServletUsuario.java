
package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuarios;

@WebServlet(name = "ServletUsuario", urlPatterns = {"/ServletUsuario"})
public class ServletUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String accion = request.getParameter("accion");
        
        if (accion == null || accion.isEmpty()) {
            accion = "listar"; 
        }

        switch (accion) {
            case "listar":
                doListarUsuarios(request, response);
                break;
            case "eliminar":
                doEliminarUsuario(request, response);
                break;
            case "actualizar":
                doActualizarUsuario(request, response);
                break;
            default:
                doListarUsuarios(request, response); 
                break;
        }
    }

    private void doListarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuarios> listaUsuarios = dao.listarUsuarios();
        request.setAttribute("listaUsuarios", listaUsuarios);
        request.getRequestDispatcher("mantenimientoUsuario.jsp").forward(request, response); 
    }

    private void doEliminarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idEliminar = Integer.parseInt(request.getParameter("id"));
        UsuarioDAO dao = new UsuarioDAO();
        dao.eliminar(idEliminar);
        response.sendRedirect("UsuarioServlet?accion=listar"); 
    }

    private void doActualizarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsuarioDAO dao = new UsuarioDAO();
        int idActualizar = Integer.parseInt(request.getParameter("id"));
        Usuarios usuarioActualizar = dao.buscarPorId(idActualizar);

        usuarioActualizar.setNombreUsuario(request.getParameter("nombreUsuario"));
        usuarioActualizar.setApellidoUsuario(request.getParameter("apellidoUsuario"));
        usuarioActualizar.setTelefono(request.getParameter("telefono"));
        usuarioActualizar.setDireccionUsuario(request.getParameter("direccionUsuario"));
        usuarioActualizar.setEmail(request.getParameter("email"));
        usuarioActualizar.setContrasena(request.getParameter("contrasena"));
        usuarioActualizar.setEstadoUsuario(request.getParameter("estadoUsuario"));
        usuarioActualizar.setRol(request.getParameter("rol"));
        
        String fechaNacimientoStrAct = request.getParameter("fechaNacimiento");
        if (fechaNacimientoStrAct != null && !fechaNacimientoStrAct.isEmpty()) {
            try {
                LocalDate fechaNacimientoLocalDate = LocalDate.parse(fechaNacimientoStrAct); 
                usuarioActualizar.setFechaNacimiento(fechaNacimientoLocalDate);
            } catch (java.time.format.DateTimeParseException e) {
                e.printStackTrace(); 
            }
        }
        
        dao.actualizar(usuarioActualizar);
        response.sendRedirect("UsuarioServlet?accion=listar"); 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
