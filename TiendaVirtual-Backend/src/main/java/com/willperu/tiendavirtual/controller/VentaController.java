package com.willperu.tiendavirtual.controller;

import com.willperu.tiendavirtual.dto.ProductoVendidoDTO;
import com.willperu.tiendavirtual.dto.ProductoVentaDTO;
import com.willperu.tiendavirtual.model.Venta;
import com.willperu.tiendavirtual.service.VentaService;
import com.willperu.tiendavirtual.dto.TopIngresosDTO;
import com.willperu.tiendavirtual.dto.VentasPorDiaDTO;
import com.willperu.tiendavirtual.model.Usuario;
import com.willperu.tiendavirtual.repository.UsuarioRepository;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

@RestController
@RequestMapping("/api/ventas")
@Tag(name = "Ventas", description = "Gestión de ventas de la tienda")
public class VentaController {

    @Autowired
    private VentaService ventaService;

    @Autowired
    private UsuarioRepository usuarioRepository;

    // 🔹 LISTAR MIS VENTAS (PRIMERO para evitar conflictos)
    @GetMapping("/mis-compras")
    public List<Venta> misVentas() {

        Authentication auth = SecurityContextHolder
                .getContext()
                .getAuthentication();

        String username = auth.getName();

        return ventaService.obtenerVentasPorUsuario(username);
    }

    // 🔹 LISTAR TODAS LAS VENTAS
    @GetMapping
    public List<Venta> listarVentas() {
        return ventaService.listarVentasConDetalles();
    }

    // 🔹 TOTAL VENDIDO
    @GetMapping("/total")
    public Double totalVentas() {
        return ventaService.obtenerTotalVentas();
    }

    // 🔹 PRODUCTOS MÁS VENDIDOS
    @GetMapping("/productos-mas-vendidos")
    public List<ProductoVendidoDTO> productosMasVendidos() {
        return ventaService.obtenerTopProductos();
    }

    // 🔹 VENTAS DE HOY
    @GetMapping("/hoy")
    public Double ventasHoy() {
        return ventaService.obtenerVentasHoy();
    }

    // 🔹 OBTENER VENTA POR ID (PROTEGIDO 🔥)
    @GetMapping("/{id:\\d+}")
    public Venta obtenerVenta(@PathVariable Long id) {
        return ventaService.obtenerVentaConDetalles(id);
    }
    
    @GetMapping("/por-fecha")
    public List<Venta> ventasPorFecha(
            @RequestParam String desde,
            @RequestParam String hasta) {

        LocalDateTime fechaDesde = LocalDateTime.parse(desde);
        LocalDateTime fechaHasta = LocalDateTime.parse(hasta);

        return ventaService.obtenerVentasPorRango(fechaDesde, fechaHasta);
    }
    
    @GetMapping("/por-dia")
    public List<VentasPorDiaDTO> ventasPorDia(
            @RequestParam(defaultValue = "7") int dias) {

        return ventaService.obtenerVentasPorDia(dias);
    }
    
    @GetMapping("/top-ingresos")
    public List<TopIngresosDTO> topIngresos(
            @RequestParam(defaultValue = "5") int limite) {

        return ventaService.topProductosPorIngresos(limite);
    }
    
    @PostMapping("/registrar")
    public Venta registrarVenta(@RequestBody List<ProductoVentaDTO> productos) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        
        //temporal
        System.out.println("USER AUTH: " + username);

        Usuario usuario = usuarioRepository.findByUsuario(username)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        return ventaService.registrarVenta(productos, usuario);
    }
/*
    // 🔹 REGISTRAR VENTA (⚠️ mantener por ahora)
    @PostMapping("/registrar")
    public Venta registrarVenta(@RequestBody List<ProductoVentaDTO> productos) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        Usuario usuario = usuarioRepository.findByUsuario(username)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        return ventaService.registrarVenta(productos, usuario);
    }

    // 🔹 CHECKOUT (⚠️ temporal, luego eliminar)
    @PostMapping("/checkout")
    public String finalizarCompra() {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        Usuario usuario = usuarioRepository.findByUsuario(username)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        ventaService.finalizarCompra(usuario);

        return "Compra realizada con éxito";
    }
 */
}
