package com.willperu.tiendavirtual.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HolaController {

    @GetMapping("/")
    public String hola() {
        return "🚀 Backend Tienda Virtual funcionando correctamente";
    }
}
