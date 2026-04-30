package com.willperu.tiendavirtual.dto;

public class DashboardDTO {

    private Double ventasHoy;
    private Double ventasTotales;
    private String productoMasVendido;
    private Long productosStockBajo;
    
    public DashboardDTO() {
    }

    public DashboardDTO(Double ventasHoy, Double ventasTotales, String productoMasVendido, Long productosStockBajo) {
        this.ventasHoy = ventasHoy;
        this.ventasTotales = ventasTotales;
        this.productoMasVendido = productoMasVendido;
        this.productosStockBajo = productosStockBajo;
    }

    public Double getVentasHoy() {
        return ventasHoy;
    }

    public Double getVentasTotales() {
        return ventasTotales;
    }

    public String getProductoMasVendido() {
        return productoMasVendido;
    }

    public Long getProductosStockBajo() {
        return productosStockBajo;
    }
    
    
}
