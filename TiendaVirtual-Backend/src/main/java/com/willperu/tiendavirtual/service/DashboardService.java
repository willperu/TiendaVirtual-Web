package com.willperu.tiendavirtual.service;

import com.willperu.tiendavirtual.dto.DashboardDTO;
import com.willperu.tiendavirtual.dto.ProductoVendidoDTO;
import com.willperu.tiendavirtual.dto.VentasPorDiaDTO;
import com.willperu.tiendavirtual.repository.DetalleVentaRepository;
import com.willperu.tiendavirtual.repository.ProductoRepository;
import com.willperu.tiendavirtual.repository.VentaRepository;
import java.math.BigDecimal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class DashboardService {

    @Autowired
    private VentaRepository ventaRepository;

    @Autowired
    private ProductoRepository productoRepository;

    @Autowired
    private DetalleVentaRepository detalleVentaRepository;

    public DashboardDTO obtenerDashboard() {

    // 1️⃣ Rango de hoy
    LocalDate hoy = LocalDate.now();
    LocalDateTime inicio = hoy.atStartOfDay();
    LocalDateTime fin = hoy.atTime(23, 59, 59);

    // 2️⃣ Ventas de hoy (USANDO QUERY)
    BigDecimal ventasHoyBD = ventaRepository.sumarVentasEntreFechas(inicio, fin);
    ventasHoyBD = (ventasHoyBD != null) ? ventasHoyBD : BigDecimal.ZERO;

    // 3️⃣ Ventas totales (USANDO QUERY)
    BigDecimal ventasTotalesBD = ventaRepository.obtenerTotalVentas();
    ventasTotalesBD = (ventasTotalesBD != null) ? ventasTotalesBD : BigDecimal.ZERO;

    // 4️⃣ Producto más vendido
    List<ProductoVendidoDTO> productosVendidos =
            detalleVentaRepository.obtenerProductosMasVendidos();

    String productoMasVendido = productosVendidos.isEmpty()
            ? "Ninguno"
            : productosVendidos.get(0).getProducto();

    // 5️⃣ Stock bajo
    Long productosStockBajo = productoRepository.countByStockLessThan(5);

    Double ventasHoy = ventasHoyBD.doubleValue();
    Double ventasTotales = ventasTotalesBD.doubleValue();
    // 🔹 Return limpio
    return new DashboardDTO(
            ventasHoy,
            ventasTotales,
            productoMasVendido,
            productosStockBajo
    );
}
    
    
public DashboardDTO obtenerResumen(int dias) {

    LocalDateTime fin = LocalDateTime.now();
    LocalDateTime inicio = fin.minusDays(dias);

    // 🔹 ventas del rango
    BigDecimal ventasRangoBD =
        ventaRepository.sumarVentasEntreFechas(inicio, fin);

    Double ventasRango = (ventasRangoBD != null)
        ? ventasRangoBD.doubleValue()
        : 0.0;

    // 🔹 ventas SOLO HOY
    LocalDate hoy = LocalDate.now();
    BigDecimal ventasHoyBD =
        ventaRepository.sumarVentasEntreFechas(
            hoy.atStartOfDay(),
            hoy.atTime(23,59,59)
        );

    Double ventasHoy = (ventasHoyBD != null)
        ? ventasHoyBD.doubleValue()
        : 0.0;

    // 🔹 producto más vendido
    List<ProductoVendidoDTO> productos =
        detalleVentaRepository.obtenerTopProductosEntreFechas(inicio, fin);

    String productoMasVendido = productos.isEmpty()
        ? "Ninguno"
        : productos.get(0).getProducto();

    Long stockBajo = productoRepository.countByStockLessThan(5);

    return new DashboardDTO(
        ventasHoy,
        ventasRango,
        productoMasVendido,
        stockBajo
    );
}
   
   public List<VentasPorDiaDTO> obtenerVentasPorDia(int dias) {

        LocalDateTime fin = LocalDateTime.now();
        LocalDateTime inicio = fin.minusDays(dias);

        return ventaRepository.obtenerVentasPorDiaEntreFechas(inicio, fin);
    }
   
     public List<ProductoVendidoDTO> obtenerTopProductos(int dias) {

        LocalDateTime fin = LocalDateTime.now();
        LocalDateTime inicio = fin.minusDays(dias);

        return detalleVentaRepository.obtenerTopProductosEntreFechas(inicio, fin);
    }
}