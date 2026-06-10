package com.willperu.tiendavirtual.security.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        
        /*   RAILWAY
        registry.addResourceHandler("/imagenes/**")               
                .addResourceLocations("file:" + System.getProperty("user.dir") + "/storage/productos/");
        
        registry.addResourceHandler("/banners/**")
                .addResourceLocations("file:storage/banners/");
        */
        
        
    }
}
