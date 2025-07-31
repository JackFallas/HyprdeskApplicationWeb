package controller;

import dao.TarjetaDAO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Tarjetas;

@WebServlet("/ServletTarjetas")
public class ServletTarjetas extends HttpServlet {

    private TarjetaDAO tarjetaDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.tarjetaDAO = new TarjetaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listarTodas"; 
        }

        switch (accion) {
            case "listarTodas": 
                listarTodasLasTarjetas(request, response);
                break;
            case "eliminar":
                eliminarTarjeta(request, response);
                break;
           
            default:
                listarTodasLasTarjetas(request, response); 
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        switch (accion) {
            case "insertar":
                insertarTarjeta(request, response);
                break;
            case "actualizar":
                actualizarTarjeta(request, response); 
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    private void listarTodasLasTarjetas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Tarjetas> listaTarjetas = tarjetaDAO.listarTodas(); 
            request.setAttribute("listaTarjetas", listaTarjetas);
            request.getRequestDispatcher("tarjetas.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar todas las tarjetas: " + e.getMessage());
            request.getRequestDispatcher("tarjetas.jsp").forward(request, response);
        }
    }

    private void listarTarjetasPorUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoUsuario = Integer.parseInt(request.getParameter("codigoUsuario"));
            List<Tarjetas> listaTarjetas = tarjetaDAO.listarPorUsuario(codigoUsuario);
            request.setAttribute("listaTarjetas", listaTarjetas);
            request.setAttribute("codigoUsuario", codigoUsuario); 
            request.getRequestDispatcher("tarjetas.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Código de usuario inválido.");
            request.getRequestDispatcher("tarjetas.jsp").forward(request, response);
        }
    }
    private void insertarTarjeta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int codigoUsuario = 0; 
        try {
            String codigoUsuarioStr = request.getParameter("codigoUsuario");
            if (codigoUsuarioStr != null && !codigoUsuarioStr.isEmpty()) {
                codigoUsuario = Integer.parseInt(codigoUsuarioStr);
            } else {
                request.setAttribute("error", "El código de usuario es obligatorio para insertar una tarjeta.");
                listarTodasLasTarjetas(request, response); 
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Código de usuario inválido al insertar la tarjeta.");
            listarTodasLasTarjetas(request, response);
            return;
        }


        try {
            String ultimos4 = request.getParameter("ultimos4");
            String marca = request.getParameter("marca");
            String token = request.getParameter("token");
            String nombreTitular = request.getParameter("nombreTitular");
            String tipoTarjeta = request.getParameter("tipoTarjeta");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaExpiracion = sdf.parse(request.getParameter("fechaExpiracion"));

            Tarjetas nuevaTarjeta = new Tarjetas(codigoUsuario, ultimos4, marca, token, fechaExpiracion, nombreTitular, tipoTarjeta);
            tarjetaDAO.guardar(nuevaTarjeta);

            response.sendRedirect("TarjetaController?accion=listarTodas&success=true"); 
        } catch (ParseException e) {
            request.setAttribute("error", "El formato de la fecha de expiración es incorrecto. Use AAAA-MM-DD.");
            listarTodasLasTarjetas(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al guardar la tarjeta: " + e.getMessage());
            listarTodasLasTarjetas(request, response);
        }
    }
    private void actualizarTarjeta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int codigoUsuario = 0; 
        try {
            String codigoUsuarioStr = request.getParameter("codigoUsuario");
            if (codigoUsuarioStr != null && !codigoUsuarioStr.isEmpty()) {
                codigoUsuario = Integer.parseInt(codigoUsuarioStr);
            } else {
                request.setAttribute("error", "El código de usuario es obligatorio para actualizar una tarjeta.");
                listarTodasLasTarjetas(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Código de usuario inválido al actualizar la tarjeta.");
            listarTodasLasTarjetas(request, response);
            return;
        }

        try {
            int codigoTarjeta = Integer.parseInt(request.getParameter("codigoTarjeta"));
            String ultimos4 = request.getParameter("ultimos4");
            String marca = request.getParameter("marca");
            String token = request.getParameter("token");
            String nombreTitular = request.getParameter("nombreTitular");
            String tipoTarjeta = request.getParameter("tipoTarjeta");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaExpiracion = sdf.parse(request.getParameter("fechaExpiracion"));

            Tarjetas tarjetaActualizar = new Tarjetas(codigoTarjeta, codigoUsuario, ultimos4, marca, token, fechaExpiracion, nombreTitular, tipoTarjeta);
            tarjetaDAO.actualizar(tarjetaActualizar);

            response.sendRedirect("TarjetaController?accion=listarTodas&success=true"); 

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de tarjeta inválido para actualizar.");
            listarTodasLasTarjetas(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "El formato de la fecha de expiración es incorrecto al actualizar. Use AAAA-MM-DD.");
            listarTodasLasTarjetas(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar la tarjeta: " + e.getMessage());
            listarTodasLasTarjetas(request, response);
        }
    }

    private void eliminarTarjeta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoTarjeta = Integer.parseInt(request.getParameter("id"));
            tarjetaDAO.eliminar(codigoTarjeta);
            response.sendRedirect("TarjetaController?accion=listarTodas&deleted=true");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de tarjeta inválido.");
            listarTodasLasTarjetas(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar la tarjeta: " + e.getMessage());
            listarTodasLasTarjetas(request, response);
        }
    }
}