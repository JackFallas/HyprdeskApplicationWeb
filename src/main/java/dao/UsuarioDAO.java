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
