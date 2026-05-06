# 🛒 TiendaVirtual Web

Aplicación web completa de comercio electrónico desarrollada con arquitectura **Full Stack**, que permite la gestión de productos, usuarios, ventas y un dashboard administrativo con métricas en tiempo real.

---

## 📌 Descripción

Este proyecto simula una tienda virtual funcional donde los usuarios pueden:

- Navegar productos
- Agregar productos al carrito
- Realizar compras
- Visualizar su ticket de compra

Además, cuenta con un panel administrativo que permite:

- Gestión de productos
- Gestión de usuarios
- Visualización de ventas
- Dashboard con métricas dinámicas

---

## 🛠️ Tecnologías utilizadas

### 🔙 Backend
- Java JDK 23
- Spring Boot 3.2.2
- Maven
- Spring Security (JWT)
- MySQL (MySQL Workbench 8.0 CE)

### 🔜 Frontend
- HTML5
- CSS3
- JavaScript (Vanilla JS)

---

## 🔐 Seguridad

- Autenticación basada en JWT
- Protección de rutas por roles (ADMIN / USER)
- Manejo de sesiones sin estado (stateless)

---

## 📊 Funcionalidades principales

### 🛍️ Cliente
- Visualización de productos
- Carrito de compras dinámico
- Checkout con datos del cliente
- Generación de ticket de compra

### 🧑‍💼 Administrador
- CRUD de productos
- Gestión de usuarios
- Visualización de ventas

### 📈 Dashboard
- Ventas del día
- Ventas totales
- Producto más vendido
- Productos con bajo stock
- Gráficos dinámicos:
  - Ventas por día (filtro 1, 7, 30 días)
  - Top productos vendidos
  - Ventas por usuario

---

## 🖼️ Capturas del sistema

### 🏠 Vista principal
![Home](docs/images/1.0%20home.png)

### 🛒 Carrito
![Carrito](docs/images/1.1itemCarrito.png)

### 💳 Checkout
![Checkout](docs/images/1.2cheking.png)

### 💰 Pago
![Pago](docs/images/1.3pagamento.png)

### ✅ Confirmación
![Confirmación](docs/images/1.4checkoff.png)

### 📊 Dashboard
![Dashboard](docs/images/2.0%20dashboard_con_filtro.png)

### 📈 Ventas por día
![Ventas](docs/images/2.1%20ventas_por_dia.png)

### 🏆 Top productos
![Top productos](docs/images/2.2%20top_productos_vendidos.png)

### 👤 Ventas por usuario
![Usuarios](docs/images/2.3%20ventas_por_usuario.png)

### 📋 Menú dashboard
![Menu](docs/images/2.4%20dashboard_menu.png)

### 🧾 Tabla de ventas
![Ventas tabla](docs/images/3.0%20tabla_ventas.png)

### 👥 Tabla usuarios
![Usuarios tabla](docs/images/4.0%20tabla_usuarios.png)

### ➕ Registro usuario
![Registro](docs/images/4.1%20checkin_usuario.png)

---

## ⚙️ Configuración del proyecto

### 🔧 Backend

Editar el archivo:

Configurar:
spring.datasource.url=jdbc:mysql://localhost:3306/tiendavirtual
spring.datasource.username=TU_USUARIO
spring.datasource.password=TU_CONTRASEÑA

---

## ▶️ Ejecución

### Backend
```bash
mvn spring-boot:run

Frontend
Abrir los archivos .html en el navegador o usar Live Server.

------------------------
Notas importantes
Las imágenes de productos se sirven desde el backend (/static/imagenes)
El sistema utiliza tokens JWT almacenados en el navegador
Se recomienda usar el rol ADMIN para acceder al dashboard

------------------------
⏱️ Tiempo de desarrollo

Este proyecto fue desarrollado en aproximadamente 2 meses,
utilizando herramientas modernas y apoyo de inteligencia artificial
para optimizar el proceso de desarrollo, depuración y mejora de funcionalidades.

-----------------------
👨‍💻 Autor
    Will Peru
