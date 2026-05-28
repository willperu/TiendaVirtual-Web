package com.willperu.tiendavirtual.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.stereotype.Component;
import javax.crypto.SecretKey;
import io.jsonwebtoken.security.Keys;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

@Component
public class JwtUtil {

    //private final String SECRET_KEY = "mi_clave_secreta_jwt";
    private final SecretKey SECRET_KEY =
        Keys.hmacShaKeyFor("mi_clave_secreta_jwt_muy_segura_12345678901234567890".getBytes());

    // Generar token
    public String generarToken(String username, String rol) {

        Map<String, Object> claims = new HashMap<>();
        claims.put("rol", rol);

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 10))
                .signWith(SECRET_KEY)
                .compact();
    }

    // Extraer username
    public String extraerUsername(String token) {
        return extraerClaim(token, Claims::getSubject);
    }

    // Extraer expiración
    public Date extraerExpiracion(String token) {
        return extraerClaim(token, Claims::getExpiration);
    }

    public <T> T extraerClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extraerTodosLosClaims(token);
        return claimsResolver.apply(claims);
    }

    // 🔹 PARSER COMPATIBLE
    private Claims extraerTodosLosClaims(String token) {
        return Jwts.parser()
                .verifyWith(SECRET_KEY)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    private Boolean tokenExpirado(String token) {
        return extraerExpiracion(token).before(new Date());
    }

    public Boolean validarToken(String token, String username) {
        final String usernameToken = extraerUsername(token);
        return (usernameToken.equals(username) && !tokenExpirado(token));
    }
}