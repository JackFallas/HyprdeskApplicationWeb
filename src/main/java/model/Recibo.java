package model;

import java.io.Serializable;
import java.math.BigDecimal;
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
@Table(name = "Recibos")
public class Recibo implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codigoRecibo")
    private int codigoRecibo;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "fechaPago", nullable = false, insertable = false, updatable = false, columnDefinition = "DATETIME DEFAULT CURRENT_TIMESTAMP")
    private Date fechaPago;

    @Column(name = "monto", nullable = false, precision = 10, scale = 2)
    private BigDecimal monto;

    @Column(name = "metodoPago", nullable = false, length = 64)
    private String metodoPago;

    @Column(name = "codigoUsuario")
    private Integer codigoUsuario;

    @Column(name = "codigoTarjeta")
    private Integer codigoTarjeta;

    public Recibo() {
    }

    public Recibo(BigDecimal monto, String metodoPago, Integer codigoUsuario, Integer codigoTarjeta) {
        this.monto = monto;
        this.metodoPago = metodoPago;
        this.codigoUsuario = codigoUsuario;
        this.codigoTarjeta = codigoTarjeta;
    }

    public Recibo(int codigoRecibo, Date fechaPago, BigDecimal monto, String metodoPago, Integer codigoUsuario, Integer codigoTarjeta) {
        this.codigoRecibo = codigoRecibo;
        this.fechaPago = fechaPago;
        this.monto = monto;
        this.metodoPago = metodoPago;
        this.codigoUsuario = codigoUsuario;
        this.codigoTarjeta = codigoTarjeta;
    }
    
    // Constructor para insertar y actualizar
    public Recibo(int codigoRecibo, BigDecimal monto, String metodoPago, Integer codigoUsuario, Integer codigoTarjeta) {
        this.codigoRecibo = codigoRecibo;
        this.monto = monto;
        this.metodoPago = metodoPago;
        this.codigoUsuario = codigoUsuario;
        this.codigoTarjeta = codigoTarjeta;
    }

    public int getCodigoRecibo() {
        return codigoRecibo;
    }

    public void setCodigoRecibo(int codigoRecibo) {
        this.codigoRecibo = codigoRecibo;
    }

    public Date getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(Date fechaPago) {
        this.fechaPago = fechaPago;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public Integer getCodigoUsuario() {
        return codigoUsuario;
    }

    public void setCodigoUsuario(Integer codigoUsuario) {
        this.codigoUsuario = codigoUsuario;
    }

    public Integer getCodigoTarjeta() {
        return codigoTarjeta;
    }

    public void setCodigoTarjeta(Integer codigoTarjeta) {
        this.codigoTarjeta = codigoTarjeta;
    }

    @Override
    public String toString() {
        return "Recibo{" + "codigoRecibo=" + codigoRecibo + ", fechaPago=" + fechaPago + ", monto=" + monto + ", metodoPago=" + metodoPago + ", codigoUsuario=" + codigoUsuario + ", codigoTarjeta=" + codigoTarjeta + '}';
    }
}
