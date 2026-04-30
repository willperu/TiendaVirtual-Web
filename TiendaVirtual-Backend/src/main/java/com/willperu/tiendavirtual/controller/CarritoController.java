package com.willperu.tiendavirtual.controller;

import com.willperu.tiendavirtual.dto.VentaDTO;
import com.willperu.tiendavirtual.model.ItemCarrito;
import com.willperu.tiendavirtual.service.CarritoService;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/carrito")
public class CarritoController {

    @Autowired
    private CarritoService carritoService;
  
    @GetMapping
    public Map<String, Object> obtenerItemsCarrito() {
        return carritoService.verCarritoDetalle();
    }
    
     // 🔹 Actualizar cantidad de un item
    @PutMapping("/{itemId}")
    public ItemCarrito actualizarCantidad(
            @PathVariable Long itemId,
            @RequestParam int cantidad) {
        return carritoService.actualizarCantidad(itemId, cantidad);
    }
    
    @PatchMapping("/actualizar/{itemId}")
    public ItemCarrito actualizarCantidadDelta(
            @PathVariable Long itemId,
            @RequestParam int delta) {

        return carritoService.actualizarCantidadDelta(itemId, delta);
    }

    @PostMapping("/agregar/{productoId}")
    public String agregarProducto(@PathVariable Long productoId) {
        carritoService.agregarProducto(productoId);
        return "Producto agregado al carrito";
    }
    
    @DeleteMapping("/eliminar/{itemId}")
    public String eliminarItem(@PathVariable Long itemId) {
        carritoService.eliminarItem(itemId);
        return "Producto eliminado del carrito";
    }
    
    @GetMapping("/detalle")
    public Map<String, Object> obtenerCarritoDetalle(Authentication auth) {
        System.out.println("Usuario autenticado: " + auth);
        return carritoService.verCarritoDetalle();
    }
     
    
    @PostMapping("/checkout")
    public ResponseEntity<String> finalizarCompra(
            @RequestBody VentaDTO datos,
            Authentication auth) {

        String usuario = auth.getName();

        carritoService.finalizarCompra(usuario, datos);

        return ResponseEntity.ok("Compra realizada con éxito");
    }
    
      
    @DeleteMapping("/cancelar")
    public String cancelarCompra() {
        carritoService.cancelarCompra();
        return "Compra cancelada y carrito vaciado";
    }
    
    @DeleteMapping("/vaciar")
    public ResponseEntity<String> vaciarCarrito(Authentication auth) {

        String username = auth.getName(); // 👈 viene del token JWT

        carritoService.vaciarCarrito(username);

        return ResponseEntity.ok("Carrito vaciado");
    }
    
    @PatchMapping("/disminuir/{itemId}")
    public String disminuirCantidad(@PathVariable Long itemId) {
        carritoService.disminuirCantidad(itemId);
        return "Cantidad actualizada";
    }
    
    
}