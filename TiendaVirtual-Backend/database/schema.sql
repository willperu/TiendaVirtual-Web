-- =====================================================
-- TIENDA - SCHEMA LIMPIO PARA RAILWAY / DEPLOY
-- (sin datos sensibles, solo estructura)
-- =====================================================

-- =========================
-- USUARIOS
-- =========================
CREATE TABLE usuarios (
  id BIGINT NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(50) NOT NULL,
  password VARCHAR(64) NOT NULL,
  rol VARCHAR(20) NOT NULL,
  email VARCHAR(255),
  PRIMARY KEY (id),
  UNIQUE KEY uk_usuario (usuario),
  UNIQUE KEY uk_email (email)
);

-- =========================
-- PRODUCTOS
-- =========================
CREATE TABLE productos (
  id BIGINT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  precio DECIMAL(12,2) NOT NULL,
  stock INT DEFAULT 0,
  categoria VARCHAR(50),
  descripcion LONGTEXT,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  imagen VARCHAR(255),
  colores VARCHAR(255),
  tallas VARCHAR(255),
  PRIMARY KEY (id),
  UNIQUE KEY uk_producto_nombre (nombre)
);

-- =========================
-- ITEM CARRITO
-- =========================
CREATE TABLE item_carrito (
  id BIGINT NOT NULL AUTO_INCREMENT,
  usuario_id BIGINT,
  producto_id BIGINT,
  cantidad INT NOT NULL,
  PRIMARY KEY (id)

  CONSTRAINT fk_itemcarrito_usuario
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),

  CONSTRAINT fk_itemcarrito_producto
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- =========================
-- PASSWORD RESET TOKENS
-- =========================
CREATE TABLE password_reset_tokens (
  id BIGINT NOT NULL AUTO_INCREMENT,
  expiry_date DATETIME(6),
  token VARCHAR(255),
  usuario_id BIGINT UNIQUE,
  verification_code VARCHAR(255),
  PRIMARY KEY (id),
  CONSTRAINT fk_reset_user
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- =========================
-- VENTAS
-- =========================
CREATE TABLE ventas (
  id BIGINT NOT NULL AUTO_INCREMENT,
  fecha DATETIME(6),
  total DECIMAL(38,2),
  usuario VARCHAR(100),
  usuario_id BIGINT,
  direccion VARCHAR(255),
  email VARCHAR(255),
  nombre_cliente VARCHAR(255),
  telefono VARCHAR(255),
  estado_pedido ENUM(
    'PENDIENTE',
    'PAGADO',
    'PREPARANDO',
    'ENVIADO',
    'EN_CAMINO',
    'ENTREGADO',
    'CANCELADO'
  ),
  PRIMARY KEY (id),
  CONSTRAINT fk_ventas_user
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
