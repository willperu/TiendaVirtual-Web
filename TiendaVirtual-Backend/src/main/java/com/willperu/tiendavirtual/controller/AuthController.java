package com.willperu.tiendavirtual.controller;

import com.willperu.tiendavirtual.model.PasswordResetToken;
import com.willperu.tiendavirtual.model.Usuario;
import com.willperu.tiendavirtual.repository.UsuarioRepository;
import com.willperu.tiendavirtual.security.JwtUtil;
import com.willperu.tiendavirtual.service.AuthService;
import com.willperu.tiendavirtual.service.EmailService;
import io.swagger.v3.oas.annotations.tags.Tag;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/auth")
@Tag(name = "Autenticación", description = "Login y generación de token JWT")
public class AuthController {    
       
    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UsuarioRepository usuarioRepository;
    
    @Autowired
    private AuthService authService;
    
    @Autowired
private EmailService emailService;

    
    // Crear un bean de BCryptPasswordEncoder si aún no lo tienes
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @PostMapping("/login")   
    public Map<String, Object> login(@RequestBody Map<String, String> request) {
       
        
        String username = request.get("usuario");
        String password = request.get("password");

        Usuario usuario = usuarioRepository.findByUsuario(username)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        System.out.println("PASSWORD INGRESADA: " + password);
        System.out.println("PASSWORD BD: " + usuario.getPassword());
        System.out.println("MATCH: " + passwordEncoder.matches(password, usuario.getPassword()));

        if (!passwordEncoder.matches(password, usuario.getPassword())) {
            throw new RuntimeException("Usuario o contraseña incorrectos");
        }

        String token = jwtUtil.generarToken(usuario.getUsuario(), usuario.getRol());

        Map<String, Object> response = new HashMap<>();
        response.put("token", token);
        response.put("valido", true);
        response.put("rol", usuario.getRol());

        return response;
    }    
   
    
    @PostMapping("/forgot-password")
    public ResponseEntity<?> forgotPassword(
            @RequestBody Map<String, String> request) {

        try {

            String email = request.get("email").trim();
            System.out.println("EMAIL RECIBIDO => [" + email + "]");

            
             PasswordResetToken reset =
                    authService.crearReset(email);

            String token = reset.getToken();
            String verificationCode = reset.getVerificationCode(); 

            System.out.println("TOKEN RESET: " + token);

            String link =
                "http://127.0.0.1:5500/reset-password.html?token="
                + token;

            System.out.println("EMAIL SIMULADO:");
            System.out.println(link);
            
                emailService.enviarEmail(
                    email,
                    "Recuperación de contraseña",
                    "Link: " + link + "\nCódigo: " + verificationCode
                );

            return ResponseEntity.ok(
                    "Revisa tu correo");

            } catch (RuntimeException e) {

            return ResponseEntity
                    .badRequest()
                    .body(e.getMessage());
        }
    }
        
    @PostMapping("/reset-password")
        public ResponseEntity<?> resetPassword(@RequestBody Map<String, String> request) {
            
            System.out.println("🔥 RESET PASSWORD HIT");

            String token = request.get("token");
            
            String verificationCode =
            request.get("verificationCode");

            String newPassword =
                    request.get("newPassword");

            authService.resetPassword(
                    token,
                    verificationCode,
                    newPassword);

            return ResponseEntity.ok("Contraseña actualizada correctamente");
        } 
     
}
