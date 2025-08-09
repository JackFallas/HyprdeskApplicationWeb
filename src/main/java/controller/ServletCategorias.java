package controller;

import dao.CategoriaDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Categoria;

@WebServlet(name = "ServletCategorias", urlPatterns = {"/ServletCategorias"})
public class ServletCategorias extends HttpServlet {

    private CategoriaDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new CategoriaDAO(); 
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listarCategorias(request, response);
                break;
            case "agregar":
                agregarCategoria(request, response);
                break;
            case "editar":
                editarCategoria(request, response);
                break;
            case "actualizar":
                actualizarCategoria(request, response);
                break;
            case "eliminar":
                eliminarCategoria(request, response);
                break;
            default:
                response.sendRedirect("ServletCategorias?accion=listar");
                break;
        }
    }

    private void listarCategorias(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Categoria> listaCategorias = dao.listarTodos();
        request.setAttribute("listaCategorias", listaCategorias);
        request.getRequestDispatcher("mantenimientoCategorias.jsp").forward(request, response);
    }

    private void agregarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nombreCategoria = request.getParameter("nombreCategoria");
        String descripcionCategoria = request.getParameter("descripcionCategoria");

        Categoria categoria = new Categoria(nombreCategoria, descripcionCategoria);
        dao.guardar(categoria);

        response.sendRedirect("ServletCategorias?accion=listar");
    }

    private void editarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idEditar = Integer.parseInt(request.getParameter("id"));
        Categoria categoria = dao.buscarPorId(idEditar);
        request.setAttribute("categoriaEditar", categoria);
        request.getRequestDispatcher("mantenimientoCategorias.jsp").forward(request, response);
    }

    private void actualizarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int idActualizar = Integer.parseInt(request.getParameter("id"));
        Categoria categoria = dao.buscarPorId(idActualizar);
        if (categoria != null) {
            categoria.setNombreCategoria(request.getParameter("nombreCategoria"));
            categoria.setDescripcionCategoria(request.getParameter("descripcionCategoria"));
            dao.Actualizar(categoria);
        } else {
            // opcional: redireccionar con un mensaje de error
        }

        categoria.setNombreCategoria(request.getParameter("nombreCategoria"));
        categoria.setDescripcionCategoria(request.getParameter("descripcionCategoria"));

        dao.Actualizar(categoria);
        response.sendRedirect("ServletCategorias?accion=listar");
    }

    private void eliminarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int idEliminar = Integer.parseInt(request.getParameter("id"));
        dao.Eliminar(idEliminar);
        response.sendRedirect("ServletCategorias?accion=listar");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet de categorías";
    }
}
