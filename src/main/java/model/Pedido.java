package model;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.math.BigDecimal;

/**
 * Clase que representa un pedido.
 * Mapea a la tabla 'Pedidos' en la base de datos.
 * * @author informatica
 */
@Entity
@Table(name = "Pedidos")
public class Pedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codigoPedido;

    @Column(name = "fechaPedido", nullable = false)
    private LocalDateTime fechaPedido;

    // Se utiliza EnumType.STRING para mapear el enum a la cadena de texto en la base de datos
    @Enumerated(EnumType.STRING)
    @Column(name = "estadoPedido", nullable = false, length = 64)
    private EstadoPedido estadoPedido;

    @Column(name = "totalPedido", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalPedido;

    @Column(name = "direccionPedido", nullable = false, length = 128)
    private String direccionPedido;

    // Mapeo de la clave foránea a la entidad Recibo
    @ManyToOne
    @JoinColumn(name = "codigoRecibo", referencedColumnName = "codigoRecibo")
    private Recibo recibo;

    // Mapeo de la clave foránea a la entidad Usuario
    @ManyToOne
    @JoinColumn(name = "codigoUsuario", referencedColumnName = "codigoUsuario")
    private Usuario usuario;

    // La constante del enum debe coincidir con el valor de la base de datos
    public enum EstadoPedido {
        Pendiente,
        En_proceso,
        Enviado,
        Entregado,
        Cancelado
    }

    public Pedido() {
    }

    public Pedido(LocalDateTime fechaPedido, EstadoPedido estadoPedido,
                  BigDecimal totalPedido, String direccionPedido, Recibo recibo, Usuario usuario) {
        this.fechaPedido = fechaPedido;
        this.estadoPedido = estadoPedido;
        this.totalPedido = totalPedido;
        this.direccionPedido = direccionPedido;
        this.recibo = recibo;
        this.usuario = usuario;
    }

    // Getters y setters para todos los campos

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

    public BigDecimal getTotalPedido() {
        return totalPedido;
    }

    public void setTotalPedido(BigDecimal totalPedido) {
        this.totalPedido = totalPedido;
    }

    public String getDireccionPedido() {
        return direccionPedido;
    }

    public void setDireccionPedido(String direccionPedido) {
        this.direccionPedido = direccionPedido;
    }

    public Recibo getRecibo() {
        return recibo;
    }

    public void setRecibo(Recibo recibo) {
        this.recibo = recibo;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public String toString() {
        return "Pedido{" +
                "codigoPedido=" + codigoPedido +
                ", fechaPedido=" + fechaPedido +
                ", estadoPedido=" + estadoPedido +
                ", totalPedido=" + totalPedido +
                ", direccionPedido='" + direccionPedido + '\'' +
                ", recibo=" + (recibo != null ? recibo.getCodigoRecibo() : "null") +
                ", usuario=" + (usuario != null ? usuario.getCodigoUsuario() : "null") +
                '}';
    }
}
