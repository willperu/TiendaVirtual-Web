package com.willperu.tiendavirtual.model;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String usuario;   // nombre de usuario    
    
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;  // contraseña
    private String rol;       // ADMIN o CLIENTE
    
    // valicacion de email
    @Column(unique = true, nullable = false)
    @Email(message = "Email inválido")
    @NotBlank(message = "Email obligatorio")
    private String email; // email

    // Constructor vacío (obligatorio para JPA)
    public Usuario() {}
    
    // Getters y Setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }   
    
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getUsuario() {
        return usuario;
    }
    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getRol() {
        return rol;
    }
    public void setRol(String rol) {
        this.rol = rol;
    }
}
