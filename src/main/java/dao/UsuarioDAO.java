package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Usuarios;

public class UsuarioDAO {
    private EntityManagerFactory enti = Persistence.createEntityManagerFactory("proyectoBimestralPU");
    
    public void guardar(Usuarios usuario){
        EntityManager en = enti.createEntityManager();
        try{
            en.getTransaction().begin();
            en.persist(usuario);
            en.getTransaction().commit();
        } finally {
            en.close();
        }
    }
    
    public Usuarios buscarPorEmail(String email) {
        EntityManager en = enti.createEntityManager();
        Usuarios usuario = null;
        try {
            TypedQuery<Usuarios> query = en.createQuery("SELECT u FROM Usuarios u WHERE u.email = :email", Usuarios.class);
            query.setParameter("email", email);
            usuario = query.getSingleResult(); 
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            System.err.println("Error al buscar usuario por email: " + e.getMessage());
        } finally {
            if (en != null && en.isOpen()) {
                en.close();
            }
        }
        return usuario;
    }
    
    public Usuarios validarCredenciales(String email, String contraseña) {
        Usuarios usuario = buscarPorEmail(email);
        if (usuario != null && usuario.getContrasena().equals(contraseña)) {
            return usuario; 
        }
        return null; 
    }
    
    public boolean erorEmail(String email) {
        EntityManager en = enti.createEntityManager();
        try {
            Long count = en.createQuery("select count(u) from Usuarios u where u.email = :email", Long.class)
                           .setParameter("email", email)
                           .getSingleResult();
            return count > 0;
        } finally {
            en.close();
        }
    }
    
   public List<Usuarios> listarUsuarios(){
        String jpql = "SELECT u FROM Usuarios u";
        EntityManager admin = enti.createEntityManager();
        try{
            return admin.createQuery(jpql, Usuarios.class).getResultList();
        }finally{
            admin.close();
        }
    }
    
    public Usuarios buscarPorId(int id){
        EntityManager admin = enti.createEntityManager();
        try{
            return admin.find(Usuarios.class, id);
        }finally {
         admin.close();
        }
    }
    
    public void actualizar(Usuarios usuario){
        EntityManager admin = enti.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        
        try {
            transaccion.begin();
            admin.merge(usuario);
            transaccion.commit();
        } catch (Exception e) {
            if(transaccion.isActive()) transaccion.rollback();
        }finally{
            admin.close();
        }
    }
    
    public void eliminar(int id){
        EntityManager admin = enti.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        try {
            transaccion.begin();
            Usuarios usuarios = admin.find(Usuarios.class, id);
            if (usuarios != null) {
                admin.remove(usuarios);
            }
            transaccion.commit();
        } catch (Exception e) {
            if(transaccion.isActive()) transaccion.rollback();
        }finally{
            admin.close();
        }
    }
}
