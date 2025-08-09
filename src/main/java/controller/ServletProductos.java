package controller;

import dao.ProductoDAO;
import model.Producto;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Categoria;
import model.Marca;

@WebServlet(name = "ServletProducto", urlPatterns = {"/ServletProducto"})
public class ServletProductos extends HttpServlet {

    private final ProductoDAO dao = new ProductoDAO();
    private final SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null || accion.isEmpty()) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listarProductos(request, response);
                break;
            case "editar":
                mostrarFormularioEdicion(request, response);
                break;
            case "eliminar":
                eliminarProducto(request, response);
                break;
            default:
                listarProductos(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null || accion.isEmpty()) {
            listarProductos(request, response);
            return;
        }
        
        switch (accion) {
            case "agregar":
                agregarProductos(request, response);
                break;
            case "actualizar":
                actualizarProductos(request, response);
                break;
            default:
                listarProductos(request, response);
        }
    }

    private void listarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Producto> listaProductos = dao.listarTodos();
        request.setAttribute("listaProductos", listaProductos);
        request.getRequestDispatcher("mantenimientoProductos.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idEditar = Integer.parseInt(request.getParameter("id"));
            Producto producto = dao.buscarPorID(idEditar);
            request.setAttribute("productoEditar", producto);
            // Reenviamos a la misma página JSP, pero ahora con los datos del producto a editar
            listarProductos(request, response); 
        } catch (NumberFormatException e) {
            System.err.println("Error al obtener ID para editar: " + e.getMessage());
            listarProductos(request, response);
        }
    }

    private void agregarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nombre = request.getParameter("nombreProducto");
            String descripcion = request.getParameter("descripcionProducto");
            double precio = Double.parseDouble(request.getParameter("precioProducto"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            Date fechaEntrada = new Date(formatoFecha.parse(request.getParameter("fechaEntrada")).getTime());
            Date fechaSalida = new Date(formatoFecha.parse(request.getParameter("fechaSalida")).getTime());
            int codigoMarca = Integer.parseInt(request.getParameter("codigoMarca"));
            int codigoCategoria = Integer.parseInt(request.getParameter("codigoCategoria"));

            Marca marca = new Marca();
            marca.setCodigoMarca(codigoMarca);
            Categoria categoria = new Categoria();
            categoria.setCodigoCategoria(codigoCategoria);

            Producto producto = new Producto(nombre, descripcion, precio, stock, fechaEntrada, fechaSalida, marca, categoria);
            dao.guardar(producto);
            response.sendRedirect(request.getContextPath() + "/ServletProducto?accion=listar");
        } catch (NumberFormatException | ParseException e) {
            System.err.println("Error al agregar producto: " + e.getMessage());
            // Puedes agregar un mensaje de error a la petición si lo necesitas
            response.sendRedirect(request.getContextPath() + "/ServletProducto?accion=listar");
        }
    }

    private void actualizarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idActualizar = Integer.parseInt(request.getParameter("id"));
            Producto producto = dao.buscarPorID(idActualizar);
            if (producto != null) {
                producto.setNombre(request.getParameter("nombreProducto"));
                producto.setDescripcion(request.getParameter("descripcionProducto"));
                producto.setPrecio(Double.parseDouble(request.getParameter("precioProducto")));
                producto.setStock(Integer.parseInt(request.getParameter("stock")));
                producto.setFechaEntrada(new Date(formatoFecha.parse(request.getParameter("fechaEntrada")).getTime()));
                producto.setFechaSalida(new Date(formatoFecha.parse(request.getParameter("fechaSalida")).getTime()));
                
                Marca marca = new Marca();
                marca.setCodigoMarca(Integer.parseInt(request.getParameter("codigoMarca")));
                producto.setMarca(marca);
                
                Categoria categoria = new Categoria();
                categoria.setCodigoCategoria(Integer.parseInt(request.getParameter("codigoCategoria")));
                producto.setCategoria(categoria);
                
                dao.Actualizar(producto);
            }
            response.sendRedirect(request.getContextPath() + "/ServletProducto?accion=listar");
        } catch (Exception e) {
            System.err.println("Error al actualizar producto: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ServletProducto?accion=listar");
        }
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idEliminar = Integer.parseInt(request.getParameter("id"));
            dao.Eliminar(idEliminar);
        } catch (NumberFormatException e) {
            System.err.println("Error al obtener ID para eliminar: " + e.getMessage());
        } finally {
            response.sendRedirect(request.getContextPath() + "/ServletProducto?accion=listar");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para el mantenimiento de productos";
    }
}