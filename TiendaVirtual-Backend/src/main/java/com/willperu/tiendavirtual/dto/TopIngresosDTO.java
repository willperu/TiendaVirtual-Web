package com.willperu.tiendavirtual.dto;

import java.math.BigDecimal;

public class TopIngresosDTO {

    private String producto;
    private BigDecimal totalIngresos;

    public TopIngresosDTO(String producto, BigDecimal totalIngresos) {
        this.producto = producto;
        this.totalIngresos = totalIngresos;
    }

    public String getProducto() {
        return producto;
    }

    public BigDecimal getTotalIngresos() {
        return totalIngresos;
    }
}
