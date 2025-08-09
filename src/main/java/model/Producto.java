package model;

import java.sql.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Jack Fallas
 */

@Entity
@Table (name = "Productos")
public class Producto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codigoProducto;

    @Column(name = "nombreProducto", nullable = false)
    private String nombre;

    @Column(name = "descripcionProducto", nullable = false)
    private String descripcion;

    @Column(name = "precioProducto", nullable = false)
    private double precio;

    @Column(name = "stock", nullable = false)
    private int stock;

    @Column(name = "fechaEntrada", updatable = false)
    private Date fechaEntrada;

    @Column(name = "fechaSalida", updatable = false)
    private Date fechaSalida;

    // Relaciones
    @ManyToOne
    @JoinColumn(name = "codigoMarca", referencedColumnName = "codigoMarca")
    private Marca marca;

    @ManyToOne
    @JoinColumn(name = "codigoCategoria", referencedColumnName = "codigoCategoria")
    private Categoria categoria;

    public Producto() {
    }

    public Producto(String nombre, String descripcion, double precio, int stock, Date fechaEntrada, Date fechaSalida, Marca marca, Categoria categoria) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.fechaEntrada = fechaEntrada;
        this.fechaSalida = fechaSalida;
        this.marca = marca;
        this.categoria = categoria;
    }

    public int getCodigoProducto() {
        return codigoProducto;
    }

    public void setCodigoProducto(int codigoProducto) {
        this.codigoProducto = codigoProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Date getFechaEntrada() {
        return fechaEntrada;
    }

    public void setFechaEntrada(Date fechaEntrada) {
        this.fechaEntrada = fechaEntrada;
    }

    public Date getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(Date fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public Marca getMarca() {
        return marca;
    }

    public void setMarca(Marca marca) {
        this.marca = marca;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }
}

