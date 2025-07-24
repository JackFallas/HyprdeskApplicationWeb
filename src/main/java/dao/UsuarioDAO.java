package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
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
    
   public List<Usuarios> listarUsuarios(){
        return null;
    }
    
    public Usuarios buscarPorId(int id){
        return null;
    }
    
    public void actualizar(Usuarios usuario){
        
    }
    
    public void eliminar(int id){
        
    }
}
