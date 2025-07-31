package controller; // Asegúrate de que este archivo esté en la carpeta 'controller' de tu proyecto

import dao.DetallePedidoDAO; // Tu DAO para DetallePedido (singular)
import model.DetallePedido;  // Tu modelo para DetallePedido (singular)
import model.Pedidos;        // ¡Tu modelo real para Pedidos (plural)!
import model.Producto;       // Tu modelo para Producto (asumiendo singular, sin cambios)
import dao.PedidoDAO;        // ¡Tu DAO real para Pedido (singular, opera en Pedidos)!
import dao.ProductoDAO;      // Tu DAO para Producto (asumiendo singular, sin cambios)

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet centralizado para la gestión de DetallePedido.
 * Maneja operaciones de listar, agregar, editar y eliminar detalles de pedido
 * utilizando métodos separados para cada acción.
 */
@WebServlet(name = "ServletDetallePedido", urlPatterns = {"/ServletDetallePedido"})
public class ServletDetallePedido extends HttpServlet {

    // Instancias de los DAOs, se inicializan una vez para ser reutilizadas.
    // Ahora PedidoDAO y Pedidos se refieren a tus clases reales.
    private DetallePedidoDAO detallePedidosDao = new DetallePedidoDAO();
    private PedidoDAO pedidoDao = new PedidoDAO();
    private ProductoDAO productoDao = new ProductoDAO(); // Se mantiene como estaba

    /**
     * Procesa las peticiones HTTP para los métodos GET y POST.
     * Este método actúa como un despachador que delega la lógica a métodos privados
     * basándose en el parámetro 'accion' de la petición.
     *
     * @param request El objeto HttpServletRequest que contiene la petición del cliente.
     * @param response El objeto HttpServletResponse que contiene la respuesta que se enviará al cliente.
     * @throws ServletException Si ocurre un error específico del servlet o un error lógico.
     * @throws IOException Si ocurre un error de entrada/salida.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar"; 
        }

        switch (accion) {
            case "listar":
                listarDetallePedidos(request, response);
                break;
            case "guardar":
                guardarDetallePedido(request, response);
                break;
            case "editar":
                editarDetallePedido(request, response);
                break;
            case "actualizar":
                actualizarDetallePedido(request, response);
                break;
            case "eliminar":
                eliminarDetallePedido(request, response);
                break;
            default:
                response.sendRedirect("ServletDetallePedido?accion=listar");
                break;
        }
    }

    /**
     * Maneja la lógica para listar todos los detalles de pedidos.
     * Obtiene la lista desde el DAO y la envía a la JSP.
     *
     * @param request El objeto HttpServletRequest.
     * @param response El objeto HttpServletResponse.
     * @throws ServletException Si ocurre un error del servlet.
     * @throws IOException Si ocurre un error de I/O.
     */
    private void listarDetallePedidos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<DetallePedido> listaDetallePedidos = detallePedidosDao.listarTodos();
        request.setAttribute("listaDetallePedidos", listaDetallePedidos);
        request.getRequestDispatcher("mantenimientoDetallePedido.jsp").forward(request, response);
    }

    /**
     * Maneja la lógica para guardar un nuevo detalle de pedido.
     * Recoge los parámetros, busca las FKs, crea el objeto y lo guarda.
     *
     * @param request El objeto HttpServletRequest.
     * @param response El objeto HttpServletResponse.
     * @throws ServletException Si ocurre un error (formato de número, FK no encontrada).
     * @throws IOException Si ocurre un error de I/O.
     */
    private void guardarDetallePedido(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int cantidadGuardar = Integer.parseInt(request.getParameter("cantidad"));
            BigDecimal precioGuardar = new BigDecimal(request.getParameter("precio"));
            BigDecimal subtotalGuardar = new BigDecimal(request.getParameter("subtotal"));

            int codigoPedidoGuardar = Integer.parseInt(request.getParameter("codigoPedido"));
            int codigoProductoGuardar = Integer.parseInt(request.getParameter("codigoProducto"));

            // ¡Ahora usamos el PedidoDAO real y el modelo Pedidos real!
            Pedidos pedidoFK = pedidoDao.buscarPorId(codigoPedidoGuardar);
            Producto productoFK = productoDao.buscarPorID(codigoProductoGuardar); // Se mantiene Producto

            if (pedidoFK == null) {
                throw new ServletException("Error al guardar: El Pedido con código " + codigoPedidoGuardar + " no existe.");
            }
            if (productoFK == null) {
                throw new ServletException("Error al guardar: El Producto con código " + codigoProductoGuardar + " no existe.");
            }

            // Asegúrate de que el constructor de DetallePedido acepte Pedidos y Producto
            DetallePedido nuevoDetalle = new DetallePedido(cantidadGuardar, precioGuardar, subtotalGuardar, pedidoFK, productoFK);
            detallePedidosDao.guardar(nuevoDetalle);

            response.sendRedirect("ServletDetallePedido?accion=listar");
        } catch (NumberFormatException e) {
            throw new ServletException("Error al guardar: Formato de número inválido. " + e.getMessage(), e);
        } catch (Exception e) {
            throw new ServletException("Error inesperado al guardar el detalle de pedido: " + e.getMessage(), e);
        }
    }

    /**
     * Maneja la lógica para cargar los datos de un detalle de pedido para edición.
     * Busca el detalle por ID y lo envía a la JSP del formulario de edición.
     *
     * @param request El objeto HttpServletRequest.
     * @param response El objeto HttpServletResponse.
     * @throws ServletException Si ocurre un error (ID inválido, detalle no encontrado).
     * @throws IOException Si ocurre un error de I/O.
     */
    private void editarDetallePedido(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idEditar = Integer.parseInt(request.getParameter("id"));
            DetallePedido detalleEditar = detallePedidosDao.buscarPorId(idEditar);

            if (detalleEditar != null) {
                request.setAttribute("detalleEditar", detalleEditar);
                request.getRequestDispatcher("formDetallePedidos.jsp").forward(request, response);
            } else {
                throw new ServletException("Detalle de Pedido con ID " + idEditar + " no encontrado para editar.");
            }
        } catch (NumberFormatException e) {
            throw new ServletException("Error al editar: Formato de ID inválido. " + e.getMessage(), e);
        } catch (Exception e) {
            throw new ServletException("Error inesperado al cargar detalle para edición: " + e.getMessage(), e);
        }
    }

    /**
     * Maneja la lógica para actualizar un detalle de pedido existente.
     * Recoge los parámetros, busca las FKs (si cambiaron), actualiza el objeto y lo guarda.
     *
     * @param request El objeto HttpServletRequest.
     * @param response El objeto HttpServletResponse.
     * @throws ServletException Si ocurre un error (formato de número, FK no encontrada, detalle no encontrado).
     * @throws IOException Si ocurre un error de I/O.
     */
    private void actualizarDetallePedido(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idActualizar = Integer.parseInt(request.getParameter("codigoDetallePedido"));
            DetallePedido detalleActualizar = detallePedidosDao.buscarPorId(idActualizar);

            if (detalleActualizar != null) {
                int cantidadActualizar = Integer.parseInt(request.getParameter("cantidad"));
                BigDecimal precioActualizar = new BigDecimal(request.getParameter("precio"));
                BigDecimal subtotalActualizar = new BigDecimal(request.getParameter("subtotal"));

                int codigoPedidoActualizar = Integer.parseInt(request.getParameter("codigoPedido"));
                int codigoProductoActualizar = Integer.parseInt(request.getParameter("codigoProducto"));

                detalleActualizar.setCantidad(cantidadActualizar);
                detalleActualizar.setPrecio(precioActualizar);
                detalleActualizar.setSubtotal(subtotalActualizar);

                // Actualizar las entidades relacionadas (llaves foráneas) si han cambiado
                // Ahora se espera que getPedido() devuelva un objeto Pedidos (plural)
                Pedidos pedidoActualizadoFK = detalleActualizar.getPedido();
                if (pedidoActualizadoFK == null || pedidoActualizadoFK.getCodigoPedido() != codigoPedidoActualizar) {
                    pedidoActualizadoFK = pedidoDao.buscarPorId(codigoPedidoActualizar);
                    if (pedidoActualizadoFK == null) {
                        throw new ServletException("Error al actualizar: El Pedido con código " + codigoPedidoActualizar + " no existe.");
                    }
                    detalleActualizar.setPedido(pedidoActualizadoFK);
                }

                Producto productoActualizadoFK = detalleActualizar.getProducto();
                if (productoActualizadoFK == null || productoActualizadoFK.getCodigoProducto() != codigoProductoActualizar) {
                    productoActualizadoFK = productoDao.buscarPorID(codigoProductoActualizar);
                    if (productoActualizadoFK == null) {
                        throw new ServletException("Error al actualizar: El Producto con código " + codigoProductoActualizar + " no existe.");
                    }
                    detalleActualizar.setProducto(productoActualizadoFK);
                }

                detallePedidosDao.Actualizar(detalleActualizar);
                response.sendRedirect("ServletDetallePedido?accion=listar");
            } else {
                throw new ServletException("Detalle de Pedido con ID " + idActualizar + " no encontrado para actualizar.");
            }
        } catch (NumberFormatException e) {
            throw new ServletException("Error al actualizar: Formato de número inválido. " + e.getMessage(), e);
        } catch (Exception e) {
            throw new ServletException("Error inesperado al actualizar el detalle de pedido: " + e.getMessage(), e);
        }
    }

    /**
     * Maneja la lógica para eliminar un detalle de pedido.
     * Elimina el detalle por ID y redirige a la lista.
     *
     * @param request El objeto HttpServletRequest.
     * @param response El objeto HttpServletResponse.
     * @throws ServletException Si ocurre un error (ID inválido).
     * @throws IOException Si ocurre un error de I/O.
     */
    private void eliminarDetallePedido(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idEliminar = Integer.parseInt(request.getParameter("id"));
            detallePedidosDao.Eliminar(idEliminar);
            response.sendRedirect("ServletDetallePedido?accion=listar");
        } catch (NumberFormatException e) {
            throw new ServletException("Error al eliminar: Formato de ID inválido. " + e.getMessage(), e);
        } catch (Exception e) {
            throw new ServletException("Error inesperado al eliminar el detalle de pedido: " + e.getMessage(), e);
        }
    }
 
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
    }
 
}
