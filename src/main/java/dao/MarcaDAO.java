package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Marcas;


public class MarcaDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    public void guardar(Marcas marca) {
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

    public Marcas buscarPorId(int codigoMarca) {
        EntityManager em = emf.createEntityManager();
        Marcas marca = null;
        try {
            marca = em.find(Marcas.class, codigoMarca);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
        return marca;
    }

    public List<Marcas> listarMarcas() {
        EntityManager em = emf.createEntityManager();
        List<Marcas> listaMarcas = null;
        try {
            TypedQuery<Marcas> query = em.createQuery("SELECT m FROM Marcas m", Marcas.class);
            listaMarcas = query.getResultList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
        return listaMarcas;
    }

    public void actualizar(Marcas marca) {
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
            Marcas marca = em.find(Marcas.class, codigoMarca);
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
