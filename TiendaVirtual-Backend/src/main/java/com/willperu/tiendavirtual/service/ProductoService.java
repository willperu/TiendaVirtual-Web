package com.willperu.tiendavirtual.service;

import com.willperu.tiendavirtual.model.Producto;
import com.willperu.tiendavirtual.repository.ProductoRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductoService {

    @Autowired
    private ProductoRepository productoRepository;

    public List<Producto> listarProductos(){
        return productoRepository.findAll();
    }
    
        // 🔥 FILTRAR POR CATEGORÍA
    public List<Producto> listarPorCategoria(
            String categoria) {

        return productoRepository
                .findByCategoria(categoria);
    }

    public Producto guardarProducto(Producto producto){
        return productoRepository.save(producto);
    }

    public Producto obtenerProducto(Long id){
        return productoRepository.findById(id).orElse(null);
    }
    
    public List<Producto> obtenerProductosStockBajo() {
        return productoRepository.obtenerProductosStockBajo();
    }

    public void eliminarProducto(Long id){
        productoRepository.deleteById(id);
    }
    
    public Long contarProductosStockBajo() {
        return productoRepository.contarProductosStockBajo(5);
    }
    
    // Metodo actualizar producto
    public Producto actualizarProducto(Long id, Producto producto){

    Producto productoExistente = productoRepository.findById(id).orElse(null);

        if(productoExistente != null){
            productoExistente.setNombre(producto.getNombre());
            productoExistente.setPrecio(producto.getPrecio());
            productoExistente.setStock(producto.getStock());            
            productoExistente.setCategoria(producto.getCategoria());
            
            productoExistente.setDescripcion(producto.getDescripcion());
            productoExistente.setColores(producto.getColores());
            productoExistente.setTallas(producto.getTallas());


            return productoRepository.save(productoExistente);
        }

        return null;
    }
}