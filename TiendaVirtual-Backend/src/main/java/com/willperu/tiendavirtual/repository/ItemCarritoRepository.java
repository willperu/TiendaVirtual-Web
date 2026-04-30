package com.willperu.tiendavirtual.repository;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.willperu.tiendavirtual.model.ItemCarrito;
import com.willperu.tiendavirtual.model.Carrito;
import com.willperu.tiendavirtual.model.Producto;

public interface ItemCarritoRepository extends JpaRepository<ItemCarrito, Long> {

    List<ItemCarrito> findByCarrito(Carrito carrito);

    Optional<ItemCarrito> findByCarritoAndProducto(Carrito carrito, Producto producto);

    void deleteByCarrito(Carrito carrito);
}
