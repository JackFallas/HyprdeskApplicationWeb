package controller;

import dao.PedidoDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Pedido;
import model.Pedido.EstadoPedido;
import model.Recibo;
import model.Usuario;

@WebServlet(name = "ServletPedidos", urlPatterns = {"/ServletPedidos"})
public class ServletPedidos extends HttpServlet {

    private final PedidoDAO pedidoDAO = new PedidoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion == null || accion.isEmpty()) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
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

        if (accion == null || accion.isEmpty()) {
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
        request.setAttribute("listaPedidos", listaPedidos);
        request.getRequestDispatcher("mantenimientoPedidos.jsp").forward(request, response);
    }

    private void insertarPedido(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Obtener y convertir los parámetros del formulario
            String fechaPedidoStr = request.getParameter("fechaPedido");
            String estadoPedidoStr = request.getParameter("estadoPedido");
            String totalPedidoStr = request.getParameter("totalPedido");
            String direccionPedido = request.getParameter("direccionPedido");
            String codigoReciboStr = request.getParameter("codigoRecibo");
            String codigoUsuarioStr = request.getParameter("codigoUsuario");

            // Crear los objetos a partir de los datos del formulario
            LocalDateTime fechaPedido = LocalDateTime.parse(fechaPedidoStr);
            EstadoPedido estadoPedido = EstadoPedido.valueOf(estadoPedidoStr.replace(" ", "_")); // Maneja el espacio en "En proceso"
            BigDecimal totalPedido = new BigDecimal(totalPedidoStr);

            // Crear entidades Recibo y Usuario para el mapeo de relaciones
            // Nota: En una aplicación real, deberías cargar estas entidades desde la base de datos
            // usando sus IDs para asegurar que existan.
            Recibo recibo = new Recibo();
            recibo.setCodigoRecibo(Integer.parseInt(codigoReciboStr));
            Usuario usuario = new Usuario();
            usuario.setCodigoUsuario(Integer.parseInt(codigoUsuarioStr));

            // Crear el objeto Pedido con los tipos de datos y objetos correctos
            Pedido nuevoPedido = new Pedido(fechaPedido, estadoPedido, totalPedido, direccionPedido, recibo, usuario);
            pedidoDAO.guardar(nuevoPedido);

            // Redirigir a la página de listado de pedidos después de una inserción exitosa
            response.sendRedirect(request.getContextPath() + "/ServletPedidos?accion=listar");

        } catch (DateTimeParseException | NumberFormatException e) {
            // Capturar errores específicos de formato de datos
            System.err.println("Error al insertar pedido. Datos inválidos: " + e.getMessage());
            // Redirigir a la página de listado en caso de error
            response.sendRedirect(request.getContextPath() + "/ServletPedidos?accion=listar&error=formato");
        }
    }

    private void actualizarPedido(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String codigoPedidoStr = request.getParameter("codigoPedido");
            if (codigoPedidoStr == null || codigoPedidoStr.isEmpty()) {
                throw new IllegalArgumentException("El código del pedido es obligatorio para la actualización.");
            }
            int codigoPedido = Integer.parseInt(codigoPedidoStr);

            // Buscar el pedido existente en la base de datos
            Pedido pedidoExistente = pedidoDAO.buscarPorId(codigoPedido);

            if (pedidoExistente != null) {
                // Obtener y validar los nuevos datos del formulario
                String fechaPedidoStr = request.getParameter("fechaPedido");
                String estadoPedidoStr = request.getParameter("estadoPedido");
                String totalPedidoStr = request.getParameter("totalPedido");
                String direccionPedido = request.getParameter("direccionPedido");
                String codigoReciboStr = request.getParameter("codigoRecibo");
                String codigoUsuarioStr = request.getParameter("codigoUsuario");

                if (fechaPedidoStr == null || estadoPedidoStr == null || totalPedidoStr == null || direccionPedido == null || codigoReciboStr == null || codigoUsuarioStr == null) {
                    throw new IllegalArgumentException("Todos los campos del formulario son obligatorios.");
                }

                // Convertir los datos a los tipos correctos
                // Se usa BigDecimal para precisión monetaria
                BigDecimal totalPedido = new BigDecimal(totalPedidoStr);

                // Reemplazar el espacio en el String del enum para que coincida con el enum de Java
                EstadoPedido estadoPedido = EstadoPedido.valueOf(estadoPedidoStr.replace(" ", "_"));

                // Crear instancias de las entidades relacionadas (Recibo y Usuario)
                // Nota: En un escenario real, se deberían buscar estas entidades en la DB
                // para asegurar que existen antes de asignarlas al pedido.
                Recibo recibo = new Recibo();
                recibo.setCodigoRecibo(Integer.parseInt(codigoReciboStr));
                Usuario usuario = new Usuario();
                usuario.setCodigoUsuario(Integer.parseInt(codigoUsuarioStr));

                // Actualizar los campos del pedido existente
                pedidoExistente.setFechaPedido(LocalDateTime.parse(fechaPedidoStr));
                pedidoExistente.setEstadoPedido(estadoPedido);
                pedidoExistente.setTotalPedido(totalPedido);
                pedidoExistente.setDireccionPedido(direccionPedido);
                pedidoExistente.setRecibo(recibo);
                pedidoExistente.setUsuario(usuario);

                // Guardar los cambios
                pedidoDAO.Actualizar(pedidoExistente);

                response.sendRedirect(request.getContextPath() + "/ServletPedidos?success=true");
            } else {
                request.setAttribute("error", "Pedido no encontrado para actualizar.");
                listarPedidos(request, response);
            }
        } catch (DateTimeParseException | IllegalArgumentException e) {
            // Capturar errores de formato de fecha o de argumentos inválidos (incluye NumberFormatException)
            request.setAttribute("error", "Error al actualizar pedido: " + e.getMessage());
            listarPedidos(request, response);
        } catch (Exception e) {
            // Capturar cualquier otro error inesperado
            request.setAttribute("error", "Error inesperado al actualizar pedido: " + e.getMessage());
            listarPedidos(request, response);
        }
    }

    private void eliminarPedido(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String codigoPedidoStr = request.getParameter("id");
            if (codigoPedidoStr == null || codigoPedidoStr.isEmpty()) {
                throw new IllegalArgumentException("El ID del pedido es nulo o vacío.");
            }
            int codigoPedido = Integer.parseInt(codigoPedidoStr);

            pedidoDAO.Eliminar(codigoPedido);
            response.sendRedirect(request.getContextPath() + "/ServletPedidos?deleted=true");
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar pedido: " + e.getMessage());
            listarPedidos(request, response);
        }
    }
}
