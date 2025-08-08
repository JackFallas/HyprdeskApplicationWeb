package model;
 
import java.time.LocalDate;
import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
 
@Entity
@Table (name ="Usuarios")
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codigoUsuario;
    @Column (name ="nombreUsuario", nullable = false)
    private String nombreUsuario;
    @Column (name ="apellidoUsuario", nullable = false)
    private String apellidoUsuario;
    @Column (name ="telefono", nullable = false)
    private String telefono;
    @Column (name ="direccionUsuario", nullable = false)
    private String direccionUsuario;
    @Column (name ="email", nullable = false)
    private String email;
    @Column (name ="contrasena", nullable = false)
    private String contrasena;
    @Column (name = "estadoUsuario")
    private String estadoUsuario;
    @Column (name = "rol")
    private String rol;
    @Column(name = "fechaCreacion", insertable = false, updatable = false)
    private Timestamp fechaCreacion;
    @Column (name = "fechaNacimiento")
    private LocalDate fechaNacimiento;
    public Usuario() {
    }
 
    public Usuario(String nombreUsuario, String apellidoUsuario, String telefono, String direccionUsuario, String email, String contrasena, String estadoUsuario, String rol, LocalDate fechaNacimiento) {
        this.nombreUsuario = nombreUsuario;
        this.apellidoUsuario = apellidoUsuario;
        this.telefono = telefono;
        this.direccionUsuario = direccionUsuario;
        this.email = email;
        this.contrasena = contrasena;
        this.estadoUsuario = estadoUsuario;
        this.rol = rol;
        this.fechaNacimiento = fechaNacimiento;
    }
 
    public Usuario(String nombreUsuario, String apellidoUsuario, String telefono, String direccionUsuario, String email, String contrasena) {
        this.nombreUsuario = nombreUsuario;
        this.apellidoUsuario = apellidoUsuario;
        this.telefono = telefono;
        this.direccionUsuario = direccionUsuario;
        this.email = email;
        this.contrasena = contrasena;
    }
    public String getContrasena() {
        return contrasena;
    }
 
    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
 
    public int getCodigoUsuario() {
        return codigoUsuario;
    }
 
    public void setCodigoUsuario(int codigoUsuario) {
        this.codigoUsuario = codigoUsuario;
    }
 
    public String getNombreUsuario() {
        return nombreUsuario;
    }
 
    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }
 
    public String getApellidoUsuario() {
        return apellidoUsuario;
    }
 
    public void setApellidoUsuario(String apellidoUsuario) {
        this.apellidoUsuario = apellidoUsuario;
    }
 
    public String getTelefono() {
        return telefono;
    }
 
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
 
    public String getDireccionUsuario() {
        return direccionUsuario;
    }
 
    public void setDireccionUsuario(String direccionUsuario) {
        this.direccionUsuario = direccionUsuario;
    }
 
    public String getEmail() {
        return email;
    }
 
    public void setEmail(String email) {
        this.email = email;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
 
    public String getEstadoUsuario() {
        return estadoUsuario;
    }
 
    public void setEstadoUsuario(String estadoUsuario) {
        this.estadoUsuario = estadoUsuario;
    }
 
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }
 
    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
 
    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }
 
    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
}