import { API } from "./config.js";
import { agregarAlCarrito } from "./carrito.js";

// 🔥 RENDERIZAR PRODUCTOS
function renderizarProductos(data) {
  console.log("LISTA DE PRODUCTOS:", data);

  data.forEach((p) => {
    console.log("PRODUCTO:", p);
  });

  const cont = document.getElementById("productos");

  if (!cont) return;

  cont.innerHTML = data
    .map(
      (p) => `
        <div 
          class="producto"
          data-id="${p.id}"
          data-nombre="${p.nombre}"
          data-precio="${p.precio}"
          data-imagen="${p.imagen}"
          data-stock="${p.stock}"
          data-colores="${p.colores}"
          data-tallas="${p.tallas}"
          data-descripcion="${p.descripcion}"
        >        

          <img src="${
            p.imagen.startsWith("/storage")
              ? `http://localhost:8080${p.imagen}`
              : `http://localhost:8080/imagenes/${p.imagen}`
          }?v=${Date.now()}"
  
            onerror="this.onerror=null; this.src='http://localhost:8080/imagenes/default.png'"
          />

          <h3>${p.nombre}</h3>

          <p><strong>S/ ${p.precio}</strong></p>
          
          
          <button class="btn-ver-producto" data-id="${p.id}">
            👁 Ver producto
          </button>

        </div>
      `,
    )
    .join("");

  // 🔥 CLICK EN PRODUCTO
  document.querySelectorAll(".producto").forEach((card) => {
    const abrirModal = () => {
      abrirModalProducto(
        card.dataset.id,
        card.dataset.nombre,
        card.dataset.precio,
        card.dataset.imagen,
        card.dataset.stock,
        card.dataset.colores,
        card.dataset.tallas,
        card.dataset.descripcion,
      );
    };

    // 🔥 CLICK EN CARD
    card.addEventListener("click", abrirModal);

    // 🔥 CLICK EN BOTÓN
    const btn = card.querySelector(".btn-ver-producto");

    btn?.addEventListener("click", (e) => {
      e.stopPropagation();

      abrirModal();
    });
  });
}

// 🔥 CARGAR TODOS
export async function cargarProductos() {
  try {
    const res = await fetch(`${API}/productos`);

    const data = await res.json();

    renderizarProductos(data);
  } catch (err) {
    console.error(err);
  }
}

// 🔥 FILTRAR
window.filtrarCategoria = async function (categoria) {
  try {
    let url = `${API}/productos`;

    if (categoria !== "TODOS") {
      url = `${API}/productos/categoria/${categoria}`;
    }

    const res = await fetch(url);

    const data = await res.json();

    renderizarProductos(data);
  } catch (err) {
    console.error(err);
  }
};

// Abrir Modal Producto
window.abrirModalProducto = function (
  id,
  nombre,
  precio,
  imagen,
  stock,
  colores,
  tallas,
  descripcion,
) {
  const modal = document.getElementById("modalProducto");
  const contenido = document.getElementById("modalProductoContenido");

  contenido.innerHTML = `
<div class="modal-producto-box">

  <span class="cerrar-modal">×</span>

  <div class="modal-top">

    <div class="modal-info">

      <h2>${nombre}</h2>

      <p class="precio">S/ ${precio}</p>

      <p><strong>Stock:</strong> ${stock}</p>

      <p><strong>Colores:</strong> ${colores || "No aplica"}</p>

      <p><strong>Tallas:</strong> ${tallas || "No aplica"}</p>

    </div>

    <div class="modal-image">
      <img 
        src="http://localhost:8080/imagenes/${imagen}" 
        class="modal-img"
      />
    </div>

  </div>

  <div class="modal-bottom">

    <p class="descripcion">
      ${descripcion || ""}
    </p>

    <button class="btn-agregar-modal">
      🛒 Agregar al carrito
    </button>

  </div>

</div>
`;

  // ✔ BUSCAR DENTRO DEL CONTENIDO
  const btnCerrar = contenido.querySelector(".cerrar-modal");

  if (btnCerrar) {
    btnCerrar.onclick = () => {
      modal.classList.remove("show");
    };
  }

  // ✔ BOTÓN AGREGAR
  const btnAgregar = contenido.querySelector(".btn-agregar-modal");

  if (btnAgregar) {
    btnAgregar.onclick = async (e) => {
      e.stopPropagation();

      const token = localStorage.getItem("token");

      if (!token) {
        modal.classList.remove("show");

        document.dispatchEvent(
          new CustomEvent("mostrarToast", {
            detail: {
              mensaje: "Inicia sesión o regístrate para continuar",
              tipo: "error",
            },
          }),
        );

        return;
      }

      await agregarAlCarrito(id);

      // actualizar badge
      document.dispatchEvent(new Event("carritoActualizado"));

      // toast
      document.dispatchEvent(
        new CustomEvent("mostrarToast", {
          detail: {
            mensaje: "Producto agregado 🛒",
            tipo: "success",
          },
        }),
      );

      setTimeout(() => {
        modal.classList.remove("show");
      }, 300);
    };
  }

  modal.classList.add("show");
};
