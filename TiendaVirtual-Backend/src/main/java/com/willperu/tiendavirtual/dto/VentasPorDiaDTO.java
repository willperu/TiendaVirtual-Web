package com.willperu.tiendavirtual.dto;

import java.sql.Date;
import java.math.BigDecimal;

public class VentasPorDiaDTO {

    private Date fecha;
    private Double total;

    public VentasPorDiaDTO(Date fecha, BigDecimal total) {
        this.fecha = fecha;
        this.total = total.doubleValue();
    }

    public Date getFecha() {
        return fecha;
    }

    public Double getTotal() {
        return total;
    }
}
