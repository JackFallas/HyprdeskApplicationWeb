package controller;

import dao.TarjetaDAO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Tarjeta;

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
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listarTarjetas(request, response);
                break;
            case "eliminar":
                eliminarTarjeta(request, response);
                break;
            default:
                listarTarjetas(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        switch (accion) {
            case "insertar":
                insertarTarjeta(request, response);
                break;
            case "actualizar":
                actualizarTarjeta(request, response);
                break;
            default:
                listarTarjetas(request, response);
                break;
        }
    }

    private void listarTarjetas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Tarjeta> listaTarjetas = tarjetaDAO.listarTodas();
            request.setAttribute("listaTarjetas", listaTarjetas);
            request.getRequestDispatcher("mantenimientoTarjetas.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar las tarjetas: " + e.getMessage());
            request.getRequestDispatcher("mantenimientoTarjetas.jsp").forward(request, response);
        }
    }

    private void insertarTarjeta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoUsuario = Integer.parseInt(request.getParameter("codigoUsuario"));
            String ultimos4 = request.getParameter("ultimos4");
            String marca = request.getParameter("marca");
            String nombreTitular = request.getParameter("nombreTitular");
            String tipoTarjeta = request.getParameter("tipoTarjeta");
            String fechaExpStr = request.getParameter("fechaExpiracion");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaExpiracion = sdf.parse(fechaExpStr);
            
            // Generar un token único para la tarjeta
            String token = UUID.randomUUID().toString();

            Tarjeta nuevaTarjeta = new Tarjeta(codigoUsuario, ultimos4, marca, token, fechaExpiracion, nombreTitular, tipoTarjeta);
            tarjetaDAO.guardar(nuevaTarjeta);

            response.sendRedirect("ServletTarjetas?accion=listar&success=true");
        } catch (ParseException | NumberFormatException e) {
            request.setAttribute("error", "Datos inválidos. Verifique el formato de los números y fechas.");
            listarTarjetas(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al guardar la tarjeta: " + e.getMessage());
            listarTarjetas(request, response);
        }
    }

    private void actualizarTarjeta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoTarjeta = Integer.parseInt(request.getParameter("codigoTarjeta"));
            int codigoUsuario = Integer.parseInt(request.getParameter("codigoUsuario"));
            String ultimos4 = request.getParameter("ultimos4");
            String marca = request.getParameter("marca");
            String nombreTitular = request.getParameter("nombreTitular");
            String tipoTarjeta = request.getParameter("tipoTarjeta");
            String fechaExpStr = request.getParameter("fechaExpiracion");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaExpiracion = sdf.parse(fechaExpStr);
            
            // Al actualizar, mantenemos el token original
            Tarjeta tarjetaExistente = tarjetaDAO.buscarPorId(codigoTarjeta);
            if(tarjetaExistente == null){
                throw new Exception("No se encontró la tarjeta con el código " + codigoTarjeta);
            }
            String token = tarjetaExistente.getToken();

            Tarjeta tarjetaActualizar = new Tarjeta(codigoTarjeta, codigoUsuario, ultimos4, marca, token, fechaExpiracion, nombreTitular, tipoTarjeta);
            tarjetaDAO.actualizar(tarjetaActualizar);

            response.sendRedirect("ServletTarjetas?accion=listar&success=true");
        } catch (ParseException | NumberFormatException e) {
            request.setAttribute("error", "Datos inválidos para actualizar. Verifique el formato de los números y fechas.");
            listarTarjetas(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar la tarjeta: " + e.getMessage());
            listarTarjetas(request, response);
        }
    }

    private void eliminarTarjeta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int codigoTarjeta = Integer.parseInt(request.getParameter("id"));
            tarjetaDAO.eliminar(codigoTarjeta);
            response.sendRedirect("ServletTarjetas?accion=listar&deleted=true");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de tarjeta inválido.");
            listarTarjetas(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al eliminar la tarjeta: " + e.getMessage());
            listarTarjetas(request, response);
        }
    }
}