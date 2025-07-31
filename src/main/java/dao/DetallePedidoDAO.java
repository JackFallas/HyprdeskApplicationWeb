package dao;

import model.DetallePedido; // Importa el modelo DetallePedido (singular)
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import java.util.List;

public class DetallePedidoDAO { // ¡Asegúrate de que el nombre de la clase sea exactamente este!

    private EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    public void guardar(DetallePedido detallePedido) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            admin.persist(detallePedido);
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) {
                transaccion.rollback();
            }
            System.err.println("Error al guardar DetallePedido: " + e.getMessage());
        } finally {
            admin.close();
        }
    }

    public List<DetallePedido> listarTodos() {
        String jpql = "SELECT dp FROM DetallePedido dp"; // JPQL para la entidad singular
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.createQuery(jpql, DetallePedido.class).getResultList();
        } finally {
            admin.close();
        }
    }

    public DetallePedido buscarPorId(int id) { // Método con 'Id' en minúsculas
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.find(DetallePedido.class, id);
        } finally {
            admin.close();
        }
    }

    public void Actualizar(DetallePedido detallePedido) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            admin.merge(detallePedido);
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) {
                transaccion.rollback();
            }
            System.err.println("Error al actualizar DetallePedido: " + e.getMessage());
        } finally {
            admin.close();
        }
    }

    public void Eliminar(int id) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            DetallePedido detallePedido = admin.find(DetallePedido.class, id);
            if (detallePedido != null) {
                admin.remove(detallePedido);
            }
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) {
                transaccion.rollback();
            }
            System.err.println("Error al eliminar DetallePedido: " + e.getMessage());
        } finally {
            admin.close();
        }
    }
}
