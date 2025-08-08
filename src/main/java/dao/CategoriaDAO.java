package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import model.Categoria;

public class CategoriaDAO {
    // servicio de transacciones y acceso a datos
    // Data Acceso Object - DTA -> Data Transaction Object
    //EMF -> UP -> conexion al DB = libreriaPU
    //EMF -> EM -> Entity Transaction
    //ET -> begin | prodceso || commit || close

    private EntityManagerFactory fabrica = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    public void guardar(Categoria categoria) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        
        try {
            transaccion.begin();
            admin.persist(categoria);
            transaccion.commit();
        } catch (Exception e) {
            if (transaccion.isActive()) transaccion.rollback(); 
            e.printStackTrace();
        }finally{
            admin.close();
        }
    }

    public List<Categoria> listarTodos() {
        String jpql = "SELECT c FROM Categorias c";
        EntityManager admin = fabrica.createEntityManager();
        try{
            //getResultList()->SQL = resultSet
            return admin.createQuery(jpql, Categoria.class).getResultList();
        }finally{
            admin.close();
        }
    }

    public Categoria buscarPorId(int id) {
        EntityManager admin = fabrica.createEntityManager();
        try{
            return admin.find(Categoria.class, id);
        }finally {
         admin.close();
        }
    }

    public void Actualizar(Categoria categoria) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        
        try {
            transaccion.begin();
            admin.merge(categoria);
            transaccion.commit();
        } catch (Exception e) {
            if(transaccion.isActive()) transaccion.rollback();
            e.printStackTrace();
        }finally{
            admin.close();
        }
        
    }

    public void Eliminar(int id) {
        EntityManager admin = fabrica.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            Categoria categoria = admin.find(Categoria.class, id);
            if (categoria != null) {
                admin.remove(categoria);
            }
            transaccion.commit();
        } catch (Exception e) {
            if(transaccion.isActive()) transaccion.rollback();
            e.printStackTrace();
        }finally{
            admin.close();
        }
    }
}
