import { API } from "./config.js";
import { agregarAlCarrito } from "./carrito.js";

// 🔥 RENDERIZAR PRODUCTOS
function renderizarProductos(data) {
  console.log("LISTA DE PRODUCTOS:", data);

  const cont = document.getElementById("productos");
  if (!cont) return;

  cont.innerHTML = "";

  data.forEach((p) => {
    console.log("IMAGEN:", p.imagen);

    const card = document.createElement("div");
    card.className = "producto";

    card.dataset.id = p.id;
    card.dataset.nombre = p.nombre;
    card.dataset.precio = p.precio;
    card.dataset.imagen = p.imagen;
    card.dataset.stock = p.stock;
    card.dataset.colores = p.colores;
    card.dataset.tallas = p.tallas;
    card.dataset.descripcion = p.descripcion;

    const img = document.createElement("img");

    //const url = `http://localhost:8080/imagenes/${p.imagen}`;  //LOCAL
    `/imagenes/${p.imagen}`; //RAILWAY
    console.log("URL IMAGEN:", url);

    img.src = url;

    img.onerror = () => {
      // img.src = "http://localhost:8080/imagenes/default.png"; //LOCAL
      img.src = "/imagenes/default.png"; // RAILWAY
    };

    const title = document.createElement("h3");
    title.textContent = p.nombre;

    const price = document.createElement("p");
    price.innerHTML = `<strong>S/ ${p.precio}</strong>`;

    const btn = document.createElement("button");
    btn.className = "btn-ver-producto";
    btn.textContent = "👁 Ver producto";

    const abrirModal = () => {
      abrirModalProducto(
        p.id,
        p.nombre,
        p.precio,
        p.imagen,
        p.stock,
        p.colores,
        p.tallas,
        p.descripcion,
      );
    };

    card.addEventListener("click", abrirModal);
    btn.addEventListener("click", (e) => {
      e.stopPropagation();
      abrirModal();
    });

    card.appendChild(img);
    card.appendChild(title);
    card.appendChild(price);
    card.appendChild(btn);

    cont.appendChild(card);
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
        src="/imagenes/${imagen}" 
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
  // src="http://localhost:8080/imagenes/${imagen}" //LOCAL

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
