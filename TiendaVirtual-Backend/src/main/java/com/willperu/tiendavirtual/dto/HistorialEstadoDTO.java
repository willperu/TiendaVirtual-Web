package com.willperu.tiendavirtual.dto;

import java.time.LocalDateTime;

public class HistorialEstadoDTO {

    private String estado;
    private LocalDateTime fecha;

    public HistorialEstadoDTO() {
    }

    public HistorialEstadoDTO(String estado, LocalDateTime fecha) {
        this.estado = estado;
        this.fecha = fecha;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }
}
