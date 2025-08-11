package controller; // Asegúrate de que este archivo esté en la carpeta 'controller' de tu proyecto

import dao.DetallePedidoDAO; // Tu DAO para DetallePedido (singular)
import model.DetallePedido;  // Tu modelo para DetallePedido (singular)
import model.Pedido;        // ¡Tu modelo real para Pedidos (plural)!
import model.Producto;       // Tu modelo para Producto (asumiendo singular, sin cambios)
import dao.PedidoDAO;        // ¡Tu DAO real para Pedido (singular, opera en Pedidos)!
import dao.ProductoDAO;      // Tu DAO para Producto (asumiendo singular, sin cambios)

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Usuario;

/**
 * Servlet centralizado para la gestión de DetallePedido.
 * Maneja operaciones de listar, agregar, editar y eliminar detalles de pedido
 * utilizando métodos separados para cada acción.
 */
@WebServlet(name = "ServletDetallePedido", urlPatterns = {"/ServletDetallePedido"})
public class ServletDetallePedidos extends HttpServlet {

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
    // Obtener sesión y atributos de rol e idUsuario
    HttpSession session = request.getSession();
    String rol = (String) session.getAttribute("rol");
    Integer idUsuario = (Integer) session.getAttribute("idUsuario");

    List<DetallePedido> listaDetallePedidos;

    if ("Admin".equalsIgnoreCase(rol)) {
        // Admin ve todos
        listaDetallePedidos = detallePedidosDao.listarTodos();
    } else {
        // Usuario ve solo sus detalles
        listaDetallePedidos = detallePedidosDao.listarPorUsuario(idUsuario);
    }

    request.setAttribute("listaDetallePedidos", listaDetallePedidos);
    request.setAttribute("rol", rol);
    request.getRequestDispatcher("mantenimientoDetallePedidos.jsp").forward(request, response);
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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("idUsuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int idUsuario = (Integer) session.getAttribute("idUsuario");

        // Datos del producto y subtotal antes de crear pedido
        int cantidadGuardar = Integer.parseInt(request.getParameter("cantidad"));
        BigDecimal precioGuardar = new BigDecimal(request.getParameter("precio"));
        BigDecimal subtotalGuardar = precioGuardar.multiply(BigDecimal.valueOf(cantidadGuardar));
        int codigoProductoGuardar = Integer.parseInt(request.getParameter("codigoProducto"));

        Producto productoFK = productoDao.buscarPorID(codigoProductoGuardar);
        if (productoFK == null) {
            throw new ServletException("Error: Producto con código " + codigoProductoGuardar + " no existe.");
        }

        // Buscar pedido abierto
        Pedido pedidoAbierto = pedidoDao.buscarPedidoAbiertoPorUsuario(idUsuario);
        if (pedidoAbierto == null) {
            pedidoAbierto = new Pedido();
            pedidoAbierto.setUsuario(new Usuario());
            pedidoAbierto.getUsuario().setCodigoUsuario(idUsuario);
            pedidoAbierto.setEstadoPedido(Pedido.EstadoPedido.En_proceso);
            pedidoAbierto.setFechaPedido(LocalDateTime.now());
            pedidoAbierto.setDireccionPedido("Sin especificar aun");
            pedidoAbierto.setRecibo(null);
            pedidoAbierto.setTotalPedido(subtotalGuardar); // 🚀 primer producto define el total inicial
            pedidoDao.guardar(pedidoAbierto);
        } else {
            // Si ya existe, sumar el subtotal
            pedidoAbierto.setTotalPedido(pedidoAbierto.getTotalPedido().add(subtotalGuardar));
            pedidoDao.Actualizar(pedidoAbierto);
        }

        // Crear el detalle
        DetallePedido nuevoDetalle = new DetallePedido(
                cantidadGuardar,
                precioGuardar,
                subtotalGuardar,
                pedidoAbierto,
                productoFK
        );
        detallePedidosDao.guardar(nuevoDetalle);

        response.sendRedirect("ServletProducto?accion=listar");

    } catch (NumberFormatException e) {
        throw new ServletException("Error al guardar: Formato de número inválido. " + e.getMessage(), e);
    } catch (Exception e) {
        throw new ServletException("Error inesperado al guardar el detalle de pedido: " + e.getMessage(), e);
    }
}

    private void editarDetallePedido(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idEditar = Integer.parseInt(request.getParameter("id"));
            DetallePedido detalleEditar = detallePedidosDao.buscarPorId(idEditar);

            if (detalleEditar != null) {
                request.setAttribute("detalleEditar", detalleEditar);
                request.getRequestDispatcher("mantenimientoDetallePedidos.jsp").forward(request, response);
            } else {
                throw new ServletException("Detalle de Pedido con ID " + idEditar + " no encontrado para editar.");
            }
        } catch (NumberFormatException e) {
            throw new ServletException("Error al editar: Formato de ID inválido. " + e.getMessage(), e);
        } catch (Exception e) {
            throw new ServletException("Error inesperado al cargar detalle para edición: " + e.getMessage(), e);
        }
    }

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

                Pedido pedidoActualizadoFK = detalleActualizar.getPedido();
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
        return "Short description";
    }
 
}
