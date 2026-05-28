package com.willperu.tiendavirtual.service;

import com.willperu.tiendavirtual.model.PasswordResetToken;
import com.willperu.tiendavirtual.model.Usuario;
import com.willperu.tiendavirtual.repository.PasswordResetTokenRepository;
import com.willperu.tiendavirtual.repository.UsuarioRepository;
import java.time.LocalDateTime;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.UUID;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordResetTokenRepository tokenRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    // 1. generar token
    @Transactional
    public String generarToken(String email) {

        Usuario user = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Email no encontrado"));
        
        tokenRepository.deleteByUsuario(user);

        String token = UUID.randomUUID().toString();
        
        String verificationCode =
                String.valueOf((int)(Math.random() * 900000) + 100000);

        PasswordResetToken reset = new PasswordResetToken();
        reset.setToken(token);
        reset.setVerificationCode(verificationCode);
        reset.setUsuario(user);
        reset.setExpiryDate(LocalDateTime.now().plusMinutes(15));

        tokenRepository.save(reset);
        
        //teste
        System.out.println("CODIGO 2FA: " + verificationCode);

        return token;
    }
        // Passwor reset token
        
        @Transactional
        public PasswordResetToken crearReset(String email) {
            
        System.out.println("BUSCANDO EMAIL EN BD: [" + email + "]");        


        Optional<Usuario> optUser = usuarioRepository.findByEmail(email);

        System.out.println("EXISTE?: " + optUser.isPresent());

        Usuario user = optUser
                .orElseThrow(() -> new RuntimeException("Email no encontrado"));
        
        
        tokenRepository.deleteByUsuario(user);

        String token = UUID.randomUUID().toString();

        String verificationCode =
                String.valueOf((int)(Math.random() * 900000) + 100000);

        PasswordResetToken reset = new PasswordResetToken();
        reset.setToken(token);
        reset.setVerificationCode(verificationCode);
        reset.setUsuario(user);
        reset.setExpiryDate(LocalDateTime.now().plusMinutes(15));

        tokenRepository.save(reset);

        System.out.println("CODIGO 2FA: " + verificationCode);

        return reset;
    }

    // 2. validar token
    public PasswordResetToken validarToken(String token) {

        PasswordResetToken reset = tokenRepository.findByToken(token)
                .orElseThrow(() -> new RuntimeException("Token inválido"));

        if (reset.getExpiryDate().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Token expirado");
        }

        return reset;
    }

    // 3. reset password
    public void resetPassword(
        String token,
        String verificationCode,
        String newPassword) {

        PasswordResetToken reset = validarToken(token);
        
        // 🔥 VALIDAR CÓDIGO
        System.out.println("CODIGO BD: [" + reset.getVerificationCode() + "]");
        System.out.println("CODIGO FRONT: [" + verificationCode + "]");

        if (!reset.getVerificationCode().trim()
                .equals(verificationCode.trim())) {

            throw new RuntimeException("Código inválido");
        }        
        
        Usuario user = reset.getUsuario();

        user.setPassword(passwordEncoder.encode(newPassword));
        usuarioRepository.save(user);

        tokenRepository.delete(reset);
    }
}