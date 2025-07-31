package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Tarjetas;

public class TarjetaDAO {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    public void guardar(Tarjetas tarjeta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(tarjeta);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al guardar la tarjeta: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }

    public Tarjetas buscarPorId(int codigoTarjeta) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Tarjetas.class, codigoTarjeta);
        } finally {
            em.close();
        }
    }

    public List<Tarjetas> listarTodas() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Tarjetas> query = em.createQuery("SELECT t FROM Tarjetas t", Tarjetas.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Tarjetas> listarPorUsuario(int codigoUsuario) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Tarjetas> query = em.createQuery("SELECT t FROM Tarjetas t WHERE t.codigoUsuario = :codigoUsuario", Tarjetas.class);
            query.setParameter("codigoUsuario", codigoUsuario);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void actualizar(Tarjetas tarjeta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(tarjeta);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al actualizar la tarjeta: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }

    public void eliminar(int codigoTarjeta) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Tarjetas tarjeta = em.find(Tarjetas.class, codigoTarjeta);
            if (tarjeta != null) {
                em.remove(tarjeta);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al eliminar la tarjeta: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }
}