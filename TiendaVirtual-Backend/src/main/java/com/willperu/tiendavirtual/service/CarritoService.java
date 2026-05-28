package com.willperu.tiendavirtual.service;

import com.willperu.tiendavirtual.dto.VentaDTO;
import com.willperu.tiendavirtual.enums.EstadoPedido;
import com.willperu.tiendavirtual.model.Carrito;
import com.willperu.tiendavirtual.model.DetalleVenta;
import com.willperu.tiendavirtual.model.HistorialEstadoPedido;
import com.willperu.tiendavirtual.model.ItemCarrito;
import com.willperu.tiendavirtual.model.Producto;
import com.willperu.tiendavirtual.model.Usuario;
import com.willperu.tiendavirtual.model.Venta;
import com.willperu.tiendavirtual.repository.CarritoRepository;
import com.willperu.tiendavirtual.repository.DetalleVentaRepository;
import com.willperu.tiendavirtual.repository.HistorialEstadoPedidoRepository;
import com.willperu.tiendavirtual.repository.ItemCarritoRepository;
import com.willperu.tiendavirtual.repository.ProductoRepository;
import com.willperu.tiendavirtual.repository.UsuarioRepository;
import com.willperu.tiendavirtual.repository.VentaRepository;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Optional;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@Service 
public class CarritoService {

    @Autowired
    private CarritoRepository carritoRepository;

    @Autowired
    private ItemCarritoRepository itemCarritoRepository;

    @Autowired
    private ProductoRepository productoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;
    
    @Autowired
    private VentaRepository ventaRepository;

    @Autowired
    private DetalleVentaRepository detalleVentaRepository;
            
    @Autowired
    private JdbcTemplate jdbcTemplate;   
    
    @Autowired
    private HistorialEstadoPedidoRepository historialRepository;
    
    // 🔹 Obtener usuario logueado desde JWT
    private Usuario obtenerUsuarioLogueado() {
        Authentication auth = SecurityContextHolder
                .getContext()
                .getAuthentication();

        String username = auth.getName();

        return usuarioRepository.findByUsuario(username)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
    }

    // 🔹 Agregar producto al carrito
    @Transactional
    public void agregarProducto(Long productoId) {
        Usuario usuario = obtenerUsuarioLogueado();

        Carrito carrito = carritoRepository.findByUsuario(usuario)
                .orElseGet(() -> {
                    Carrito nuevo = new Carrito();
                    nuevo.setUsuario(usuario);
                    return carritoRepository.save(nuevo);
                });

        Producto producto = productoRepository.findById(productoId)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

        // Validar stock disponible
        if (producto.getStock() <= 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Sin stock disponible");
        }

        List<ItemCarrito> items = itemCarritoRepository.findByCarrito(carrito);
        ItemCarrito itemExistente = items.stream()
                .filter(i -> i.getProducto().getId().equals(producto.getId()))
                .findFirst()
                .orElse(null);

        int cantidadActual = (itemExistente != null) ? itemExistente.getCantidad() : 0;

        if (cantidadActual + 1 > producto.getStock()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Stock insuficiente");
        }

        if (itemExistente != null) {
            itemExistente.setCantidad(itemExistente.getCantidad() + 1);
            itemCarritoRepository.save(itemExistente);
        } else {
            ItemCarrito nuevo = new ItemCarrito();
            nuevo.setCarrito(carrito);
            nuevo.setProducto(producto);
            nuevo.setCantidad(1);
            itemCarritoRepository.save(nuevo);
        }
    }

    // 🔹 Ver carrito completo
    public List<ItemCarrito> verCarrito() {

        Usuario usuario = obtenerUsuarioLogueado();

        Optional<Carrito> carritoOpt = carritoRepository.findByUsuario(usuario);

        if (carritoOpt.isEmpty()) {
            return List.of(); // lista vacía si no hay carrito
        }

        return itemCarritoRepository.findByCarrito(carritoOpt.get());
    }

    // 🔹 Eliminar un item
 public void eliminarItem(Long itemId) {

    Usuario usuario = obtenerUsuarioLogueado();

    ItemCarrito item = itemCarritoRepository.findById(itemId)
            .orElseThrow(() -> new RuntimeException("Item no encontrado"));

    if (!item.getCarrito().getUsuario().getId().equals(usuario.getId())) {
        throw new RuntimeException("No autorizado");
    }

    itemCarritoRepository.delete(item);
}

    // 🔹 Ver carrito con detalle y total
    public Map<String, Object> verCarritoDetalle() {

        Usuario usuario = obtenerUsuarioLogueado();

        Carrito carrito = carritoRepository.findByUsuario(usuario)
                               
                .orElseGet(() -> {
            Carrito nuevo = new Carrito();
            nuevo.setUsuario(usuario);
            return carritoRepository.save(nuevo);
            });     
        List<ItemCarrito> items = itemCarritoRepository.findByCarrito(carrito);

        BigDecimal total = BigDecimal.ZERO;
        List<Map<String, Object>> lista = new ArrayList<>();

        for (ItemCarrito item : items) {
            BigDecimal subtotal = item.getProducto()
                    .getPrecio()
                    .multiply(BigDecimal.valueOf(item.getCantidad()));
            total = total.add(subtotal);

            Map<String, Object> data = new HashMap<>();
            data.put("id", item.getId());
            data.put("producto", item.getProducto().getNombre());
            data.put("precio", item.getProducto().getPrecio());
            data.put("cantidad", item.getCantidad());
            data.put("subtotal", subtotal);

            lista.add(data);
        }

        Map<String, Object> respuesta = new HashMap<>();
        respuesta.put("items", lista);
        respuesta.put("total", total);

        return respuesta;
    }

    // 🔹 Eliminar un producto específico del carrito
    public void eliminarProducto(Long productoId) {

     Usuario usuario = obtenerUsuarioLogueado();

     Carrito carrito = carritoRepository.findByUsuario(usuario)
             .orElseThrow(() -> new RuntimeException("Carrito no encontrado"));

     Producto producto = productoRepository.findById(productoId)
             .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

     ItemCarrito item = itemCarritoRepository
             .findByCarritoAndProducto(carrito, producto)
             .orElseThrow(() -> new RuntimeException("Producto no está en el carrito"));

     itemCarritoRepository.delete(item);
 }
    
    // *** Disminuir cantidad ***
   public void disminuirCantidad(Long itemId) {

        Usuario usuario = obtenerUsuarioLogueado();

        ItemCarrito item = itemCarritoRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Item no encontrado"));

        if (!item.getCarrito().getUsuario().getId().equals(usuario.getId())) {
            throw new RuntimeException("No autorizado");
        }

        if (item.getCantidad() > 1) {
            item.setCantidad(item.getCantidad() - 1);
            itemCarritoRepository.save(item);
        } else {
            itemCarritoRepository.delete(item);
        }
    }

    // 🔹 Finalizar compra y generar venta
    @Transactional
    public void finalizarCompra(String usuario, VentaDTO datos) {

        Usuario user = usuarioRepository.findByUsuario(usuario)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        Carrito carrito = carritoRepository.findByUsuario(user)
            .orElseThrow(() -> new RuntimeException("Carrito vacío"));

        if (carrito.getItems().isEmpty()) {
            throw new RuntimeException("El carrito está vacío");
        }

        Venta venta = new Venta();
        venta.setNombreCliente(datos.getNombreCliente());
        venta.setDireccion(datos.getDireccion());
        venta.setTelefono(datos.getTelefono());
        venta.setEmail(datos.getEmail());

        venta.setUsuario(user);
        venta.setEstadoPedido(EstadoPedido.PENDIENTE);
        
        BigDecimal total = BigDecimal.ZERO;

        for (ItemCarrito item : carrito.getItems()) {
            total = total.add(item.getSubtotal());
        }

        venta.setTotal(total);

        List<DetalleVenta> detalles = new ArrayList<>();

        for (ItemCarrito item : carrito.getItems()) {

            Producto producto = item.getProducto();

            if (producto.getStock() < item.getCantidad()) {
                throw new RuntimeException("Stock insuficiente");
            }

            // descontar stock
            producto.setStock(producto.getStock() - item.getCantidad());

            DetalleVenta detalle = new DetalleVenta();
            detalle.setProducto(producto);
            detalle.setCantidad(item.getCantidad());
            detalle.setPrecio(item.getProducto().getPrecio());
            detalle.setVenta(venta);

            detalles.add(detalle);
        }

        venta.setDetalles(detalles);

        //ventaRepository.save(venta);
        Venta ventaGuardada = ventaRepository.save(venta);

        // 🔹 guardar historial inicial
        HistorialEstadoPedido historial = new HistorialEstadoPedido();

        historial.setVenta(ventaGuardada);
        historial.setEstado(EstadoPedido.PENDIENTE);

        historialRepository.save(historial);

        // limpiar carrito
        carrito.getItems().clear();
        carritoRepository.save(carrito);
    }
    
    @Transactional
    public void cancelarCompra() {
        Usuario usuario = obtenerUsuarioLogueado();
        Carrito carrito = carritoRepository.findByUsuario(usuario)
                .orElseThrow(() -> new RuntimeException("Carrito vacío"));

        List<ItemCarrito> items = itemCarritoRepository.findByCarrito(carrito);

        if (items.isEmpty()) {
            throw new RuntimeException("No hay productos en el carrito para cancelar");
        }

        // Devolver stock de productos si ya fue reducido (para testing)
        for (ItemCarrito item : items) {
            Producto producto = item.getProducto();
            producto.setStock(producto.getStock() + item.getCantidad());
            productoRepository.save(producto);
        }

        // Vaciar carrito
        itemCarritoRepository.deleteAll(items);
    }
    
    @Transactional
    public void vaciarCarrito(String username) {

        Usuario usuario = usuarioRepository.findByUsuario(username)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        Carrito carrito = carritoRepository.findByUsuario(usuario)
            .orElseThrow(() -> new RuntimeException("Carrito no encontrado"));

        // 🔥 borrar SOLO los items
        itemCarritoRepository.deleteByCarrito(carrito);
    }
    
    @Transactional
    public ItemCarrito actualizarCantidad(Long itemId, int nuevaCantidad) {
        Usuario usuario = obtenerUsuarioLogueado();

        // Buscar item
        ItemCarrito item = itemCarritoRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Item no encontrado"));

        // Validar que el usuario sea el dueño del carrito
        if (!item.getCarrito().getUsuario().getId().equals(usuario.getId())) {
            throw new RuntimeException("No autorizado");
        }

        // Validar stock
        int stockDisponible = item.getProducto().getStock() + item.getCantidad(); 
        // sumamos la cantidad actual del item porque aún no la hemos actualizado
        if (nuevaCantidad > stockDisponible) {
            throw new RuntimeException("Stock insuficiente");
        }

        item.setCantidad(nuevaCantidad);
        itemCarritoRepository.save(item);

        return item;
    }
    
    @Transactional
    public ItemCarrito actualizarCantidadDelta(Long itemId, int delta) {

        Usuario usuario = obtenerUsuarioLogueado();

        // Buscar item
        ItemCarrito item = itemCarritoRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Item no encontrado"));

        // Validar dueño
        if (!item.getCarrito().getUsuario().getId().equals(usuario.getId())) {
            throw new RuntimeException("No autorizado");
        }

        int cantidadActual = item.getCantidad();
        int nuevaCantidad = cantidadActual + delta;

        // ❌ Evitar cantidad menor a 1
        if (nuevaCantidad < 1) {
            itemCarritoRepository.delete(item);
            return null; // o puedes retornar el item eliminado
        }

        // Validar stock
        int stockDisponible = item.getProducto().getStock() + cantidadActual;

        if (nuevaCantidad > stockDisponible) {
            throw new RuntimeException("Stock insuficiente");
        }

        item.setCantidad(nuevaCantidad);
        itemCarritoRepository.save(item);

        return item;
    }
}