package controller;

import dao.UsuarioDAO;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuario;

@WebServlet(name = "ServletUsuario", urlPatterns = {"/ServletUsuario"})
public class ServletUsuarios extends HttpServlet {

    private final UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null || accion.isEmpty()) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                doListarUsuarios(request, response);
                break;
            case "editar":
                doMostrarFormularioEdicion(request, response);
                break;
            default:
                doListarUsuarios(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("actualizar".equals(accion)) {
            doActualizarUsuario(request, response);
        } else {
            doListarUsuarios(request, response);
        }
    }

    private void doListarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Usuario> listaUsuarios = dao.listarUsuarios();
        request.setAttribute("listaUsuarios", listaUsuarios);
        request.getRequestDispatcher("mantenimientoUsuarios.jsp").forward(request, response);
    }

    private void doMostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idEditar = Integer.parseInt(request.getParameter("codigoUsuario"));
            Usuario usuario = dao.buscarPorId(idEditar);
            request.setAttribute("usuarioEditar", usuario);
            
            request.getRequestDispatcher("mantenimientoUsuarios.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("Error: El parámetro 'codigoUsuario' no es un número válido: " + request.getParameter("codigoUsuario"));
            doListarUsuarios(request, response);
        }
    }

    private void doActualizarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idActualizar = Integer.parseInt(request.getParameter("codigoUsuario"));
            Usuario usuarioActualizar = dao.buscarPorId(idActualizar);

            if (usuarioActualizar != null) {
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
                        System.err.println("Error al parsear fecha de nacimiento: " + e.getMessage());
                    }
                }

                dao.actualizar(usuarioActualizar);
            }
            response.sendRedirect("ServletUsuario?accion=listar");
        } catch (NumberFormatException e) {
            System.err.println("Error: El parámetro 'codigoUsuario' no es un número válido.");
            response.sendRedirect("ServletUsuario?accion=listar");
        } catch (Exception e) {
            System.err.println("Error al actualizar usuario: " + e.getMessage());
            response.sendRedirect("ServletUsuario?accion=listar");
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Servlet para el mantenimiento de usuarios";
    }
}