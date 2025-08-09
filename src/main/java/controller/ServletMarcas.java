package controller;

import dao.MarcaDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Marca;

@WebServlet(name = "ServletMarcas", urlPatterns = {"/ServletMarcas"})
public class ServletMarcas extends HttpServlet {

    private MarcaDAO marcaDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        marcaDAO = new MarcaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion == null || accion.isEmpty()) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listarMarcas(request, response);
                break;
            case "editar":
                mostrarFormularioEdicion(request, response); // Nuevo método para manejar la edición
                break;
            case "eliminar":
                eliminarMarca(request, response);
                break;
            default:
                listarMarcas(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion == null || accion.isEmpty()) {
            accion = "insertar";
        }

        switch (accion) {
            case "insertar":
                insertarMarca(request, response);
                break;
            case "actualizar":
                actualizarMarca(request, response);
                break;
            default:
                listarMarcas(request, response);
                break;
        }
    }

    private void listarMarcas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Marca> listaMarcas = marcaDAO.listarMarcas();
        request.setAttribute("listaMarcas", listaMarcas);
        request.getRequestDispatcher("mantenimientoMarcas.jsp").forward(request, response);
    }
    
    // Método para mostrar el formulario de edición
    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoMarca = Integer.parseInt(request.getParameter("id"));
            Marca marca = marcaDAO.buscarPorId(codigoMarca);
            
            request.setAttribute("marcaEditar", marca);
            listarMarcas(request, response); // Muestra el formulario con los datos de la marca
        } catch (NumberFormatException e) {
            System.err.println("Error al obtener ID para editar: " + e.getMessage());
            listarMarcas(request, response); // Si hay un error, solo muestra la lista
        }
    }

    private void insertarMarca(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreMarca = request.getParameter("nombreMarca");
        String descripcion = request.getParameter("descripcion");
        String estadoMarca = request.getParameter("estadoMarca");

        Marca nuevaMarca = new Marca(nombreMarca, descripcion, estadoMarca);

        try {
            marcaDAO.guardar(nuevaMarca);
            response.sendRedirect(request.getContextPath() + "/ServletMarcas?accion=listar");
        } catch (Exception e) {
            request.setAttribute("error", "Error al insertar la marca: " + e.getMessage());
            listarMarcas(request, response);
        }
    }

    private void actualizarMarca(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoMarca = Integer.parseInt(request.getParameter("codigoMarca"));
            String nombreMarca = request.getParameter("nombreMarca");
            String descripcion = request.getParameter("descripcion");
            String estadoMarca = request.getParameter("estadoMarca");

            Marca marcaExistente = marcaDAO.buscarPorId(codigoMarca);

            if (marcaExistente != null) {
                marcaExistente.setNombreMarca(nombreMarca);
                marcaExistente.setDescripcion(descripcion);
                marcaExistente.setEstadoMarca(estadoMarca);
                marcaDAO.actualizar(marcaExistente);
            }
            response.sendRedirect(request.getContextPath() + "/ServletMarcas?accion=listar");
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar la marca: " + e.getMessage());
            listarMarcas(request, response);
        }
    }

    private void eliminarMarca(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoMarca = Integer.parseInt(request.getParameter("id"));
            marcaDAO.eliminar(codigoMarca);
        } catch (NumberFormatException e) {
            System.err.println("Error al obtener ID para eliminar: " + e.getMessage());
        } finally {
            response.sendRedirect(request.getContextPath() + "/ServletMarcas?accion=listar");
        }
    }
}