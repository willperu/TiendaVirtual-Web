function esAdmin(token) {
  try {
    const payload = JSON.parse(atob(token.split(".")[1]));
    return (payload.rol || "").toUpperCase() === "ADMIN";
  } catch {
    return false;
  }
}

document.addEventListener("DOMContentLoaded", () => {
  const API = "http://localhost:8080/api";
  const token = localStorage.getItem("token");

  if (!token || !esAdmin(token)) {
    window.location.href = "login.html";
    return;
  }

  const tablaBody = document.getElementById("tablaVentas");
  const inputFecha = document.getElementById("buscarFecha");
  const btnBuscar = document.getElementById("btnBuscarFecha");

  let ventasGlobal = [];

  /* ================== LOGOUT ================== */
  document.getElementById("logoutBtn")?.addEventListener("click", () => {
    localStorage.removeItem("token");
    window.location.href = "login.html";
  });

  /* ================== FORMATEAR FECHA ================== */
  function formatearFecha(fecha) {
    return new Date(fecha).toLocaleString();
  }

  function obtenerFechaSimple(fecha) {
    return new Date(fecha).toLocaleDateString();
  }

  /* ================== AGRUPAR ================== */
  function agruparPorFecha(ventas) {
    return ventas.reduce((acc, v) => {
      const fecha = obtenerFechaSimple(v.fecha);

      if (!acc[fecha]) acc[fecha] = [];
      acc[fecha].push(v);

      return acc;
    }, {});
  }

  /* ================== RENDER ================== */
  function renderVentas(ventas) {
    tablaBody.innerHTML = "";

    const agrupadas = agruparPorFecha(ventas);

    Object.keys(agrupadas)

      .sort((a, b) => {
        const [d1, m1, y1] = a.split("/");
        const [d2, m2, y2] = b.split("/");

        const fechaA = new Date(`${y1}-${m1}-${d1}`);
        const fechaB = new Date(`${y2}-${m2}-${d2}`);

        return fechaB - fechaA; // 🔥 más reciente primero
      })
      .forEach((fecha) => {
        const grupoClase = "grupo-" + fecha.replace(/\//g, "-");

        const totalDia = agrupadas[fecha].reduce((acc, v) => acc + v.total, 0);

        // 🔥 HEADER (clicable)
        const header = document.createElement("tr");
        header.classList.add("header-fecha");
        header.dataset.fecha = fecha;

        header.innerHTML = `
        <td colspan="5" style="background:#f5f5f5; font-weight:bold;">
          📅 ${fecha} — Total: S/ ${totalDia}
        </td>
      `;

        tablaBody.appendChild(header);

        // 🔽 FILAS (ocultas por defecto)
        agrupadas[fecha].forEach((v) => {
          const productos =
            v.detalles
              ?.map((d) => `${d.producto.nombre} x${d.cantidad}`)
              .join("<br>") || "N/A";

          const cantidadTotal =
            v.detalles?.reduce((acc, d) => acc + d.cantidad, 0) || 0;

          const row = document.createElement("tr");
          row.classList.add(grupoClase);
          row.style.display = "none";

          row.innerHTML = `
            <td>${v.id}</td>
            <td>${productos}</td>
            <td>${cantidadTotal}</td>
            <td>S/ ${v.total}</td>
            <td>${formatearFecha(v.fecha)}</td>
          `;

          tablaBody.appendChild(row);
        });
      });
  }

  /* ================== CLICK EN FECHA ================== */
  tablaBody.addEventListener("click", (e) => {
    const header = e.target.closest(".header-fecha");
    if (!header) return;

    const fecha = header.dataset.fecha;
    const clase = "grupo-" + fecha.replace(/\//g, "-");

    // 🔥 cerrar todos primero (solo uno abierto)
    document.querySelectorAll("[class^='grupo-']").forEach((row) => {
      row.style.display = "none";
    });

    // 🔥 abrir seleccionado
    document.querySelectorAll("." + clase).forEach((row) => {
      row.style.display = "";
    });
  });

  /* ================== BUSCAR POR FECHA ================== */
  btnBuscar?.addEventListener("click", () => {
    const input = inputFecha.value;
    if (!input) return;

    const fechaBuscada = new Date(input).toLocaleDateString();

    const filtradas = ventasGlobal.filter(
      (v) => obtenerFechaSimple(v.fecha) === fechaBuscada,
    );

    renderVentas(filtradas);
  });

  /* ================== CARGAR ================== */
  async function cargarVentas() {
    try {
      const res = await fetch(`${API}/ventas`, {
        headers: { Authorization: "Bearer " + token },
      });

      if (!res.ok) throw new Error("Error cargando ventas");

      const data = await res.json();
      ventasGlobal = data;

      renderVentas(ventasGlobal);
    } catch (err) {
      console.error(err);
      alert("No se pudieron cargar las ventas.");
    }
  }

  /* ================== INIT ================== */
  cargarVentas();
});
