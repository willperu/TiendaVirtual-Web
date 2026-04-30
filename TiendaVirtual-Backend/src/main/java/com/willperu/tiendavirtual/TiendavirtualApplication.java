package com.willperu.tiendavirtual;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import javax.sql.DataSource;
import java.sql.Connection;

@SpringBootApplication
public class TiendavirtualApplication {

    public static void main(String[] args) {
        SpringApplication.run(TiendavirtualApplication.class, args);
    }

    // Este bean se ejecuta al iniciar la aplicación
    @Bean
    public CommandLineRunner testDatabase(DataSource dataSource) {
        return args -> {
            try (Connection conn = dataSource.getConnection()) {
                System.out.println("✅ Conexión a la base de datos exitosa: " + conn.getMetaData().getDatabaseProductName());
            } catch (Exception e) {
                System.err.println("❌ Error al conectar a la base de datos:");
                e.printStackTrace();
            }
        };
    }
}