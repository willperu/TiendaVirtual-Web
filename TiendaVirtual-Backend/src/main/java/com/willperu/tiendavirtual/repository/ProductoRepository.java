package com.willperu.tiendavirtual.repository;

import com.willperu.tiendavirtual.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import org.springframework.data.repository.query.Param;

@Repository
public interface ProductoRepository extends JpaRepository<Producto, Long> {

    // Productos con stock bajo
    @Query("SELECT p FROM Producto p WHERE p.stock <= 2")
    List<Producto> obtenerProductosStockBajo();
    
    @Query(""" 
        SELECT COUNT(p)
        FROM Producto p
        WHERE p.stock <= :limite
    """)
    Long contarProductosStockBajo(int limite);
   /* 
    @Query("SELECT COUNT(p) FROM Producto p WHERE p.stock <= 2")
    Long contarProductosStockBajo();
   */


    // Filtros opcionales
    List<Producto> findByCategoria(String categoria);

    @Query("SELECT p FROM Producto p WHERE LOWER(p.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))")
    List<Producto> buscarPorNombre(@Param("nombre") String nombre);
    
    Long countByStockLessThan(int cantidad);
}