import { cargarProductos } from "./productos.js";
import {
  mostrarCarrito,
  agregarAlCarrito,
  vaciarCarrito,
  cambiarCantidad,
  eliminarItem,
  comprarCarrito,
} from "./carrito.js";

/* ================== TOAST ================== */
function mostrarToast(mensaje, tipo = "info") {
  const container = document.getElementById("toast-container");
  if (!container) return;

  const toast = document.createElement("div");
  toast.classList.add("toast", tipo);
  toast.innerText = mensaje;

  container.appendChild(toast);
  setTimeout(() => toast.remove(), 3000);
}

/* ================== FORMATO PAGO ================== */
function formatearPago(pago) {
  switch (pago) {
    case "efectivo":
      return "💵 Efectivo";
    case "tarjeta":
      return "💳 Tarjeta";
    case "pix":
      return "⚡ Pix";
    default:
      return "No definido";
  }
}

/* ================== TICKET ================== */
function mostrarTicket(datosCliente, items) {
  const cont = document.getElementById("ticketContenido");
  const modal = document.getElementById("modalTicket");

  if (!cont) return;

  let total = 0;

  let html = `
    <p><strong>Cliente:</strong> ${datosCliente.nombre}</p>
    <p><strong>Email:</strong> ${datosCliente.email}</p>
    <p><strong>Dirección:</strong> ${datosCliente.direccion}</p>
    <p><strong>Pago:</strong> ${formatearPago(datosCliente.metodoPago)}</p>
    <hr>
  `;

  items.forEach((item) => {
    total += item.subtotal;
    html += `<p>${item.producto} x${item.cantidad} - S/ ${item.subtotal}</p>`;
  });

  html += `<hr><p><strong>Total: S/ ${total}</strong></p>`;

  cont.innerHTML = html;
  modal?.classList.add("show");
}

/* ================== UI BADGE ================== */
async function updateCartUI() {
  const data = await mostrarCarrito();
  if (!data) return;

  const badge = document.getElementById("cantidadItems");
  if (badge) {
    badge.textContent = data.cantidad;
    badge.style.display = data.cantidad > 0 ? "inline-block" : "none";
  }

  return data;
}

/* ================== RENDER CARRITO ================== */
async function renderCarrito() {
  const data = await mostrarCarrito();

  const cont = document.getElementById("carritoContenido");
  const totalEl = document.getElementById("totalCarrito");

  if (!cont || !totalEl) return;

  let total = 0;

  cont.innerHTML = data.items.length
    ? data.items
        .map((item) => {
          total += item.subtotal;

          return `
          <div class="item-carrito">
            <strong>${item.producto}</strong>
            <p>Cantidad: ${item.cantidad}</p>
            <p>Subtotal: S/ ${item.subtotal}</p>

            <button class="btn-menos" data-id="${item.id}">-</button>
            <button class="btn-mas" data-id="${item.id}">+</button>
            <button class="btn-eliminar" data-id="${item.id}">❌</button>
          </div>
        `;
        })
        .join("")
    : "<p>Carrito vacío 🛒</p>";

  totalEl.textContent = "Total: S/ " + total;
}

/* ================== INIT ================== */
document.addEventListener("DOMContentLoaded", async () => {
  console.log("APP OK");

  await cargarProductos();
  await updateCartUI();

  const modalCarrito = document.getElementById("modalCarrito");
  const modalCheckout = document.getElementById("modalCheckout");
  const modalTicket = document.getElementById("modalTicket");
  const formCheckout = document.getElementById("formCheckout");

  /* ================== CLICK GLOBAL ================== */
  document.addEventListener("click", async (e) => {
    const el = e.target.closest("button");
    if (!el) return;

    if (el.classList.contains("btn-eliminar")) {
      await eliminarItem(el.dataset.id);
      await renderCarrito();
      await updateCartUI();
    } else if (el.classList.contains("btn-mas")) {
      await cambiarCantidad(el.dataset.id, 1);
      await renderCarrito();
      await updateCartUI();
    } else if (el.classList.contains("btn-menos")) {
      await cambiarCantidad(el.dataset.id, -1);
      await renderCarrito();
      await updateCartUI();
    } else if (el.classList.contains("btn-agregar")) {
      await agregarAlCarrito(el.dataset.id);
      await updateCartUI();
      mostrarToast("Producto agregado 🛒", "success");
    } else if (el.id === "btnVaciar") {
      await vaciarCarrito();
      await renderCarrito();
      await updateCartUI();
      mostrarToast("Carrito vaciado 🗑️");
    }
  });

  /* ================== VER CARRITO ================== */
  document
    .getElementById("btnVerCarrito")
    ?.addEventListener("click", async () => {
      await renderCarrito();
      modalCarrito?.classList.add("show");
    });

  /* ================== ABRIR CHECKOUT ================== */
  document.getElementById("btnComprar")?.addEventListener("click", () => {
    modalCarrito?.classList.remove("show"); // 🔥 importante
    modalCheckout?.classList.add("show");
  });

  /* ================== CONFIRMAR COMPRA ================== */
  document
    .getElementById("confirmarCheckout")
    ?.addEventListener("click", async (e) => {
      const btn = e.currentTarget;
      const texto = btn.querySelector(".texto");
      const spinner = btn.querySelector(".spinner");

      btn.disabled = true;
      texto.textContent = "Procesando...";
      spinner?.classList.remove("hidden");

      try {
        const nombre = document.getElementById("chkNombre").value;
        const direccion = document.getElementById("chkDireccion").value;
        const telefono = document.getElementById("chkTelefono").value;
        const email = document.getElementById("chkEmail").value;
        const metodoPago = document.getElementById("chkPago").value;

        if (!nombre || !direccion || !telefono || !email) {
          throw new Error("Completa todos los campos ⚠️");
        }

        if (!metodoPago) {
          throw new Error("Selecciona método de pago");
        }

        const carritoData = await mostrarCarrito();

        const datosCliente = {
          nombre,
          direccion,
          telefono,
          email,
          metodoPago,
        };

        const res = await comprarCarrito(datosCliente);

        mostrarToast(res?.mensaje || "Compra realizada ✅", "success");
        mostrarTicket(datosCliente, carritoData.items);

        await vaciarCarrito();
        await updateCartUI();

        modalCheckout?.classList.remove("show");
      } catch (err) {
        mostrarToast(err.message, "error");
      }

      btn.disabled = false;
      texto.textContent = "Confirmar";
      spinner?.classList.add("hidden");
    });

  /* ================== CERRAR TICKET ================== */
  const cerrarTicket = () => {
    modalTicket?.classList.remove("show");
    formCheckout?.reset(); // 🔥 clave
  };

  document
    .getElementById("cerrarTicket")
    ?.addEventListener("click", cerrarTicket);

  /* ================== CLICK FUERA MODALES ================== */
  window.addEventListener("click", (e) => {
    if (e.target === modalTicket) {
      cerrarTicket();
    }

    if (e.target === modalCheckout) {
      modalCheckout.classList.remove("show");
    }

    if (e.target === modalCarrito) {
      modalCarrito.classList.remove("show");
    }
  });
});
