import { API } from "./config.js";
import { getToken } from "./auth.js";

// ================== HELPERS ==================
function authHeader() {
  const token = getToken();
  return token ? { Authorization: "Bearer " + token } : null;
}

// ================== AGREGAR ==================
export async function agregarAlCarrito(productoId) {
  const headers = authHeader();
  if (!headers) return null;

  console.log("➕ Agregando producto:", productoId);

  const res = await fetch(`${API}/carrito/agregar/${productoId}`, {
    method: "POST",
    headers,
  });

  if (!res.ok) {
    console.error("Error agregar:", res.status);
    throw new Error("Error al agregar producto");
  }

  return await mostrarCarrito();
}

// ================== MOSTRAR ==================
export async function mostrarCarrito() {
  const headers = authHeader();
  if (!headers) return { items: [], total: 0, cantidad: 0 };

  const res = await fetch(`${API}/carrito/detalle`, {
    headers,
  });

  if (!res.ok) {
    console.error("Error mostrar carrito:", res.status);
    throw new Error("Error al obtener carrito");
  }

  const data = await res.json();

  const items = data.items || [];

  let total = 0;
  let cantidad = 0;

  items.forEach((item) => {
    total += item.subtotal;
    cantidad += item.cantidad;
  });

  return { items, total, cantidad };
}

// ================== ELIMINAR ==================
export async function eliminarItem(itemId) {
  const headers = authHeader();
  if (!headers) return null;

  const res = await fetch(`${API}/carrito/eliminar/${itemId}`, {
    method: "DELETE",
    headers,
  });

  if (!res.ok) throw new Error("Error eliminando item");

  return await mostrarCarrito();
}

// ================== ACTUALIZAR ==================
export async function cambiarCantidad(itemId, delta) {
  const headers = authHeader();
  if (!headers) return null;

  const res = await fetch(
    `${API}/carrito/actualizar/${itemId}?delta=${delta}`,
    {
      method: "PATCH",
      headers,
    },
  );

  if (!res.ok) throw new Error("Error actualizando cantidad");

  return await mostrarCarrito();
}

// ================== VACIAR ==================
export async function vaciarCarrito() {
  const headers = authHeader();
  if (!headers) return null;

  const res = await fetch(`${API}/carrito/vaciar`, {
    method: "DELETE",
    headers,
  });

  if (!res.ok) throw new Error("Error vaciando carrito");

  return await mostrarCarrito();
}

// ================== COMPRAR ==================
export async function comprarCarrito(datosCliente) {
  const headers = authHeader();
  if (!headers) return null;

  console.log("🧾 Checkout datos:", datosCliente);

  const loader = document.getElementById("modalLoader");

  loader?.classList.add("show");
  await new Promise((r) => setTimeout(r, 300));

  try {
    const res = await fetch(`${API}/carrito/checkout`, {
      method: "POST",
      headers: {
        ...headers,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(datosCliente),
    });

    if (!res.ok) {
      console.error("Checkout error:", res.status);
      throw new Error("Error al comprar");
    }

    const contentType = res.headers.get("content-type");

    if (contentType?.includes("application/json")) {
      return await res.json();
    }

    const text = await res.text();
    return { mensaje: text };
  } catch (error) {
    console.error(error);
    throw error;
  } finally {
    loader?.classList.remove("show");
  }
}
