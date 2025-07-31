package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Marcas")
public class Marcas {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codigoMarca;

    @Column(name = "nombreMarca", nullable = false, length = 64)
    private String nombreMarca;

    @Column(name = "descripcion", nullable = false, length = 128)
    private String descripcion;

    @Column(name = "estadoMarca", nullable = false, columnDefinition = "ENUM('Disponible', 'No disponible') DEFAULT 'Disponible'")
    private String estadoMarca;

    public Marcas() {
    }

    public Marcas(String nombreMarca, String descripcion, String estadoMarca) {
        this.nombreMarca = nombreMarca;
        this.descripcion = descripcion;
        this.estadoMarca = estadoMarca;
    }

    public int getCodigoMarca() {
        return codigoMarca;
    }

    public void setCodigoMarca(int codigoMarca) {
        this.codigoMarca = codigoMarca;
    }

    public String getNombreMarca() {
        return nombreMarca;
    }

    public void setNombreMarca(String nombreMarca) {
        this.nombreMarca = nombreMarca;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstadoMarca() {
        return estadoMarca;
    }

    public void setEstadoMarca(String estadoMarca) {
        this.estadoMarca = estadoMarca;
    }

    @Override
    public String toString() {
        return "Marcas{" + "codigoMarca=" + codigoMarca + ", nombreMarca=" + nombreMarca + ", descripcion=" + descripcion + ", estadoMarca=" + estadoMarca + '}';
    }
}
