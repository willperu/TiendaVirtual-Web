package com.willperu.tiendavirtual.service;

import com.willperu.tiendavirtual.dto.DashboardDTO;
import com.willperu.tiendavirtual.dto.ProductoVendidoDTO;
import com.willperu.tiendavirtual.dto.ProductoVentaDTO;
import com.willperu.tiendavirtual.dto.TopIngresosDTO;
import com.willperu.tiendavirtual.dto.VentasPorDiaDTO;
import com.willperu.tiendavirtual.dto.VentasPorUsuarioDTO;
import com.willperu.tiendavirtual.model.Carrito;
import com.willperu.tiendavirtual.model.Venta;
import com.willperu.tiendavirtual.model.DetalleVenta;
import com.willperu.tiendavirtual.model.ItemCarrito;
import com.willperu.tiendavirtual.model.Producto;
import com.willperu.tiendavirtual.model.Usuario;
import com.willperu.tiendavirtual.repository.CarritoRepository;
import com.willperu.tiendavirtual.repository.VentaRepository;
import com.willperu.tiendavirtual.repository.DetalleVentaRepository;
import com.willperu.tiendavirtual.repository.ProductoRepository;
import com.willperu.tiendavirtual.repository.UsuarioRepository;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class VentaService {

    @Autowired
    private VentaRepository ventaRepository;
    
    @Autowired
    private DetalleVentaRepository detalleVentaRepository;
    
    @Autowired
    private ProductoRepository productoRepository;
            
    @Autowired
    private UsuarioRepository usuarioRepository;  

    @Autowired
    private CarritoRepository carritoRepository;

    // LISTAR VENTAS
    public List<Venta> listarVentas() {
        return ventaRepository.findAll();
    }

    // GUARDAR VENTA
    public Venta guardarVenta(Venta venta) {
        return ventaRepository.save(venta);
    }

    // OBTENER VENTA POR ID
    public Venta obtenerVenta(Long id) {
        return ventaRepository.findById(id).orElse(null);
    }
    
    // OBTENER TOTAL DE VENTAS
    public Double obtenerTotalVentas() {
    BigDecimal total = ventaRepository.obtenerTotalVentas();
    return total != null ? total.doubleValue() : 0.0;
}
    
    // OBTENER LAS VENTAS DE HOY
   public Double obtenerVentasHoy() {

        LocalDate hoy = LocalDate.now();

        LocalDateTime inicio = hoy.atStartOfDay();
        LocalDateTime fin = hoy.atTime(23, 59, 59);

        BigDecimal total = ventaRepository.sumarVentasEntreFechas(inicio, fin);

        return total != null ? total.doubleValue() : 0.0;
    }
    
    // OBTENER VENTAS PR USUARIO
    public List<Venta> obtenerVentasPorUsuario(String username) {

    Usuario usuario = usuarioRepository.findByUsuario(username)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        return ventaRepository.findByUsuario(usuario); // ✅ ahora funciona
    }
    
    // VENTAS POR USUARIO DTO
    public List<VentasPorUsuarioDTO> obtenerResumenVentasPorUsuario() {
        return ventaRepository.obtenerVentasPorUsuario();
    }
    
    // Producto Vendido
    public List<ProductoVendidoDTO> obtenerTopProductos(int dias) {

        LocalDateTime fin = LocalDateTime.now();
        LocalDateTime inicio = fin.minusDays(dias);

        return detalleVentaRepository.obtenerTopProductosEntreFechas(inicio, fin);
    }
    
    // Ventas por dia
    public List<VentasPorDiaDTO> obtenerVentasPorDia(int dias) {

        LocalDateTime fin = LocalDateTime.now();
        LocalDateTime inicio = fin.minusDays(dias);

        return ventaRepository.obtenerVentasPorDiaEntreFechas(inicio, fin);
    }
    
    // Obtener venta por ID con detalles
    public Venta obtenerVentaConDetalles(Long id) {
        return ventaRepository.findByIdConDetalles(id).orElse(null);
    }
    
    // Listar todas las ventas con sus detalles
    public List<Venta> listarVentasConDetalles() {
        return ventaRepository.findAllConDetalles();
    }
    
    public String obtenerProductoMasVendido() {

        List<ProductoVendidoDTO> lista = detalleVentaRepository.obtenerProductosMasVendidos();

        if (lista.isEmpty()) {
            return "Sin ventas";
        }

        return lista.get(0).getProducto();
    }
    
  // 🔹 Registrar venta con lista de productos
    @Transactional
    public Venta registrarVenta(List<ProductoVentaDTO> productosVenta, Usuario usuario) {

        
        // Crear nueva venta
        Venta venta = new Venta();
        venta.setUsuario(usuario);
        venta.setFecha(LocalDateTime.now());
        venta.setTotal(BigDecimal.ZERO);

        //venta = ventaRepository.save(venta);

        BigDecimal totalVenta = BigDecimal.ZERO;
        List<DetalleVenta> detalles = new ArrayList<>();

        for (ProductoVentaDTO dto : productosVenta) {
            Producto producto = productoRepository.findById(dto.getProductoId()).orElse(null);

            if (producto != null && dto.getCantidad() > 0 && producto.getStock() >= dto.getCantidad()) {

                DetalleVenta detalle = new DetalleVenta();
                detalle.setVenta(venta);
                detalle.setProducto(producto);
                detalle.setCantidad(dto.getCantidad());

                // ✅ PRECIO UNITARIO
                detalle.setPrecio(producto.getPrecio());

                detalles.add(detalle);

                // ✅ SUBTOTAL
                BigDecimal subtotal = producto.getPrecio()
                        .multiply(BigDecimal.valueOf(dto.getCantidad()));

                totalVenta = totalVenta.add(subtotal);

                // 🔹 Descontar stock
                producto.setStock(producto.getStock() - dto.getCantidad());
                productoRepository.save(producto);
            }
        }

        venta.setDetalles(detalles);
        venta.setTotal(totalVenta);

        // Limpiar carrito del usuario
        carritoRepository.deleteByUsuario(usuario);

        return ventaRepository.save(venta);
    }
    
    // Obtener Dashboard
    public DashboardDTO obtenerDashboard() {

        Double ventasHoy = obtenerVentasHoy();
        Double ventasTotales = obtenerTotalVentas(); // usa tu método corregido
        String productoMasVendido = obtenerProductoMasVendido();
        Long productosStockBajo = productoRepository.contarProductosStockBajo(5);

        return new DashboardDTO(
                ventasHoy,
                ventasTotales,
                productoMasVendido,
                productosStockBajo
        );
    }
    
    // Top productos del dashboard
    public List<ProductoVendidoDTO> obtenerTopProductos() {
        return detalleVentaRepository.obtenerProductosMasVendidos()
                .stream()
                .limit(5)
                .toList();
    }
    
    // 🔹 Nuevo método: procesar la compra del carrito de un usuario
    public void finalizarCompra(Usuario usuario) {
        // 1️⃣ Obtener carrito
        Carrito carrito = carritoRepository.findByUsuario(usuario)
                .orElseThrow(() -> new RuntimeException("Carrito no encontrado"));

        if (carrito.getItems() == null || carrito.getItems().isEmpty()) {
            throw new RuntimeException("El carrito está vacío");
        }

        // 2️⃣ Crear la venta
        Venta venta = new Venta();
        venta.setUsuario(usuario);
        venta.setFecha(LocalDateTime.now());
        venta.setDetalles(new ArrayList<>());
        BigDecimal total = BigDecimal.ZERO;

        for (ItemCarrito item : carrito.getItems()) {
            DetalleVenta detalle = new DetalleVenta();
            detalle.setProducto(item.getProducto());
            detalle.setCantidad(item.getCantidad());
            detalle.setPrecio(item.getProducto().getPrecio());
            detalle.setVenta(venta); // 🔹 relación con la venta

            venta.getDetalles().add(detalle); // 🔹 agregamos al listado de la venta

            total = total.add(detalle.getPrecio().multiply(BigDecimal.valueOf(detalle.getCantidad())));

            // 🔹 Actualizar stock
            Producto producto = item.getProducto();
            producto.setStock(producto.getStock() - item.getCantidad());
            productoRepository.save(producto);
        }

        venta.setTotal(total);

        // 3️⃣ Guardar la venta junto con los detalles automáticamente
        ventaRepository.save(venta);

        // 4️⃣ Vaciar carrito
        carrito.getItems().clear();
        carritoRepository.save(carrito);
    }
    
    public List<Venta> obtenerVentasPorRango(LocalDateTime desde, LocalDateTime hasta) {

        if (desde == null || hasta == null) {
            throw new RuntimeException("Debe enviar ambas fechas");
        }

        return ventaRepository.findByFechaBetween(desde, hasta);
    }
    
    public List<TopIngresosDTO> topProductosPorIngresos(int limite) {
        return detalleVentaRepository
                .topProductosPorIngresos()
                .stream()
                .limit(limite)
                .toList();
    }
    
      
}
