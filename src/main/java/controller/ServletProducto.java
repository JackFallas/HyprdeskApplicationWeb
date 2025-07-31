/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductoDAO;
import model.Producto;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author informatica
 */
@WebServlet(name = "ServletProducto", urlPatterns = {"/ServletProducto"})
public class ServletProducto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    // Recursos locales para el funcionamiento del Servlet -----------------
    // Instancia del dao
    ProductoDAO dao = new ProductoDAO();
    
    // Logica para manejar fechas-------------------
    //Darle un formato a la fecha
    SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd    ");
    //Definir las fechas en nulas
    Date fechaEntrada = null;
    Date fechaSalida = null;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
        switch (accion) {
            case "listar":
                listarProductos(request, response);
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
    
    private void agregarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombreProducto");
        String descripcion = request.getParameter("descripcionProducto");
        
        /*
            Segun la logica, para manejar una fecha correctamente o conversiones de datos, debemos meter un trycatch
            para que evite un error 500 en la pagina y permita capturar mejor el error mostrando un mensaje
        */
        try {
            // Conversion de datos
            double precio = Double.parseDouble(request.getParameter("precioProducto"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            Date fechaEntrada = new Date(formatoFecha.parse(request.getParameter("fechaEntrada")).getTime());
            Date fechaSalida = new Date(formatoFecha.parse(request.getParameter("fechaSalida")).getTime());
            
            //Llaves Foraneas
            int codigoMarca = Integer.parseInt(request.getParameter("codigoMarca"));
            int codigoCategoria = Integer.parseInt(request.getParameter("codigoCategoria"));
            
            // Creacion y guardado del objeto / poroducto
            Producto producto = new Producto(nombre,descripcion,precio,stock,fechaEntrada,fechaSalida,codigoMarca,codigoCategoria);
            dao.guardar(producto);
            
            response.sendRedirect("ServletProducto?accion=listar");
        } catch (NumberFormatException | ParseException e ) {
            System.err.println("Error al agregar producto: " + e.getMessage());
        }   
    }
    
    private void editarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        /*
            Lo mismo que agregar, la unica diferencia relevante es que el swich es funcional peeero
            se puede arreglar o mejorar utilizando un if, porque? porque separa la logica de los case
            por aparte y asi el trycatch solo envuelve la logica que puede fallar (no todo el swich)
        */
        String accion = request.getParameter("accion");
        try {
            switch (accion) {
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Producto producto = dao.buscarPorID(idEditar);
                
                request.setAttribute("productoEditar", producto);
                request.getRequestDispatcher("mantenimientoProductos.jsp").forward(request, response);
                break;
            case "actualizar":
                int idActualizar = Integer.parseInt(request.getParameter("id"));
                producto = dao.buscarPorID(idActualizar);
                producto.setNombre(request.getParameter("nombreProducto"));
                producto.setDescripcion(request.getParameter("descripcionProducto"));
                producto.setPrecio(Double.parseDouble(request.getParameter("precioProducto")));
                producto.setStock(Integer.parseInt(request.getParameter("stock")));
                //Convertir las fechas en String con trycatch
                producto.setFechaEntrada(new Date(formatoFecha.parse(request.getParameter("fechaEntrada")).getTime()));
                producto.setFechaSalida(new Date(formatoFecha.parse(request.getParameter("fechaSalida")).getTime()));
                //Llaves Foraneas
                producto.setCodigoMarca(Integer.parseInt(request.getParameter("codigoMarca")));
                producto.setCodigoCategoria(Integer.parseInt(request.getParameter("codigoCategoria")));
                
                dao.Actualizar(producto);
                response.sendRedirect("ServletProducto?accion=listar");
                break;
            default:
                List<Producto> listaProductos = dao.listarTodos();
                request.setAttribute("listaProductos", listaProductos);
                request.getRequestDispatcher("mantenimientoProductos.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error al editar producto: " + e.getMessage());
        } 
    }
    
    private void eliminarProducto (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        int idEliminar = Integer.parseInt(request.getParameter("id"));
        dao.Eliminar(idEliminar);
        response.sendRedirect("/ServletProducto?accion=listar");
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
