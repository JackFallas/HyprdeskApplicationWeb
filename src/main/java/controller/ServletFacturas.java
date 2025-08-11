package controller;

import dao.FacturaDTO;
import dao.DetalleFacturaDTO;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import dao.PedidoDAO;

@WebServlet(name = "ServletFacturas", urlPatterns = {"/factura"})
public class ServletFacturas extends HttpServlet {

    private PedidoDAO facturaDTO = new PedidoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int codigoPedido = Integer.parseInt(request.getParameter("codigoPedido"));
            String formato = request.getParameter("formato"); // "html" o "pdf"
            
            FacturaDTO factura = facturaDTO.obtenerFacturaPorPedido(codigoPedido);

            if (factura == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Factura no encontrada");
                return;
            }

            if ("pdf".equalsIgnoreCase(formato)) {
                generarPDF(factura, response);
            } else {
                request.setAttribute("factura", factura);
                request.getRequestDispatcher("/factura.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetro inválido");
        } catch (Exception e) {
            throw new ServletException("Error generando factura", e);
        }
    }

    private void generarPDF(FacturaDTO factura, HttpServletResponse response) throws Exception {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=factura_" + factura.getCodigoPedido() + ".pdf");

        Document document = new Document();
        OutputStream out = response.getOutputStream();
        PdfWriter.getInstance(document, out);

        document.open();

        // Título
        Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
        document.add(new Paragraph("Factura N° " + factura.getCodigoPedido(), fontTitulo));
        document.add(new Paragraph("Fecha: " + factura.getFechaPedido()));
        document.add(Chunk.NEWLINE);

        // Datos cliente
        document.add(new Paragraph("Cliente: " + factura.getNombreUsuario() + " " + factura.getApellidoUsuario()));
        document.add(new Paragraph("Dirección: " + factura.getDireccionPedido()));
        document.add(new Paragraph("Email: " + factura.getEmail()));
        document.add(new Paragraph("Método de pago: " + factura.getMetodoPago()));
        document.add(Chunk.NEWLINE);

        // Tabla de productos
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{4, 1, 2, 2});
        table.addCell("Producto");
        table.addCell("Cantidad");
        table.addCell("Precio");
        table.addCell("Subtotal");

        for (DetalleFacturaDTO det : factura.getDetalles()) {
            table.addCell(det.getNombreProducto());
            table.addCell(String.valueOf(det.getCantidad()));
            table.addCell(det.getPrecio().toString());
            table.addCell(det.getSubtotal().toString());
        }

        // Total
        PdfPCell totalCell = new PdfPCell(new Phrase("Total: " + factura.getTotalPedido().toString()));
        totalCell.setColspan(4);
        totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(totalCell);

        document.add(table);
        document.close();
    }
}
