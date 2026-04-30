document.addEventListener("DOMContentLoaded", () => {
  const API = "http://localhost:8080/api";
  const token = localStorage.getItem("token");

  if (!token) {
    window.location.href = "login.html";
    return;
  }

  // --- DOM ---
  const tablaBody = document.getElementById("tablaProductos");
  const formProducto = document.getElementById("formularioProducto");
  const productoIdInput = document.getElementById("productoId");
  const nombreInput = document.getElementById("nombre");
  const precioInput = document.getElementById("precio");
  const stockInput = document.getElementById("stock");
  const btnGuardar = formProducto?.querySelector("button");

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

      formProducto.style.display = "block";
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

    if (!nombre || isNaN(precio) || isNaN(stock)) {
      alert("Completa todos los campos correctamente.");
      return;
    }

    const producto = { nombre, precio, stock };

    const metodo = id ? "PUT" : "POST";
    const url = id ? `${API}/productos/${id}` : `${API}/productos`;

    try {
      const res = await fetch(url, {
        method: metodo,
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + token,
        },
        body: JSON.stringify(producto),
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
    logoutBtn.onclick = () => {
      localStorage.removeItem("token");
      window.location.href = "login.html";
    };
  }

  // --- init ---
  cargarProductos();
});
