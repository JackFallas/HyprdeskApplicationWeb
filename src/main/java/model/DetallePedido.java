package model;

import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "DetallePedidos") // El nombre de la tabla en la DB es plural
public class DetallePedido { // El nombre de la clase es singular

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codigoDetallePedido")
    private int codigoDetallePedido;

    @Column(name = "cantidad", nullable = false)
    private int cantidad;

    @Column(name = "precio", columnDefinition = "decimal(10,2) default 0.00")
    private BigDecimal precio;

    @Column(name = "subtotal", columnDefinition = "decimal(10,2) default 0.00")
    private BigDecimal subtotal;

    // Relación ManyToOne con Pedidos
    @ManyToOne
    @JoinColumn(name = "codigoPedido", referencedColumnName = "codigoPedido")
    private Pedido pedido; // Tipo de dato: model.Pedidos (plural)

    // Relación ManyToOne con Producto
    @ManyToOne
    @JoinColumn(name = "codigoProducto", referencedColumnName = "codigoProducto")
    private Producto producto; // Tipo de dato: model.Producto (singular)

    public DetallePedido() {
    }

    public DetallePedido(int cantidad, BigDecimal precio, BigDecimal subtotal, Pedido pedido, Producto producto) {
        this.cantidad = cantidad;
        this.precio = precio;
        this.subtotal = subtotal;
        this.pedido = pedido;
        this.producto = producto;
    }

    // --- Getters y Setters ---
    public int getCodigoDetallePedido() {
        return codigoDetallePedido;
    }

    public void setCodigoDetallePedido(int codigoDetallePedido) {
        this.codigoDetallePedido = codigoDetallePedido;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }
}
