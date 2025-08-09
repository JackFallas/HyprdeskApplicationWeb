package controller;

import dao.ReciboDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Recibo;

@WebServlet("/ServletRecibos")
public class ServletRecibos extends HttpServlet {

    private ReciboDAO reciboDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.reciboDAO = new ReciboDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listarTodos";
        }

        switch (accion) {
            case "listarTodos":
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
            response.sendRedirect("mantenimientoRecibos.jsp");
            return;
        }

        switch (accion) {
            case "insertar":
                insertarRecibo(request, response);
                break;
            case "actualizar":
                actualizarRecibo(request, response);
                break;
            default:
                response.sendRedirect("mantenimientoRecibos.jsp");
                break;
        }
    }

    private void listarTodosLosRecibos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Recibo> listaRecibos = reciboDAO.listarTodos();
            request.setAttribute("listaRecibos", listaRecibos);
            request.getRequestDispatcher("mantenimientoRecibos.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar todos los recibos: " + e.getMessage());
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
