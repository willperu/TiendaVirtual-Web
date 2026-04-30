package com.willperu.tiendavirtual.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
                                    throws ServletException, IOException {

        // 🔍 DEBUG (puedes dejarlo o quitarlo luego)
        System.out.println("Request path: " + request.getServletPath());
        System.out.println("Authorization header: " + request.getHeader("Authorization"));
        /*
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            filterChain.doFilter(request, response);
            return;
        }
        */
        // 🔓 Ignorar endpoints públicos
        String path = request.getServletPath();
        if (path.startsWith("/api/auth/") ||
            path.startsWith("/swagger-ui") ||
            path.startsWith("/v3/api-docs")) {

            filterChain.doFilter(request, response);
            return;
        }

        String authHeader = request.getHeader("Authorization");

        // 🔥 SI NO HAY TOKEN → CONTINUAR
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        // 🔐 EXTRAER TOKEN
        String token = authHeader.substring(7);

        try {
            String username = jwtUtil.extraerUsername(token);

            // 🔐 VALIDAR TOKEN
            if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {

                if (jwtUtil.validarToken(token, username)) {

                    String rol = jwtUtil.extraerClaim(token,
                            claims -> claims.get("rol", String.class));

                    List<GrantedAuthority> authorities =
                            List.of(new SimpleGrantedAuthority("ROLE_" + rol.toUpperCase()));

                    UsernamePasswordAuthenticationToken authToken =
                            new UsernamePasswordAuthenticationToken(username, null, authorities);

                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                    SecurityContextHolder.getContext().setAuthentication(authToken);
                    System.out.println("AUTH FINAL: " + SecurityContextHolder.getContext().getAuthentication());

                    System.out.println("✅ Token válido para usuario: " + username + " con rol: " + rol);
                }
            }

        } catch (Exception e) {
            System.out.println("❌ Token inválido: " + e.getMessage());
        }

        // 🔥 SIEMPRE CONTINUAR
        filterChain.doFilter(request, response);
    }
}