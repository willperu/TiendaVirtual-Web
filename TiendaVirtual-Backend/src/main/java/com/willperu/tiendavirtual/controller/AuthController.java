package com.willperu.tiendavirtual.controller;

import com.willperu.tiendavirtual.model.Usuario;
import com.willperu.tiendavirtual.repository.UsuarioRepository;
import com.willperu.tiendavirtual.security.JwtUtil;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@Tag(name = "Autenticación", description = "Login y generación de token JWT")
public class AuthController {
    
    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UsuarioRepository usuarioRepository;

    
    // Crear un bean de BCryptPasswordEncoder si aún no lo tienes
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> request) {
        String username = request.get("usuario");
        String password = request.get("password");

        Usuario usuario = usuarioRepository.findByUsuario(username)
                 .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));
        
        //test
        // 🔍 DEBUG COMPLETO
            System.out.println("PASSWORD INGRESADA: " + password);
            System.out.println("PASSWORD BD: " + usuario.getPassword());
            System.out.println("MATCH: " + passwordEncoder.matches(password, usuario.getPassword()));

            if (!passwordEncoder.matches(password, usuario.getPassword()))  {
                throw new RuntimeException("Usuario o contraseña incorrectos");
            }
        //..   
        if (usuario == null || !passwordEncoder.matches(password, usuario.getPassword()))  {
            throw new RuntimeException("Usuario o contraseña incorrectos");
        }
        
        String token = jwtUtil.generarToken(usuario.getUsuario(), usuario.getRol());

        Map<String, Object> response = new HashMap<>();
        response.put("token", token);
        response.put("valido", true);
        response.put("rol", usuario.getRol());

        // Aquí normalmente generas un JWT, por ahora devolvemos un mensaje 
        /*
        Map<String, Object> response = new HashMap<>();
        response.put("username", usuario.getUsuario());
        response.put("rol", usuario.getRol());
        response.put("valido", true);
        */
        return response;
        
    }
}