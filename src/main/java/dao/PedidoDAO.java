package dao;

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
}
