import { requireAuth, isAdmin, logout } from "./auth.js";
const API = "http://localhost:8080/api";

let chartVentas, chartProductos, chartUsuarios;

// ------------------------------
// 🔒 AUTH
// ------------------------------
function esAdmin(token) {
  try {
    const payload = JSON.parse(atob(token.split(".")[1]));

    const rol =
      payload.role || payload.roles || payload.authorities || payload.rol;

    if (!rol) return false;

    if (Array.isArray(rol)) {
      return rol.includes("ROLE_ADMIN") || rol.includes("ADMIN");
    }

    return String(rol).toUpperCase().includes("ADMIN");
  } catch {
    return false;
  }
}

// ------------------------------
// 🔐 FETCH CON TOKEN
// ------------------------------
async function fetchConToken(url, options = {}) {
  console.log("TOKEN EN FETCH:", localStorage.getItem("token"));
  const token = localStorage.getItem("token");

  if (!token) {
    logout();
    return;
  }

  options.headers = {
    ...options.headers,
    Authorization: "Bearer " + token,
    "Content-Type": "application/json",
  };

  const res = await fetch(url, options);

  if (res.status === 401) {
    logout();
    return;
  }

  if (!res.ok) {
    throw new Error("Error: " + res.status);
  }

  return res.json();
}

// ------------------------------
// 📊 DASHBOARD
// ------------------------------
async function cargarDashboard() {
  try {
    const filtro = document.getElementById("filtroFecha")?.value || 7;

    console.log("FILTRO ACTUAL:", filtro);

    const resumen = await fetchConToken(
      `${API}/dashboard/resumen?dias=${filtro}`,
    );

    animarNumero(document.getElementById("ventasHoy"), resumen?.ventasHoy ?? 0);
    animarNumero(
      document.getElementById("ventasTotales"),
      resumen?.ventasTotales ?? 0,
    );
    animarEntero(
      document.getElementById("stockBajo"),
      resumen?.productosStockBajo ?? 0,
    );

    document.getElementById("productoMasVendido").innerText =
      resumen?.productoMasVendido || "-";

    const ventasPorDia = await fetchConToken(
      `${API}/dashboard/ventas-por-dia?dias=${filtro}`,
    );

    if (chartVentas) {
      chartVentas.destroy();
      chartVentas = null;
    }

    const ctxVentas = document.getElementById("ventasChart");

    if (ctxVentas) {
      chartVentas = new Chart(ctxVentas, {
        type: "line",
        data: {
          labels: ventasPorDia.map((v) => v.fecha),
          datasets: [
            {
              label: `Ventas (${filtro} días)`,
              //label: "Ventas",
              data: ventasPorDia.map((v) => v.total),
              borderColor: "#4caf50",
              fill: true,
            },
          ],
        },
      });
    }

    const topProductos = await fetchConToken(
      `${API}/dashboard/top-productos?dias=${filtro}`,
    );

    const ctxProd = document.getElementById("topProductosChart");

    if (ctxProd) {
      if (chartProductos) {
        chartProductos.destroy();
        chartProductos = null;
      }

      chartProductos = new Chart(ctxProd, {
        type: "bar",
        data: {
          labels: topProductos.map((p) => p.producto),
          datasets: [
            {
              data: topProductos.map((p) => p.vendidos),
              backgroundColor: "#2196f3",
            },
          ],
        },
      });
    }

    const ventasUsuario = await fetchConToken(
      `${API}/dashboard/ventas-por-usuario`,
    );

    const ctxUsr = document.getElementById("ventasUsuarioChart");

    if (ctxUsr) {
      if (chartUsuarios) {
        chartUsuarios.destroy();
        chartUsuarios = null;
      }

      chartUsuarios = new Chart(ctxUsr, {
        type: "pie",
        data: {
          labels: ventasUsuario.map((v) => v.usuario),
          datasets: [
            {
              data: ventasUsuario.map((v) => v.total),
              backgroundColor: ventasUsuario.map(
                (_, i) => `hsl(${i * 60},70%,60%)`,
              ),
            },
          ],
        },
      });
    }
  } catch (error) {
    console.error("Error dashboard:", error);
  }
}

// ------------------------------
// 🚀 INIT
// ------------------------------
document.addEventListener("DOMContentLoaded", () => {
  const logoutBtn = document.getElementById("logoutBtn");

  if (logoutBtn) {
    logoutBtn.addEventListener("click", (e) => {
      e.preventDefault();
      logout();
    });
  }

  const filtroSelect = document.getElementById("filtroFecha");

  if (filtroSelect) {
    filtroSelect.addEventListener("change", () => {
      console.log("CAMBIANDO FILTRO...");
      cargarDashboard();
    });
  }

  cargarDashboard();
});

// ------------------------------
// 💰 FORMATO
// ------------------------------
function formatearMoneda(valor) {
  return new Intl.NumberFormat("es-PE", {
    style: "currency",
    currency: "PEN",
  }).format(valor);
}

// ------------------------------
// 🎯 ANIMACIONES
// ------------------------------
function animarNumero(el, valor, duracion = 1000) {
  if (!el) return;

  let inicio = 0;
  const inc = valor / (duracion / 16);

  const t = setInterval(() => {
    inicio += inc;

    if (inicio >= valor) {
      el.innerText = formatearMoneda(valor);
      clearInterval(t);
    } else {
      el.innerText = formatearMoneda(inicio);
    }
  }, 16);
}

function animarEntero(el, valor, duracion = 1000) {
  if (!el) return;

  let inicio = 0;
  const inc = valor / (duracion / 16);

  const t = setInterval(() => {
    inicio += inc;

    if (inicio >= valor) {
      el.innerText = valor;
      clearInterval(t);
    } else {
      el.innerText = Math.floor(inicio);
    }
  }, 16);
}
