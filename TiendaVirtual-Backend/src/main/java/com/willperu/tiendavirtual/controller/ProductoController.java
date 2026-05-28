package com.willperu.tiendavirtual.controller;

import com.willperu.tiendavirtual.model.Producto;
import com.willperu.tiendavirtual.service.ProductoService;
import io.swagger.v3.oas.annotations.tags.Tag;

import java.util.List;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/productos")
@RestController
@Tag(name = "Productos", description = "Operaciones relacionadas con productos")
public class ProductoController {

    @Autowired
    private ProductoService productoService;

    // LISTAR PRODUCTOS → TODOS pueden acceder
    @GetMapping
    public List<Producto> listarProductos(){
        return productoService.listarProductos();
    }
    
    // 🔥 FILTRO CATEGORÍA
    @GetMapping("/categoria/{categoria}")
    public List<Producto> listarPorCategoria(
            @PathVariable String categoria) {

        return productoService
                .listarPorCategoria(categoria);
    }

    // GUARDAR PRODUCTO → SOLO ADMIN
    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public Producto guardarProducto(@Valid @RequestBody Producto producto){
        return productoService.guardarProducto(producto);
    }
    
    // PRODUCTOS CON STOCK BAJO → SOLO ADMIN
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/stock-bajo")
    public List<Producto> productosStockBajo() {
        return productoService.obtenerProductosStockBajo();
    }

    // OBTENER PRODUCTO POR ID → TODOS pueden acceder
    @GetMapping("/{id}")
    public Producto obtenerProducto(@PathVariable Long id){
        return productoService.obtenerProducto(id);
    }

    // ELIMINAR PRODUCTO → SOLO ADMIN
    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/{id}")
    public void eliminarProducto(@PathVariable Long id){
        productoService.eliminarProducto(id);
    }
    
    // ACTUALIZAR PRODUCTO → SOLO ADMIN
    @PreAuthorize("hasRole('ADMIN')")
    @PutMapping("/{id}")
    public Producto actualizarProducto(@PathVariable Long id, @Valid @RequestBody Producto producto){
        return productoService.actualizarProducto(id, producto);
    }
}
