package com.willperu.tiendavirtual.dto;

public class ProductoVendidoDTO {

    private String producto;
    private Long vendidos;

    public ProductoVendidoDTO(String producto, Long vendidos) {
        this.producto = producto;
        this.vendidos = vendidos;
    }

    public String getProducto() {
        return producto;
    }

    public Long getVendidos() {
        return vendidos;
    }
}