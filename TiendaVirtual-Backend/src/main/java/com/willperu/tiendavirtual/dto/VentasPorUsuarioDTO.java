package com.willperu.tiendavirtual.dto;

import java.math.BigDecimal;

public class VentasPorUsuarioDTO {

    private String usuario;
    private BigDecimal total;

    public VentasPorUsuarioDTO(String usuario, BigDecimal total) {
        this.usuario = usuario;
        this.total = total;
    }

    public String getUsuario() {
        return usuario;
    }

    public BigDecimal getTotal() {
        return total;
    }
}
