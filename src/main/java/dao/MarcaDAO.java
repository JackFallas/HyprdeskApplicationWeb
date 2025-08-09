package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Marca;


public class MarcaDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    public void guardar(Marca marca) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(marca);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al guardar la marca: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }

    public Marca buscarPorId(int codigoMarca) {
        EntityManager em = emf.createEntityManager();
        Marca marca = null;
        try {
            marca = em.find(Marca.class, codigoMarca);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
        return marca;
    }

    public List<Marca> listarMarcas() {
        EntityManager em = emf.createEntityManager();
        List<Marca> listaMarcas = null;
        try {
            TypedQuery<Marca> query = em.createQuery("SELECT m FROM Marca m", Marca.class);
            listaMarcas = query.getResultList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
        return listaMarcas;
    }

    public void actualizar(Marca marca) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(marca);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al actualizar la marca: " + e.getMessage());
            throw e;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public void eliminar(int codigoMarca) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Marca marca = em.find(Marca.class, codigoMarca);
            if (marca != null) {
                em.remove(marca);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al eliminar la marca: " + e.getMessage());
            throw e;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
