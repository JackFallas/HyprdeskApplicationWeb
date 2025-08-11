package controller;

import dao.DetallePedidoDAO;
import dao.PedidoDAO;
import dao.ProductoDAO;
import dao.ReciboDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DetallePedido;
import model.Pedido;
import model.Producto;
import model.Recibo;

@WebServlet("/ServletRecibos")
public class ServletRecibos extends HttpServlet {

    private ReciboDAO reciboDAO;
    private PedidoDAO pedidoDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.reciboDAO = new ReciboDAO();
        this.pedidoDAO = new PedidoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listarPorUsuarioLogueado";
        }

        switch (accion) {
            case "listarTodos":
                listarTodosLosRecibos(request, response);
                break;
            case "listarPorUsuarioLogueado":
                listarTodosLosRecibos(request, response);
                break;
            case "eliminar":
                eliminarRecibo(request, response);
                break;
            case "listarPorUsuario":
                listarRecibosPorUsuario(request, response);
                break;
            default:
                listarTodosLosRecibos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            response.sendRedirect("ServletRecibos?accion=listar");
            return;
        }

        switch (accion) {
            case "insertar":
                insertarRecibo(request, response);
                break;
            case "actualizar":
                actualizarRecibo(request, response);
                break;
            case "finalizarCompra":
                finalizarCompra(request, response);
                break;
            default:
                response.sendRedirect("ServletRecibos?accion=listar");
                break;
        }
    }

    private void finalizarCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Integer idUsuario = (Integer) session.getAttribute("idUsuario");

            if (idUsuario == null) {
                request.setAttribute("error", "Usuario no logueado.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            Integer codigoTarjeta = null;
            String codigoTarjetaStr = request.getParameter("codigoTarjeta");
            if (codigoTarjetaStr != null && !codigoTarjetaStr.trim().isEmpty()) {
                codigoTarjeta = Integer.parseInt(codigoTarjetaStr);
            }

            BigDecimal monto = new BigDecimal(request.getParameter("monto"));
            String metodoPago = request.getParameter("metodoPago");

            Recibo nuevoRecibo = new Recibo(monto, metodoPago, idUsuario, codigoTarjeta);
            reciboDAO.guardar(nuevoRecibo);

            int codigoPedido = Integer.parseInt(request.getParameter("codigoPedido"));
            int codigoReciboGenerado = nuevoRecibo.getCodigoRecibo();

            String direccionPedido = request.getParameter("direccionPedido");

            Pedido pedido = pedidoDAO.buscarPorId(codigoPedido);
            pedido.setEstadoPedido(Pedido.EstadoPedido.Entregado);
            pedido.setDireccionPedido(direccionPedido);

            Recibo recibo = new Recibo();
            recibo.setCodigoRecibo(codigoReciboGenerado);
            pedido.setRecibo(recibo);

            pedidoDAO.Actualizar(pedido);

            // --- Aquí restamos el stock de cada producto según la cantidad comprada ---
            DetallePedidoDAO detalleDAO = new DetallePedidoDAO();
            ProductoDAO productoDAO = new ProductoDAO();

            List<DetallePedido> detalles = detalleDAO.listarPorPedido(codigoPedido);

            for (DetallePedido detalle : detalles) {
                Producto producto = productoDAO.buscarPorID(detalle.getProducto().getCodigoProducto());
                int nuevoStock = producto.getStock() - detalle.getCantidad();
                if (nuevoStock < 0) {
                    nuevoStock = 0; // evitar stock negativo, o lanzar excepción si quieres validar
                }
                producto.setStock(nuevoStock);
                productoDAO.Actualizar(producto);
            }
            // -------------------------------------------------------------------------

            response.sendRedirect("ServletRecibos?accion=listar");
        } catch (Exception e) {
            request.setAttribute("error", "Error al finalizar la compra: " + e.getMessage());
            request.getRequestDispatcher("mantenimientoPedidos.jsp").forward(request, response);
        }
    }

    private void listarTodosLosRecibos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("idUsuario");

        if (idUsuario == null) {
            request.setAttribute("error", "Usuario no logueado.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            List<Recibo> listaRecibos = reciboDAO.listarPorUsuario(idUsuario);
            request.setAttribute("listaRecibos", listaRecibos);
            request.getRequestDispatcher("mantenimientoRecibos.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar los recibos: " + e.getMessage());
            request.getRequestDispatcher("mantenimientoRecibos.jsp").forward(request, response);
        }
    }

    private void listarRecibosPorUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoUsuario = Integer.parseInt(request.getParameter("codigoUsuario"));
            List<Recibo> listaRecibos = reciboDAO.listarPorUsuario(codigoUsuario);
            request.setAttribute("listaRecibos", listaRecibos);
            request.setAttribute("codigoUsuario", codigoUsuario);
            request.getRequestDispatcher("mantenimientoRecibos.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Código de usuario inválido.");
            listarTodosLosRecibos(request, response);
        }
    }

    private void insertarRecibo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Se asume que el codigoUsuario y codigoTarjeta se pasan como parámetros
            Integer codigoUsuario = null;
            String codigoUsuarioStr = request.getParameter("codigoUsuario");
            if (codigoUsuarioStr != null && !codigoUsuarioStr.trim().isEmpty()) {
                codigoUsuario = Integer.parseInt(codigoUsuarioStr);
            }

            Integer codigoTarjeta = null;
            String codigoTarjetaStr = request.getParameter("codigoTarjeta");
            if (codigoTarjetaStr != null && !codigoTarjetaStr.trim().isEmpty()) {
                codigoTarjeta = Integer.parseInt(codigoTarjetaStr);
            }

            BigDecimal monto = new BigDecimal(request.getParameter("monto"));
            String metodoPago = request.getParameter("metodoPago");

            Recibo nuevoRecibo = new Recibo(monto, metodoPago, codigoUsuario, codigoTarjeta);
            reciboDAO.guardar(nuevoRecibo);

            response.sendRedirect("ServletRecibos?accion=listarTodos&success=true");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Formato de número incorrecto para el monto o códigos de usuario/tarjeta.");
            listarTodosLosRecibos(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al guardar el recibo: " + e.getMessage());
            listarTodosLosRecibos(request, response);
        }
    }

    private void actualizarRecibo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoRecibo = Integer.parseInt(request.getParameter("codigoRecibo"));

            Integer codigoUsuario = null;
            String codigoUsuarioStr = request.getParameter("codigoUsuario");
            if (codigoUsuarioStr != null && !codigoUsuarioStr.trim().isEmpty()) {
                codigoUsuario = Integer.parseInt(codigoUsuarioStr);
            }

            Integer codigoTarjeta = null;
            String codigoTarjetaStr = request.getParameter("codigoTarjeta");
            if (codigoTarjetaStr != null && !codigoTarjetaStr.trim().isEmpty()) {
                codigoTarjeta = Integer.parseInt(codigoTarjetaStr);
            }

            BigDecimal monto = new BigDecimal(request.getParameter("monto"));
            String metodoPago = request.getParameter("metodoPago");

            Recibo reciboActualizar = new Recibo(codigoRecibo, monto, metodoPago, codigoUsuario, codigoTarjeta);
            reciboDAO.actualizar(reciboActualizar);

            response.sendRedirect("ServletRecibos?accion=listarTodos&success=true");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de recibo, monto, o códigos de usuario/tarjeta inválidos para actualizar.");
            listarTodosLosRecibos(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar el recibo: " + e.getMessage());
            listarTodosLosRecibos(request, response);
        }
    }

    private void eliminarRecibo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoRecibo = Integer.parseInt(request.getParameter("id"));
            reciboDAO.eliminar(codigoRecibo);
            response.sendRedirect("ServletRecibos?accion=listarTodos&deleted=true");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de recibo inválido.");
            listarTodosLosRecibos(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar el recibo: " + e.getMessage());
            listarTodosLosRecibos(request, response);
        }
    }
}