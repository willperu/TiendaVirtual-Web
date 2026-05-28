package com.willperu.tiendavirtual.repository;

import com.willperu.tiendavirtual.model.Usuario;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    Optional<Usuario> findByUsuario(String usuario);
    
    Optional<Usuario> findByEmail(String email);
    
}