package dao;
 
import model.Pedido;
import javax.persistence.*;
import java.util.List;
 
public class PedidoDAO {
    private EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("proyectoBimestralPU");
    // Guardar un nuevo pedido
    public void guardar(Pedido pedidos) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            admin.persist(pedidos);
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) transaccion.rollback();
        } finally {
            admin.close();
        }
    }
 
    // Listar todos los pedidos
    public List<Pedido> listarTodos() {
        String jpql = "SELECT p FROM Pedido p";
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.createQuery(jpql, Pedido.class).getResultList();
        } finally {
            admin.close();
        }
    }
 
    // Buscar un pedido por ID
    public Pedido buscarPorId(int id) {
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.find(Pedido.class, id);
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
            if (transaccion.isActive()) transaccion.rollback();
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
            if (transaccion.isActive()) transaccion.rollback();
        } finally {
            admin.close();
        }
    }
}