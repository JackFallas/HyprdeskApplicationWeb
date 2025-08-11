package controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Usuario;
import model.Marca;
import model.Categoria;
import model.Producto;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;

@WebServlet(name = "ServletReportes", urlPatterns = {"/ServletReportes"})
public class ServletReportes extends HttpServlet {

    // Se crea la EntityManagerFactory una sola vez, ya que es un recurso pesado.
    private static final EntityManagerFactory EMF = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String nombreReporte = request.getParameter("nombre");

        try {
            if ("usuarios".equals(nombreReporte)) {
                generarReporte(response, "ReporteUsuarios.jasper", Usuario.class, "SELECT u FROM Usuario u", "reporte_usuarios.pdf");
            } else if ("marcas".equals(nombreReporte)) {
                generarReporte(response, "ReporteMarcas.jasper", Marca.class, "SELECT m FROM Marca m", "reporte_marcas.pdf");
            } else if ("categorias".equals(nombreReporte)) {
                generarReporte(response, "ReporteCategorias.jasper", Categoria.class, "SELECT c FROM Categoria c", "reporte_categorias.pdf");
            } else if ("productos".equals(nombreReporte)) {
                generarReporte(response, "ReporteProductos.jasper", Producto.class, "SELECT p FROM Producto p", "reporte_productos.pdf");
            } else {
                response.getWriter().write("Reporte no válido.");
            }
        } catch (JRException e) {
            e.printStackTrace();
            response.getWriter().write("Error al generar el reporte: " + e.getMessage());
        }
    }

    private <T> void generarReporte(HttpServletResponse response, String jasperFile, Class<T> entityClass, String queryString, String pdfFileName) 
            throws JRException, IOException {

        EntityManager em = EMF.createEntityManager();
        
        try {
            // Se realiza la consulta usando el EntityManager creado manualmente
            List<T> datos = em.createQuery(queryString, entityClass).getResultList();
            
            InputStream jasperStream = this.getClass().getResourceAsStream("/reports/" + jasperFile);
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(jasperStream);
            
            JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(datos);
            
            Map<String, Object> parametros = new HashMap<>();
            
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parametros, dataSource);
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + pdfFileName + "\"");
            
            OutputStream out = response.getOutputStream();
            JasperExportManager.exportReportToPdfStream(jasperPrint, out);
            out.flush();
        } finally {
            // Es crucial cerrar el EntityManager en el bloque finally
            if (em != null) {
                em.close();
            }
        }
    }
}