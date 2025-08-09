package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import model.Usuario;

public class UsuarioDAO {
    private EntityManagerFactory enti = Persistence.createEntityManagerFactory("proyectoBimestralPU");
    
    public void guardar(Usuario usuario){
        EntityManager en = enti.createEntityManager();
        try{
            en.getTransaction().begin();
            en.persist(usuario);
            en.getTransaction().commit();
        } finally {
            en.close();
        }
    }
    
    public Usuario buscarPorEmail(String email) {
        EntityManager en = enti.createEntityManager();
        Usuario usuario = null;
        try {
            TypedQuery<Usuario> query = en.createQuery("SELECT u FROM Usuario u WHERE u.email = :email", Usuario.class);
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
    
    public Usuario validarCredenciales(String email, String contraseña) {
        Usuario usuario = buscarPorEmail(email);
        if (usuario != null && usuario.getContrasena().equals(contraseña)) {
            return usuario; 
        }
        return null; 
    }
    
    public boolean erorEmail(String email) {
        EntityManager en = enti.createEntityManager();
        try {
            Long count = en.createQuery("select count(u) from Usuario u where u.email = :email", Long.class)
                           .setParameter("email", email)
                           .getSingleResult();
            return count > 0;
        } finally {
            en.close();
        }
    }
    
   public List<Usuario> listarUsuarios(){
        String jpql = "SELECT u FROM Usuario u";
        EntityManager admin = enti.createEntityManager();
        try{
            return admin.createQuery(jpql, Usuario.class).getResultList();
        }finally{
            admin.close();
        }
    }
    
    public Usuario buscarPorId(int id){
        EntityManager admin = enti.createEntityManager();
        try{
            return admin.find(Usuario.class, id);
        }finally {
           admin.close();
        }
    }
    
    public void actualizar(Usuario usuario){
        EntityManager admin = enti.createEntityManager();
        EntityTransaction transaccion = admin.getTransaction();
        
        try {
            transaccion.begin();
            admin.merge(usuario);
            transaccion.commit();
        } catch (Exception e) {
            if(transaccion.isActive()) transaccion.rollback();
            System.err.println("Error al actualizar usuario: " + e.getMessage()); 
        }finally{
            admin.close();
        }
    }
    
    
}
