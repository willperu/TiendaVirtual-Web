import { requireAuth, isAdmin, logout } from "./auth.js";

document.addEventListener("DOMContentLoaded", () => {
  //const API = "http://localhost:8080/api"; (LOCAL)
  const API = "https://tiendavirtual-web-production.up.railway.app/api";
  const token = localStorage.getItem("token");

  // 🔒 1. VALIDAR TOKEN
  if (!token) {
    window.location.href = "login.html";
    return;
  }

  // 🔒 2. VALIDAR ROL (SOLO ADMIN)
  try {
    const payload = JSON.parse(atob(token.split(".")[1]));

    const rol = payload.rol || payload.role || payload.roles;

    const isAdmin =
      rol === "ADMIN" ||
      rol === "ROLE_ADMIN" ||
      (Array.isArray(rol) && rol.includes("ROLE_ADMIN"));

    if (!isAdmin) {
      window.location.href = "login.html";
      return;
    }
  } catch (e) {
    console.error("Token inválido", e);
    window.location.href = "login.html";
    return;
  }

  // 🔓 SOLO ADMIN LLEGA AQUÍ

  // --- DOM ---
  const tablaBody = document.getElementById("tablaProductos");
  const formProducto = document.getElementById("formularioProducto");
  const productoIdInput = document.getElementById("productoId");
  const nombreInput = document.getElementById("nombre");
  const precioInput = document.getElementById("precio");
  const stockInput = document.getElementById("stock");
  const categoriaInput = document.getElementById("categoria");
  const descripcionInput = document.getElementById("descripcion");
  const coloresInput = document.getElementById("colores");
  const tallasInput = document.getElementById("tallas");
  const imagenInput = document.getElementById("imagenFile");

  // --- mostrar formulario ---
  window.mostrarFormulario = function () {
    productoIdInput.value = "";
    nombreInput.value = "";
    precioInput.value = "";
    stockInput.value = "";
    categoriaInput.value = "";

    descripcionInput.value = "";
    coloresInput.value = "";
    tallasInput.value = "";

    formProducto.style.display = "flex";
  };

  // ------ Cerrar Formulario --------
  window.cerrarFormulario = function () {
    formProducto.style.display = "none";
  };

  const btnGuardar = document.getElementById("btnGuardar");
  /*
  const btnGuardar = formProducto?.querySelector("button");
*/
  // --- cargar productos ---
  async function cargarProductos() {
    try {
      const res = await fetch(`${API}/productos`, {
        headers: { Authorization: "Bearer " + token },
      });

      if (!res.ok) throw new Error("Error cargando productos: " + res.status);

      const productos = await res.json();
      tablaBody.innerHTML = "";

      productos.forEach((p) => {
        tablaBody.innerHTML += `
          <tr ${p.stock <= 2 ? 'class="table-warning"' : ""}>
            <td>${p.id}</td>
            <td>${p.nombre}</td>
            <td>${p.categoria || "-"}</td>
            <td>${p.precio}</td>
            <td>${p.stock}</td>
            <td>
              <button class="btn btn-sm btn-primary" onclick="editarProducto(${p.id})">Editar</button>
              <button class="btn btn-sm btn-danger" onclick="eliminarProducto(${p.id})">Eliminar</button>
            </td>
          </tr>
        `;
      });
    } catch (error) {
      console.error(error);
      alert("No se pudieron cargar los productos.");
    }
  }

  // --- editar ---
  window.editarProducto = async function (id) {
    try {
      const res = await fetch(`${API}/productos/${id}`, {
        headers: { Authorization: "Bearer " + token },
      });

      if (!res.ok) throw new Error("Error al cargar producto");

      const p = await res.json();

      productoIdInput.value = p.id;
      nombreInput.value = p.nombre;
      precioInput.value = p.precio;
      stockInput.value = p.stock;
      categoriaInput.value = p.categoria;

      descripcionInput.value = p.descripcion || "";
      coloresInput.value = p.colores || "";
      tallasInput.value = p.tallas || "";

      formProducto.style.display = "flex";
    } catch (error) {
      console.error(error);
      alert("No se pudo cargar el producto.");
    }
  };

  // --- eliminar ---
  window.eliminarProducto = async function (id) {
    if (!confirm("¿Deseas eliminar este producto?")) return;

    try {
      const res = await fetch(`${API}/productos/${id}`, {
        method: "DELETE",
        headers: { Authorization: "Bearer " + token },
      });

      if (!res.ok) throw new Error("Error al eliminar producto");

      cargarProductos();
    } catch (error) {
      console.error(error);
      alert("No se pudo eliminar el producto.");
    }
  };

  // --- guardar ---
  async function guardarProducto() {
    const id = productoIdInput.value.trim();
    const nombre = nombreInput.value.trim();
    const precio = parseFloat(precioInput.value);
    const stock = parseInt(stockInput.value);
    const categoria = categoriaInput.value;

    if (!nombre || isNaN(precio) || isNaN(stock) || !categoria) {
      alert("Completa todos los campos correctamente.");
      return;
    }

    const formData = new FormData();

    formData.append("nombre", nombre);
    formData.append("precio", precio);
    formData.append("stock", stock);
    formData.append("categoria", categoria);

    formData.append("descripcion", descripcionInput.value);
    formData.append("colores", coloresInput.value);
    formData.append("tallas", tallasInput.value);

    // 🔥 IMAGEN
    if (imagenInput.files.length > 0) {
      formData.append("imagen", imagenInput.files[0]);
    }

    const metodo = id ? "PUT" : "POST";
    const url = id ? `${API}/productos/${id}` : `${API}/productos`;

    try {
      const res = await fetch(url, {
        method: metodo,
        headers: {
          Authorization: "Bearer " + token,
        },
        body: formData,
      });

      if (!res.ok) throw new Error("Error guardando producto");

      formProducto.style.display = "none";
      cargarProductos();
    } catch (error) {
      console.error(error);
      alert("No se pudo guardar el producto.");
    }
  }

  if (btnGuardar) btnGuardar.onclick = guardarProducto;

  // --- logout ---
  const logoutBtn = document.getElementById("logoutBtn");

  if (logoutBtn) {
    logoutBtn.addEventListener("click", (e) => {
      e.preventDefault();
      logout();
    });
  }

  // --- init ---
  cargarProductos();
});
