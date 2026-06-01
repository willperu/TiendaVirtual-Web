package com.willperu.tiendavirtual.controller;

import com.willperu.tiendavirtual.model.Producto;
import com.willperu.tiendavirtual.service.ProductoService;
import io.swagger.v3.oas.annotations.tags.Tag;

import java.util.List;
import java.io.IOException;
import java.math.BigDecimal;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Producto guardarProducto(

            @RequestParam("nombre") String nombre,
            @RequestParam("precio") BigDecimal precio,
            @RequestParam("stock") Integer stock,
            @RequestParam("categoria") String categoria,

            @RequestParam(value = "descripcion", required = false) String descripcion,
            @RequestParam(value = "colores", required = false) String colores,
            @RequestParam(value = "tallas", required = false) String tallas,

            @RequestParam(value = "imagen", required = false) MultipartFile imagen

    ) throws IOException {

        Producto producto = new Producto();

        producto.setNombre(nombre);
        producto.setPrecio(precio);
        producto.setStock(stock);
        producto.setCategoria(categoria);

        producto.setDescripcion(descripcion);
        producto.setColores(colores);
        producto.setTallas(tallas);

        // 🔥 GUARDAR IMAGEN
        if (imagen != null && !imagen.isEmpty()) {

            String nombreArchivo = imagen.getOriginalFilename();

            // 🔥 carpeta según categoría
            String carpeta = categoria.toLowerCase();

            Path ruta = Paths.get(
                    "storage/productos/" + carpeta + "/" + nombreArchivo
            );

            Files.createDirectories(ruta.getParent());

            Files.write(ruta, imagen.getBytes());

            producto.setImagen(
                carpeta + "/" + nombreArchivo
            );
         }
       
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
    @PutMapping(value = "/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Producto actualizarProducto(

            @PathVariable Long id,

            @RequestParam("nombre") String nombre,
            @RequestParam("precio") BigDecimal precio,
            @RequestParam("stock") Integer stock,
            @RequestParam("categoria") String categoria,

            @RequestParam(value = "descripcion", required = false) String descripcion,
            @RequestParam(value = "colores", required = false) String colores,
            @RequestParam(value = "tallas", required = false) String tallas,

            @RequestParam(value = "imagen", required = false) MultipartFile imagen

    ) throws IOException {

        Producto producto = productoService.obtenerProducto(id);

        producto.setNombre(nombre);
        producto.setPrecio(precio);
        producto.setStock(stock);
        producto.setCategoria(categoria);

        producto.setDescripcion(descripcion);
        producto.setColores(colores);
        producto.setTallas(tallas);

        // 🔥 SI HAY IMAGEN NUEVA
        if (imagen != null && !imagen.isEmpty()) {

            String nombreArchivo = imagen.getOriginalFilename();

            // 🔥 carpeta según categoría
            String carpeta = categoria.toLowerCase();

            Path ruta = Paths.get(
                    "storage/productos/" + carpeta + "/" + nombreArchivo
            );

            Files.createDirectories(ruta.getParent());

            Files.write(ruta, imagen.getBytes());

            producto.setImagen(
                carpeta + "/" + nombreArchivo
            );
        }
        
       
        return productoService.guardarProducto(producto);
    }
    
 
}
