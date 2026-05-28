package com.willperu.tiendavirtual.model;

import com.willperu.tiendavirtual.enums.EstadoPedido;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "historial_estado_pedido")
public class HistorialEstadoPedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private EstadoPedido estado;

    private LocalDateTime fecha;

    @ManyToOne
    @JoinColumn(name = "venta_id")
    private Venta venta;

    public HistorialEstadoPedido() {
        this.fecha = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public EstadoPedido getEstado() {
        return estado;
    }

    public void setEstado(EstadoPedido estado) {
        this.estado = estado;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

    public Venta getVenta() {
        return venta;
    }

    public void setVenta(Venta venta) {
        this.venta = venta;
    }
}