package dao;
 
import model.Pedidos;
import javax.persistence.*;
import java.util.List;
 
public class PedidoDAO {
    private EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("proyectoBimestralPU");
    // Guardar un nuevo pedido
    public void guardar(Pedidos pedidos) {
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
    public List<Pedidos> listarTodos() {
        String jpql = "SELECT p FROM Pedidos p";
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.createQuery(jpql, Pedidos.class).getResultList();
        } finally {
            admin.close();
        }
    }
 
    // Buscar un pedido por ID
    public Pedidos buscarPorId(int id) {
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.find(Pedidos.class, id);
        } finally {
            admin.close();
        }
    }
 
    // Actualizar un pedido existente
    public void Actualizar(Pedidos pedidos) {
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
            Pedidos pedidos = admin.find(Pedidos.class, id);
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