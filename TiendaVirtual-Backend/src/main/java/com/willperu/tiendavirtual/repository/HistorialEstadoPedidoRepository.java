package com.willperu.tiendavirtual.repository;

import com.willperu.tiendavirtual.model.HistorialEstadoPedido;
import com.willperu.tiendavirtual.model.Venta;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HistorialEstadoPedidoRepository
        extends JpaRepository<HistorialEstadoPedido, Long> {

    List<HistorialEstadoPedido> findByVentaOrderByFechaAsc(Venta venta);

}