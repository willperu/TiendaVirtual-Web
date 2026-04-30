package com.willperu.tiendavirtual.controller;

import com.willperu.tiendavirtual.dto.DashboardDTO;
import com.willperu.tiendavirtual.dto.ProductoVendidoDTO;
import com.willperu.tiendavirtual.dto.VentasPorDiaDTO;
import com.willperu.tiendavirtual.dto.VentasPorUsuarioDTO;
import com.willperu.tiendavirtual.service.DashboardService;
import com.willperu.tiendavirtual.service.VentaService;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/dashboard")
@Tag(name = "Dashboard", description = "Estadísticas y reportes de la tienda")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @Autowired
    private VentaService ventaService;

    // 🔹 Endpoint para obtener el resumen del dashboard
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/resumen")
    public DashboardDTO obtenerResumen(
            @RequestParam(defaultValue = "1") int dias) {
        return dashboardService.obtenerResumen(dias);
    }

    // 🔹 Endpoint para ventas por día con rango opcional (default: 7 días)
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/ventas-por-dia")
    public List<VentasPorDiaDTO> ventasPorDia(
            @RequestParam(defaultValue = "7") int dias) {
        return ventaService.obtenerVentasPorDia(dias);
    }

    // 🔹 Endpoint para top productos con rango opcional (default: 7 días)
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/top-productos")
    public List<ProductoVendidoDTO> topProductos(
            @RequestParam(defaultValue = "7") int dias) {
        return ventaService.obtenerTopProductos(dias);
    }

    // 🔹 Endpoint para ventas por usuario
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/ventas-por-usuario")
    public List<VentasPorUsuarioDTO> ventasPorUsuario() {
        return ventaService.obtenerResumenVentasPorUsuario();
    }
}