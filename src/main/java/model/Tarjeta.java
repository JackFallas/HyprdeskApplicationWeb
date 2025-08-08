package model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "Tarjetas")
public class Tarjeta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codigoTarjeta;

    @Column(name = "codigoUsuario", nullable = false)
    private int codigoUsuario;

    @Column(name = "ultimos_4", nullable = false, length = 4)
    private String ultimos4;

    @Column(name = "marca", nullable = false, columnDefinition = "ENUM('Visa', 'MasterCard', 'Amex', 'Discover', 'Otro')")
    private String marca;

    @Column(name = "token", nullable = false, length = 36)
    private String token;

    @Temporal(TemporalType.DATE)
    @Column(name = "fechaExpiracion", nullable = false)
    private Date fechaExpiracion;

    @Column(name = "nombreTitular", nullable = false, length = 40)
    private String nombreTitular;

    @Column(name = "tipoTarjeta", columnDefinition = "ENUM('Crédito', 'Débito', 'Prepago') DEFAULT 'Crédito'")
    private String tipoTarjeta;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "fechaRegistro", nullable = false, insertable = false, updatable = false, columnDefinition = "DATETIME DEFAULT CURRENT_TIMESTAMP")
    private Date fechaRegistro;

    public Tarjeta() {
    }

    public Tarjeta(int codigoUsuario, String ultimos4, String marca, String token, Date fechaExpiracion, String nombreTitular, String tipoTarjeta) {
        this.codigoUsuario = codigoUsuario;
        this.ultimos4 = ultimos4;
        this.marca = marca;
        this.token = token;
        this.fechaExpiracion = fechaExpiracion;
        this.nombreTitular = nombreTitular;
        this.tipoTarjeta = tipoTarjeta;
    }

    public Tarjeta(int codigoTarjeta, int codigoUsuario, String ultimos4, String marca, String token, Date fechaExpiracion, String nombreTitular, String tipoTarjeta) {
        this.codigoTarjeta = codigoTarjeta;
        this.codigoUsuario = codigoUsuario;
        this.ultimos4 = ultimos4;
        this.marca = marca;
        this.token = token;
        this.fechaExpiracion = fechaExpiracion;
        this.nombreTitular = nombreTitular;
        this.tipoTarjeta = tipoTarjeta;
    }

    public int getCodigoTarjeta() {
        return codigoTarjeta;
    }

    public void setCodigoTarjeta(int codigoTarjeta) {
        this.codigoTarjeta = codigoTarjeta;
    }

    public int getCodigoUsuario() {
        return codigoUsuario;
    }

    public void setCodigoUsuario(int codigoUsuario) {
        this.codigoUsuario = codigoUsuario;
    }

    public String getUltimos4() {
        return ultimos4;
    }

    public void setUltimos4(String ultimos4) {
        this.ultimos4 = ultimos4;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getFechaExpiracion() {
        return fechaExpiracion;
    }

    public void setFechaExpiracion(Date fechaExpiracion) {
        this.fechaExpiracion = fechaExpiracion;
    }

    public String getNombreTitular() {
        return nombreTitular;
    }

    public void setNombreTitular(String nombreTitular) {
        this.nombreTitular = nombreTitular;
    }

    public String getTipoTarjeta() {
        return tipoTarjeta;
    }

    public void setTipoTarjeta(String tipoTarjeta) {
        this.tipoTarjeta = tipoTarjeta;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    @Override
    public String toString() {
        return "Tarjetas{" + "codigoTarjeta=" + codigoTarjeta + ", codigoUsuario=" + codigoUsuario + ", ultimos4=" + ultimos4 + ", marca=" + marca + ", token=" + token + ", fechaExpiracion=" + fechaExpiracion + ", nombreTitular=" + nombreTitular + ", tipoTarjeta=" + tipoTarjeta + ", fechaRegistro=" + fechaRegistro + '}';
    }
}