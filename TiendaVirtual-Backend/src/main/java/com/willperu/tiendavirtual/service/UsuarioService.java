package com.willperu.tiendavirtual.service;

import com.willperu.tiendavirtual.model.Usuario;
import com.willperu.tiendavirtual.repository.CarritoRepository;
import com.willperu.tiendavirtual.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@Service
public class UsuarioService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UsuarioRepository usuarioRepository;
    
    @Autowired
    private CarritoRepository carritoRepository;

    // 📋 LISTAR USUARIOS
    public List<Usuario> listarUsuarios() {
        return usuarioRepository.findAll();
    }

    // 💾 GUARDAR USUARIO
    public Usuario guardarUsuario(Usuario usuario) {

        // 🔥 VALIDAR EMAIL DUPLICADO
        if (usuarioRepository
                .findByEmail(usuario.getEmail())
                .isPresent()) {

            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST,
                    "El email ya está registrado");
        }

        // 🔥 VALIDAR USUARIO DUPLICADO
        if (usuarioRepository
                .findByUsuario(usuario.getUsuario())
                .isPresent()) {

            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST,
                    "El usuario ya existe");
        }

        // 🔐 ENCRIPTAR PASSWORD
        usuario.setPassword(
                passwordEncoder.encode(
                        usuario.getPassword().trim()));

        return usuarioRepository.save(usuario);
    }

    // ❌ ELIMINAR USUARIO
    @Transactional
    public void eliminarUsuario(Long id) {

        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        carritoRepository.deleteByUsuario(usuario);

        try {
            usuarioRepository.deleteById(id);
            usuarioRepository.flush();

        } catch (Exception e) {
            throw new RuntimeException(
                "No se puede eliminar un usuario con historial de compras"
            );
        }
    }
}