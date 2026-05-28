package com.willperu.tiendavirtual.repository;

import com.willperu.tiendavirtual.model.PasswordResetToken;
import com.willperu.tiendavirtual.model.Usuario;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PasswordResetTokenRepository 
        extends JpaRepository<PasswordResetToken, Long> {

    Optional<PasswordResetToken> findByToken(String token);
    
   // void deleteByUsuario(Usuario usuario);
@Modifying
@Query("DELETE FROM PasswordResetToken p WHERE p.usuario = :usuario")
void deleteByUsuario(@Param("usuario") Usuario usuario);
}
