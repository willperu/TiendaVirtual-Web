package com.willperu.tiendavirtual.repository;

import com.willperu.tiendavirtual.model.Carrito;

import com.willperu.tiendavirtual.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import org.springframework.stereotype.Repository;

@Repository
public interface CarritoRepository extends JpaRepository<Carrito, Long> {
    Optional<Carrito> findByUsuario(Usuario usuario);
    void deleteByUsuario(Usuario usuario);
}
