package model;
 
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
 
/**
* Clase que representa un pedido.
* Contiene información sobre el pedido, incluyendo estado, fecha, total, etc.
* 
* @author informatica
*/
 
@Entity
@Table(name = "Pedidos")
public class Pedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codigoPedido;
    @Column(name = "fechaPedido", nullable = false)
    private LocalDateTime fechaPedido;
    @Column(name = "estadoPedido", nullable = false)
    private EstadoPedido estadoPedido;
    @Column(name = "totalPedido", nullable = false)
    private Double totalPedido;
    @Column(name = "direccionPedido", nullable = false)
    private String direccionPedido;
    @Column(name = "codigoRecibo", nullable = false)
    private int codigoRecibo;
    @Column(name = "codigoUsuario", nullable = false)
    private int codigoUsuario;
    
    public enum EstadoPedido {
        Pendiente,
        En_proceso,
        Enviado,
        Entragado,
        Cancelado
    }
    public Pedido(LocalDateTime fechaPedido1, EstadoPedido estadoPedido1, Double totalPedido1, String direccionPedido1, int codigoPedido1, int codigoUsuario1) {
    }
 
    public Pedido(int codigoPedido, LocalDateTime fechaPedido, EstadoPedido estadoPedido, 
                   Double totalPedido, String direccionPedido, int codigoRecibo, int codigoUsuario) {
        this.codigoPedido = codigoPedido;
        this.fechaPedido = fechaPedido;
        this.estadoPedido = estadoPedido;
        this.totalPedido = totalPedido;
        this.direccionPedido = direccionPedido;
        this.codigoRecibo = codigoRecibo;
        this.codigoUsuario = codigoUsuario;
    }
    public int getCodigoPedido() {
        return codigoPedido;
    }
    public void setCodigoPedido(int codigoPedido) {
        this.codigoPedido = codigoPedido;
    }
    public LocalDateTime getFechaPedido() {
        return fechaPedido;
    }
 
    public void setFechaPedido(LocalDateTime fechaPedido) {
        this.fechaPedido = fechaPedido;
    }
 
    public EstadoPedido getEstadoPedido() {
        return estadoPedido;
    }
 
    public void setEstadoPedido(EstadoPedido estadoPedido) {
        this.estadoPedido = estadoPedido;
    }
 
    public Double getTotalPedido() {
        return totalPedido;
    }
 
    public void setTotalPedido(Double totalPedido) {
        this.totalPedido = totalPedido;
    }
 
    public String getDireccionPedido() {
        return direccionPedido;
    }
 
    public void setDireccionPedido(String direccionPedido) {
        this.direccionPedido = direccionPedido;
    }
 
    public int getCodigoRecibo() {
        return codigoRecibo;
    }
 
    public void setCodigoRecibo(int codigoRecibo) {
        this.codigoRecibo = codigoRecibo;
    }
 
    public int getCodigoUsuario() {
        return codigoUsuario;
    }
 
    public void setCodigoUsuario(int codigoUsuario) {
        this.codigoUsuario = codigoUsuario;
    }
 
    @Override
    public String toString() {
        return "Pedido{" +
               ", fechaPedido=" + fechaPedido +
               ", estadoPedido=" + estadoPedido +
               ", totalPedido=" + totalPedido +
               ", direccionPedido='" + direccionPedido + '\'' +
               ", codigoRecibo=" + codigoRecibo +
               ", codigoUsuario=" + codigoUsuario +
               '}';
    }
}