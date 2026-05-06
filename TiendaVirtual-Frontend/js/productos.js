import { API } from "./config.js";
import { agregarAlCarrito } from "./carrito.js";

export async function cargarProductos() {
  try {
    const res = await fetch(`${API}/productos`);
    const data = await res.json();

    const cont = document.getElementById("productos");
    if (!cont) return;

    cont.innerHTML = data
      .map(
        (p) => `
        <div class="producto">        
       <img src="http://localhost:8080/imagenes/${p.imagen}?v=${Date.now()}" 
     onerror="this.src='http://localhost:8080/imagenes/default.png'" />

          <h3>${p.nombre}</h3>
          <p><strong>S/ ${p.precio}</strong></p>

          <button class="btn-agregar" data-id="${p.id}">
            🛒 Agregar
          </button>
        </div>
      `,
      )
      .join("");
  } catch (err) {
    console.error(err);
  }
}
