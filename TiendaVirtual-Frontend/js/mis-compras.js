function obtenerToken() {
  return localStorage.getItem("token");
}

document.addEventListener("DOMContentLoaded", () => {
  //const API = "http://localhost:8080/api"; //LOCAL
  const API = "https://tiendavirtual-web-production.up.railway.app/api"; // Railway Producción
  const token = obtenerToken();

  if (!token) {
    window.location.href = "login.html";
    return;
  }

  const tabla = document.getElementById("tablaCompras");
  const filtroEstado = document.getElementById("filtroEstado");
  let comprasGlobal = [];

  /* ================== LOGOUT ================== */

  document.getElementById("logoutBtn")?.addEventListener("click", () => {
    localStorage.removeItem("token");
    window.location.href = "login.html";
  });

  /* ================== ABRIR CARRITO ================== */
  document.getElementById("abrirCarrito")?.addEventListener("click", () => {
    localStorage.setItem("abrirCarrito", "true");

    window.location.href = "tienda.html";
  });
  /* ================== FORMATEAR FECHA ================== */

  function formatearFecha(fecha) {
    return new Date(fecha).toLocaleString();
  }
  /* ================================ */
  function generarTimeline(estadoActual) {
    const estados = [
      "PENDIENTE",
      "PAGADO",
      "PREPARANDO",
      "ENVIADO",
      "EN_CAMINO",
      "ENTREGADO",
    ];

    const indexActual = estados.indexOf(estadoActual);

    return estados
      .map((estado, index) => {
        let clase = "timeline-step";

        if (index < indexActual) {
          clase += " active";
        } else if (index === indexActual) {
          clase += " current";
        }

        return `
      <div class="${clase}">
        ${estado}
      </div>
    `;
      })
      .join("");
  }

  /* =========Render Compras ========= */
  async function renderCompras(compras) {
    tabla.innerHTML = "";

    compras.sort((a, b) => new Date(b.fecha) - new Date(a.fecha));

    for (const v of compras) {
      const historial = await obtenerHistorial(v.id);

      const row = document.createElement("tr");

      row.innerHTML = `
        <td>${v.id}</td>
        <td>${formatearFecha(v.fecha)}</td>
        <td>S/ ${v.total}</td>

        <td>
          <span class="estado-badge estado-${v.estadoPedido}">
            ${v.estadoPedido}
          </span>
        </td>

        <td>
          <div class="timeline">
            ${historial
              .map(
                (h) => `
                  <div class="timeline-step ${h.estado.toLowerCase().replace("_", "-")}">
                    ${h.estado}
                    <br>

                    <small>
                      ${new Date(h.fecha).toLocaleString()}
                    </small>
                  </div>
                `,
              )
              .join("")}
          </div>
        </td>
      `;

      tabla.appendChild(row);
    }
  }

  /* ================== CARGAR COMPRAS ================== */

  async function cargarCompras() {
    try {
      const res = await fetch(`${API}/ventas/mis-compras`, {
        headers: {
          Authorization: "Bearer " + token,
        },
      });

      if (!res.ok) {
        throw new Error("Error cargando compras");
      }

      comprasGlobal = await res.json();

      const compras = [...comprasGlobal];

      await renderCompras(compras);
    } catch (err) {
      console.error(err);
      alert("No se pudieron cargar las compras");
    }
  }

  /* ==================== */
  async function obtenerHistorial(ventaId) {
    try {
      const res = await fetch(`${API}/ventas/${ventaId}/historial`, {
        headers: {
          Authorization: "Bearer " + token,
        },
      });

      if (!res.ok) {
        throw new Error("Error obteniendo historial");
      }

      return await res.json();
    } catch (err) {
      console.error(err);
      return [];
    }
  }
  /* ======================= */
  filtroEstado?.addEventListener("change", async () => {
    const estado = filtroEstado.value;

    console.log("Filtro:", estado);

    if (!estado) {
      await renderCompras(comprasGlobal);
      return;
    }

    const filtradas = comprasGlobal.filter((v) => v.estadoPedido === estado);

    await renderCompras(filtradas);
  });
  /* ================== INIT ================== */

  cargarCompras();
});
