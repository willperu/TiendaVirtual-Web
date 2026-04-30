package com.willperu.tiendavirtual.service;

import com.willperu.tiendavirtual.model.Usuario;
import com.willperu.tiendavirtual.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;

@Service
public class UsuarioService {
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UsuarioRepository usuarioRepository;

    public List<Usuario> listarUsuarios(){
        return usuarioRepository.findAll();
    }
    
    public Usuario guardarUsuario(Usuario usuario){

        // 🔐 Encriptar password
        usuario.setPassword(passwordEncoder.encode(usuario.getPassword()));

        return usuarioRepository.save(usuario);
    }
    
    public void eliminarUsuario(Long id){
        usuarioRepository.deleteById(id);
    }

}