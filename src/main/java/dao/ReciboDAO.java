package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Recibo;

public class ReciboDAO {

    private final EntityManagerFactory emf = Persistence.createEntityManagerFactory("proyectoBimestralPU");

    public void guardar(Recibo recibo) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(recibo);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al guardar el recibo: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }

    public Recibo buscarPorId(int codigoRecibo) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Recibo.class, codigoRecibo);
        } finally {
            em.close();
        }
    }

    public List<Recibo> listarTodos() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Recibo> query = em.createQuery("SELECT r FROM Recibo r", Recibo.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Recibo> listarPorUsuario(int codigoUsuario) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Recibo> query = em.createQuery("SELECT r FROM Recibo r WHERE r.codigoUsuario = :codigoUsuario", Recibo.class);
            query.setParameter("codigoUsuario", codigoUsuario);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void actualizar(Recibo recibo) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(recibo);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al actualizar el recibo: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }

    public void eliminar(int codigoRecibo) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Recibo recibo = em.find(Recibo.class, codigoRecibo);
            if (recibo != null) {
                em.remove(recibo);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error al eliminar el recibo: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }
}