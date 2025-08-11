package dao;

import java.util.ArrayList;
import java.util.Arrays;
import model.Pedido;
import javax.persistence.*;
import java.util.List;
import model.Recibo;

public class PedidoDAO {

    private EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    public void guardar(Pedido pedidos) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            admin.persist(pedidos);
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) {
                transaccion.rollback();
            }
        } finally {
            admin.close();
        }
    }

    public List<Pedido> listarTodos() {
        String jpql = "SELECT p FROM Pedido p";
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.createQuery(jpql, Pedido.class).getResultList();
        } finally {
            admin.close();
        }
    }

    public Pedido buscarPorId(int id) {
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.find(Pedido.class, id);
        } finally {
            admin.close();
        }
    }

    public List<Pedido> listarPorUsuario(int idUsuario) {
        String jpql = "SELECT p FROM Pedido p WHERE p.usuario.codigoUsuario = :idUsuario";
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.createQuery(jpql, Pedido.class)
                    .setParameter("idUsuario", idUsuario)
                    .getResultList();
        } finally {
            admin.close();
        }
    }

    // Actualizar un pedido existente
    public void Actualizar(Pedido pedidos) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            admin.merge(pedidos);
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) {
                transaccion.rollback();
            }
        } finally {
            admin.close();
        }
    }

    // Eliminar un pedido por ID
    public void Eliminar(int id) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            Pedido pedidos = admin.find(Pedido.class, id);
            if (pedidos != null) {
                admin.remove(pedidos);
            }
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) {
                transaccion.rollback();
            }
        } finally {
            admin.close();
        }
    }
    
    public void actualizarEstadoYReciboPedido(int codigoPedido, Pedido.EstadoPedido nuevoEstado, int codigoRecibo) {
    EntityManager admin = fabrica.createEntityManager();
    EntityTransaction transaccion = admin.getTransaction();
    try {
        transaccion.begin();
        Pedido pedido = admin.find(Pedido.class, codigoPedido);
        if (pedido != null) {
            pedido.setEstadoPedido(nuevoEstado);
            
            Recibo recibo = new Recibo();
            recibo.setCodigoRecibo(codigoRecibo);
            
            pedido.setRecibo(recibo);
            
            admin.merge(pedido);
        }
        transaccion.commit();
    } catch (Exception e) {
        if (transaccion.isActive()) {
            transaccion.rollback();
        }
        throw e;
    } finally {
        admin.close();
    }
}

    public Pedido buscarPedidoAbiertoPorUsuario(int idUsuario) {
        String jpql = "SELECT p FROM Pedido p WHERE p.usuario.codigoUsuario = :idUsuario AND p.estadoPedido IN :estados";
        EntityManager admin = fabrica.createEntityManager();
        try {
            List<Pedido.EstadoPedido> estadosAbiertos = Arrays.asList(
                    Pedido.EstadoPedido.En_proceso,
                    Pedido.EstadoPedido.Pendiente
            );

            List<Pedido> resultados = admin.createQuery(jpql, Pedido.class)
                    .setParameter("idUsuario", idUsuario)
                    .setParameter("estados", estadosAbiertos)
                    .getResultList();

            return resultados.isEmpty() ? null : resultados.get(0);
        } finally {
            admin.close();
        }
    }
    public FacturaDTO obtenerFacturaPorPedido(int codigoPedido) {
    EntityManager em = fabrica.createEntityManager();
    try {
        String sql = "SELECT p.codigoPedido, p.fechaPedido, u.nombreUsuario, u.apellidoUsuario, " +
            "p.direccionPedido, u.email, r.metodoPago, " +
            "pr.nombreProducto, dp.cantidad, dp.precio, dp.subtotal, " +
            "p.totalPedido " +
            "FROM Pedidos p " +
            "INNER JOIN Usuarios u ON p.codigoUsuario = u.codigoUsuario " +
            "INNER JOIN Recibos r ON p.codigoRecibo = r.codigoRecibo " +
            "INNER JOIN DetallePedidos dp ON p.codigoPedido = dp.codigoPedido " +
            "INNER JOIN Productos pr ON dp.codigoProducto = pr.codigoProducto " +
            "WHERE p.codigoPedido = :codigoPedido";

        @SuppressWarnings("unchecked")
        List<Object[]> results = em.createNativeQuery(sql)
            .setParameter("codigoPedido", codigoPedido)
            .getResultList();

        if (results.isEmpty()) {
            return null; // No existe ese pedido
        }

        FacturaDTO factura = null;
        List<DetalleFacturaDTO> detalles = new ArrayList<>();

        for (Object[] row : results) {
            if (factura == null) {
                factura = new FacturaDTO();
                factura.setCodigoPedido(((Number) row[0]).intValue());
                factura.setFechaPedido(((java.sql.Timestamp) row[1]).toLocalDateTime());
                factura.setNombreUsuario((String) row[2]);
                factura.setApellidoUsuario((String) row[3]);
                factura.setDireccionPedido((String) row[4]);
                factura.setEmail((String) row[5]);
                factura.setMetodoPago((String) row[6]);
                factura.setTotalPedido((java.math.BigDecimal) row[11]);
            }

            DetalleFacturaDTO det = new DetalleFacturaDTO();
            det.setNombreProducto((String) row[7]);
            det.setCantidad(((Number) row[8]).intValue());
            det.setPrecio((java.math.BigDecimal) row[9]);
            det.setSubtotal((java.math.BigDecimal) row[10]);
            detalles.add(det);
        }

        factura.setDetalles(detalles);
        return factura;

    } finally {
        em.close();
    }
}

}
