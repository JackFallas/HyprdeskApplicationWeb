package dao;

import model.Producto;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;


/**
 *
 * @author JackFallas
 */

public class ProductoDAO {
    
    private EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("proyectoBimestralPU");
    
    public List<Producto> listarTodos() {
        String jpql = "SELECT c FROM Productos p";
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.createQuery(jpql, Producto.class).getResultList();
        } finally {
            admin.close();
        }
    }
    
    public void guardar(Producto producto) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        
        try {
            transaccion.begin();
            admin.persist(producto);
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive())  transaccion.rollback();
        } finally {
            admin.close();
        }
    }
    
    public Producto buscarPorID(int id) {
        EntityManager admin = fabrica.createEntityManager();
        try {
            return admin.find(Producto.class, id);
        } finally {
            admin.close();
        }
    }
    
    public void Actualizar (Producto producto) {
        EntityManager admin =  fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        
        try {
            transaccion.begin();
            admin.merge(producto);
            transaccion.commit();
        } catch (Exception e) {
            if(transaccion.isActive()) transaccion.rollback();
        } finally {
            admin.close();
        }
    }
    
    public void Eliminar (int id) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            Producto producto = admin.find(Producto.class, id);
            if (producto != null) {
                admin.remove(producto);                
            }
            transaccion.commit();
        } catch (Exception e) {
            if(transaccion.isActive()) transaccion.rollback();
        } finally {
            admin.close();
        }
    }
}
