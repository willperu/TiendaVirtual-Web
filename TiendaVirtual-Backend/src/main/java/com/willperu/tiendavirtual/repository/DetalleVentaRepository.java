package com.willperu.tiendavirtual.repository;

import com.willperu.tiendavirtual.model.DetalleVenta;
import com.willperu.tiendavirtual.dto.ProductoVendidoDTO;
import com.willperu.tiendavirtual.dto.TopIngresosDTO;
import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import org.springframework.data.repository.query.Param;

public interface DetalleVentaRepository extends JpaRepository<DetalleVenta, Long> {
    
   @Query("SELECT new com.willperu.tiendavirtual.dto.ProductoVendidoDTO(" +
           "p.nombre, SUM(d.cantidad)) " +
           "FROM DetalleVenta d " +
           "JOIN d.producto p " +
           "GROUP BY p.nombre " +
           "ORDER BY SUM(d.cantidad) DESC")
        List<ProductoVendidoDTO> obtenerProductosMasVendidos(); 
    
    @Query("""
            SELECT new com.willperu.tiendavirtual.dto.TopIngresosDTO(
                dv.producto.nombre,
                SUM(dv.cantidad * dv.precio)
            )
            FROM DetalleVenta dv
            GROUP BY dv.producto.nombre
            ORDER BY SUM(dv.cantidad * dv.precio) DESC """)
        List<TopIngresosDTO> topProductosPorIngresos();
        
     @Query("""
            SELECT new com.willperu.tiendavirtual.dto.ProductoVendidoDTO(
                dv.producto.nombre,
                SUM(dv.cantidad)
            )
            FROM DetalleVenta dv
            WHERE dv.venta.fecha BETWEEN :inicio AND :fin
            GROUP BY dv.producto.nombre
            ORDER BY SUM(dv.cantidad) DESC
        """)
        List<ProductoVendidoDTO> obtenerTopProductosEntreFechas(
            @Param("inicio") LocalDateTime inicio,
            @Param("fin") LocalDateTime fin
        );   
}
