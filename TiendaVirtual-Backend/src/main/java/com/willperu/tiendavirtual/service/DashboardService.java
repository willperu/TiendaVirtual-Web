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

    // 🔹 Ventas en rango
    BigDecimal ventasTotalesBD = ventaRepository
            .sumarVentasEntreFechas(inicio, fin);

    Double ventasTotales = (ventasTotalesBD != null)
            ? ventasTotalesBD.doubleValue()
            : 0.0;

    // 🔹 Producto más vendido en rango
    List<ProductoVendidoDTO> productos =
            detalleVentaRepository.obtenerTopProductosEntreFechas(inicio, fin);

    String productoMasVendido = productos.isEmpty()
            ? "Ninguno"
            : productos.get(0).getProducto();

    // 🔹 Stock bajo (global)
    Long stockBajo = productoRepository.countByStockLessThan(5);

    return new DashboardDTO(
            ventasTotales, // puedes ajustar si quieres separar hoy vs total
            ventasTotales,
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