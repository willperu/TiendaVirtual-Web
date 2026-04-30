const API = "http://localhost:8080/api";
console.log("🔥 dashboard.js cargado");

let chartVentas, chartProductos, chartUsuarios;

// ------------------------------
// Logout
// ------------------------------
function logout() {
  localStorage.removeItem("token");
  window.location.href = "login.html";
}

// ------------------------------
// Fetch con token y manejo de errores
// ------------------------------
async function fetchConToken(url, options = {}) {
  const token = localStorage.getItem("token");

  if (!token) {
    mostrarToast("Sesión expirada", "error");
    logout();
    return;
  }

  options.headers = {
    ...options.headers,
    Authorization: "Bearer " + token,
  };

  const res = await fetch(url, options);

  // 🔥 CLAVE
  if (res.status === 401) {
    mostrarToast("Sesión expirada, vuelve a iniciar sesión", "error");

    setTimeout(() => {
      logout();
    }, 1500);

    return;
  }

  if (!res.ok) {
    if (res.status === 403) {
      mostrarToast("No tienes permisos", "error");
    } else {
      mostrarToast("Error del servidor: " + res.status, "error");
    }
    throw new Error(`Error: ${res.status}`);
  }

  return res.json();
}

// ------------------------------
// Cargar dashboard
// ------------------------------
async function cargarDashboard() {
  try {
    // 🔹 Resumen
    const filtro = document.getElementById("filtroFecha").value;
    const resumen = await fetchConToken(
      `${API}/dashboard/resumen?dias=${filtro}`,
    );
    console.log("RESUMEN 👉", resumen);
    animarNumero(document.getElementById("ventasHoy"), resumen.ventasHoy ?? 0);

    animarNumero(
      document.getElementById("ventasTotales"),
      resumen.ventasTotales ?? 0,
    );

    animarEntero(
      document.getElementById("stockBajo"),
      resumen.productosStockBajo ?? 0,
    );
    document.getElementById("productoMasVendido").innerText =
      resumen.productoMasVendido?.trim() || "-";

    // 🔹 Gráfico: Ventas por día
    const ventasPorDia = await fetchConToken(
      `${API}/dashboard/ventas-por-dia?dias=${filtro}`,
    );
    const ctxVentas = document.getElementById("ventasChart").getContext("2d");

    if (chartVentas) chartVentas.destroy();

    chartVentas = new Chart(ctxVentas, {
      type: "line",
      data: {
        labels: ventasPorDia.map((v) => v.fecha),
        datasets: [
          {
            label: "Ventas por día",
            data: ventasPorDia.map((v) => v.total),
            borderColor: "#4caf50",
            backgroundColor: "rgba(76, 175, 80, 0.2)",
            fill: true,
            tension: 0.4,
            pointRadius: 4,
            pointHoverRadius: 6,
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          legend: { display: false },
          tooltip: {
            callbacks: {
              label: function (context) {
                return formatearMoneda(context.parsed.y);
              },
            },
          },
        },
        scales: {
          y: {
            ticks: {
              callback: function (value) {
                return formatearMoneda(value);
              },
            },
          },
        },
      },
    });

    // 🔹 Gráfico: Top productos
    const topProductos = await fetchConToken(
      `${API}/dashboard/top-productos?dias=${filtro}`,
    );
    const ctxTopProd = document
      .getElementById("topProductosChart")
      .getContext("2d");

    if (chartProductos) chartProductos.destroy();

    chartProductos = new Chart(ctxTopProd, {
      type: "bar",
      data: {
        labels: topProductos.map((p) => p.nombre),
        datasets: [
          {
            label: "Cantidad vendida",
            data: topProductos.map((p) => p.cantidad),
            backgroundColor: "#2196f3",
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          tooltip: {
            callbacks: {
              label: function (context) {
                return `${context.label}: ${formatearMoneda(context.parsed.y)}`;
              },
            },
          },
        },
        scales: {
          y: {
            ticks: {
              callback: function (value) {
                return formatearMoneda(value);
              },
            },
          },
        },
      },
    });

    // 🔹 Gráfico: Ventas por usuario
    const ventasPorUsuario = await fetchConToken(
      `${API}/dashboard/ventas-por-usuario?dias=${filtro}`,
    );
    const ctxVentasUsr = document
      .getElementById("ventasUsuarioChart")
      .getContext("2d");

    if (chartUsuarios) chartUsuarios.destroy();

    chartUsuarios = new Chart(ctxVentasUsr, {
      type: "pie",
      data: {
        labels: ventasPorUsuario.map((v) => v.usuario),
        datasets: [
          {
            label: "Ventas por usuario",
            data: ventasPorUsuario.map((v) => v.total),
            backgroundColor: ventasPorUsuario.map(
              (_, i) => `hsl(${i * 60}, 70%, 60%)`,
            ),
            borderColor: "#ffffff",
            borderWidth: 2,
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: "right",
            labels: {
              boxWidth: 20,
              padding: 15,
            },
          },
          tooltip: {
            callbacks: {
              label: function (context) {
                const total = context.parsed;
                return `${context.label}: ${formatearMoneda(total)}`;
              },
            },
          },
        },
      },
    });
  } catch (error) {
    console.error("Error cargando dashboard:", error);
  }
}

// ------------------------------
// Inicialización
// ------------------------------
document.addEventListener("DOMContentLoaded", () => {
  const token = localStorage.getItem("token");

  if (!token) {
    window.location.href = "login.html";
    return;
  }

  const logoutBtn = document.getElementById("logoutBtn");
  if (logoutBtn) logoutBtn.addEventListener("click", logout);

  // 🔥 NUEVO: detectar cambio de filtro
  const filtro = document.getElementById("filtroFecha");
  if (filtro) {
    filtro.addEventListener("change", cargarDashboard);
    setInterval(cargarDashboard, 5000);
  }

  cargarDashboard();
});

// Animar numero
function animarNumero(elemento, valorFinal, duracion = 1000) {
  let inicio = 0;
  const incremento = valorFinal / (duracion / 16);

  const timer = setInterval(() => {
    inicio += incremento;

    if (inicio >= valorFinal) {
      elemento.innerText = new Intl.NumberFormat("es-PE", {
        style: "currency",
        currency: "PEN",
      }).format(valorFinal);

      clearInterval(timer);
    } else {
      elemento.innerText = new Intl.NumberFormat("es-PE", {
        style: "currency",
        currency: "PEN",
      }).format(inicio);
    }
  }, 16);
}

// Animar entero
function animarEntero(elemento, valorFinal, duracion = 1000) {
  let inicio = 0;
  const incremento = valorFinal / (duracion / 16);

  const timer = setInterval(() => {
    inicio += incremento;

    if (inicio >= valorFinal) {
      elemento.innerText = valorFinal;
      clearInterval(timer);
    } else {
      elemento.innerText = Math.floor(inicio);
    }
  }, 16);
}

// Formatear moneda
function formatearMoneda(valor) {
  return new Intl.NumberFormat("es-PE", {
    style: "currency",
    currency: "PEN",
  }).format(valor);
}
