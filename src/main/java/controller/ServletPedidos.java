package controller;

import dao.PedidoDAO;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Pedido;
import model.Pedido.EstadoPedido;

@WebServlet("/ServletPedidos")
public class ServletPedidos extends HttpServlet {

    private PedidoDAO pedidoDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        pedidoDAO = new PedidoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listarPedidos(request, response);
                break;
            case "editar":
                listarPedidos(request, response);
                break;
            case "eliminar":
                eliminarPedido(request, response);
                break;
            default:
                listarPedidos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion == null) {
            accion = "insertar";
        }

        switch (accion) {
            case "insertar":
                insertarPedido(request, response);
                break;
            case "actualizar":
                actualizarPedido(request, response);
                break;
            default:
                listarPedidos(request, response);
                break;
        }
    }

    private void listarPedidos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Pedido> listaPedidos = pedidoDAO.listarTodos();
        request.setAttribute("listaMarcas", listaPedidos);
        request.getRequestDispatcher("pedidos.jsp").forward(request, response);
    }

    private void insertarPedido(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        LocalDateTime fechaPedido = LocalDateTime.parse(request.getParameter("fechaPedido"));
        EstadoPedido estadoPedido = EstadoPedido.valueOf(request.getParameter("estadoPedido")); // Asumiendo que EstadoPedido es un enum
        Double totalPedido = Double.parseDouble(request.getParameter("totalPedido"));
        String direccionPedido = request.getParameter("direccionPedido");
        int codigoPedido = Integer.parseInt(request.getParameter("codigoPedido"));
        int codigoUsuario = Integer.parseInt(request.getParameter("codigoUsuario"));

        // Crear un nuevo objeto Pedido
        Pedido nuevoPedido = new Pedido(fechaPedido, estadoPedido, totalPedido, direccionPedido, codigoPedido, codigoUsuario);

        try {
            pedidoDAO.guardar(nuevoPedido);
            response.sendRedirect("ServletPedidos?success=true");
        } catch (Exception e) {
            request.setAttribute("error", "Error al insertar pedido: " + e.getMessage());
            listarPedidos(request, response);
        }
    }

    private void actualizarPedido(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int codigoPedido = Integer.parseInt(request.getParameter("codigoPedido"));
        LocalDateTime fechaPedido = LocalDateTime.parse(request.getParameter("fechaPedido"));
        EstadoPedido estadoPedido = EstadoPedido.valueOf(request.getParameter("estadoPedido"));
        Double totalPedido = Double.parseDouble(request.getParameter("totalPedido"));
        String direccionPedido = request.getParameter("direccionPedido");
        int codigoRecibo = Integer.parseInt(request.getParameter("codigoRecibo"));
        int codigoUsuario = Integer.parseInt(request.getParameter("codigoUsuario"));

        Pedido pedidoExistente = pedidoDAO.buscarPorId(codigoPedido);

        if (pedidoExistente != null) {
         
            pedidoExistente.setFechaPedido(fechaPedido);
            pedidoExistente.setEstadoPedido(estadoPedido);
            pedidoExistente.setTotalPedido(totalPedido);
            pedidoExistente.setDireccionPedido(direccionPedido);
            pedidoExistente.setCodigoRecibo(codigoRecibo);
            pedidoExistente.setCodigoUsuario(codigoUsuario);

            try {
                pedidoDAO.Actualizar(pedidoExistente);
                response.sendRedirect("ServletPedidos?success=true");
            } catch (Exception e) {
                request.setAttribute("error", "Error al actualizar pedido: " + e.getMessage());
                listarPedidos(request, response);
            }
        } else {
            request.setAttribute("error", "Pedido no encontrado para actualizar.");
            listarPedidos(request, response);
        }
    }

    private void eliminarPedido(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int codigoPedido = Integer.parseInt(request.getParameter("id"));

        try {
            pedidoDAO.Eliminar(codigoPedido);
            response.sendRedirect("ServletPedido?deleted=true");
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar pedido: " + e.getMessage());
            listarPedidos(request, response);
        }
    }
}
