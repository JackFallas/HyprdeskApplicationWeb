package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Tarjeta;

public class TarjetaDAO {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    public void guardar(Tarjeta tarjeta) {
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

    public Tarjeta buscarPorId(int codigoTarjeta) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Tarjeta.class, codigoTarjeta);
        } finally {
            em.close();
        }
    }

    public List<Tarjeta> listarTodas() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Tarjeta> query = em.createQuery("SELECT t FROM Tarjetas t", Tarjeta.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Tarjeta> listarPorUsuario(int codigoUsuario) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Tarjeta> query = em.createQuery("SELECT t FROM Tarjetas t WHERE t.codigoUsuario = :codigoUsuario", Tarjeta.class);
            query.setParameter("codigoUsuario", codigoUsuario);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void actualizar(Tarjeta tarjeta) {
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
            Tarjeta tarjeta = em.find(Tarjeta.class, codigoTarjeta);
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