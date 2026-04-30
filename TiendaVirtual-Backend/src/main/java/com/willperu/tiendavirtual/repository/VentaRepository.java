package com.willperu.tiendavirtual.repository;

import com.willperu.tiendavirtual.dto.ProductoVendidoDTO;
import com.willperu.tiendavirtual.model.Venta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;
import com.willperu.tiendavirtual.dto.VentasPorDiaDTO;
import com.willperu.tiendavirtual.dto.VentasPorUsuarioDTO;
import com.willperu.tiendavirtual.model.Usuario;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.data.repository.query.Param;

public interface VentaRepository extends JpaRepository<Venta, Long> {

    List<Venta> findByUsuario(Usuario usuario);

    // 🔹 Ventas totales
    @Query("SELECT COALESCE(SUM(v.total), 0) FROM Venta v")
    BigDecimal obtenerTotalVentas();

    // 🔹 Ventas en rango (hoy o filtro)
    @Query("""
        SELECT COALESCE(SUM(v.total), 0)
        FROM Venta v
        WHERE v.fecha BETWEEN :inicio AND :fin
    """)
    BigDecimal sumarVentasEntreFechas(
        @Param("inicio") LocalDateTime inicio,
        @Param("fin") LocalDateTime fin
    );
    List<Venta> findByFechaBetween(LocalDateTime inicio, LocalDateTime fin);
    
    // 🔹 Producto más vendido (general)
    @Query("""
        SELECT new com.willperu.tiendavirtual.dto.ProductoVendidoDTO(
            d.producto.nombre, SUM(d.cantidad)
        )
        FROM DetalleVenta d
        GROUP BY d.producto.nombre
        ORDER BY SUM(d.cantidad) DESC
    """)
    List<ProductoVendidoDTO> obtenerProductosMasVendidos();

    // 🔹 Ventas por día (CON FILTRO)
    @Query("""
        SELECT new com.willperu.tiendavirtual.dto.VentasPorDiaDTO(
            FUNCTION('DATE', v.fecha), SUM(v.total)
        )
        FROM Venta v
        WHERE v.fecha BETWEEN :inicio AND :fin
        GROUP BY FUNCTION('DATE', v.fecha)
        ORDER BY FUNCTION('DATE', v.fecha)
    """)
    List<VentasPorDiaDTO> obtenerVentasPorDiaEntreFechas(
        @Param("inicio") LocalDateTime inicio,
        @Param("fin") LocalDateTime fin
    );

    // 🔹 Ventas por usuario
    @Query("""
        SELECT new com.willperu.tiendavirtual.dto.VentasPorUsuarioDTO(
            v.usuario.usuario, SUM(v.total)
        )
        FROM Venta v
        GROUP BY v.usuario.usuario
        ORDER BY SUM(v.total) DESC
    """)
    List<VentasPorUsuarioDTO> obtenerVentasPorUsuario();

    // 🔹 Ventas entre fechas (para cálculos manuales si quieres)
    
    
    @Query("SELECT v FROM Venta v LEFT JOIN FETCH v.detalles WHERE v.id = :id")
    Optional<Venta> findByIdConDetalles(@Param("id") Long id);
    @Query("SELECT DISTINCT v FROM Venta v LEFT JOIN FETCH v.detalles")
    List<Venta> findAllConDetalles();
}
