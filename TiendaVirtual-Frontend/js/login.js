document.addEventListener("DOMContentLoaded", () => {
  const API = "http://localhost:8080/api/auth";
  const form = document.getElementById("loginForm");

  if (!form) return;

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();

    // 🔴 Validación básica
    if (!username || !password) {
      mostrarToast("Por favor completa todos los campos", "error");
      return;
    }

    try {
      const res = await fetch(`${API}/login`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          usuario: username,
          password: password,
        }),
      });

      // 🔴 Manejo de errores HTTP
      if (!res.ok) {
        if (res.status === 401 || res.status === 403) {
          mostrarToast("Usuario o contraseña incorrectos", "error");
        } else {
          mostrarToast(`Error del servidor: ${res.status}`, "error");
        }
        return;
      }

      const data = await res.json();
      console.log("LOGIN RESPONSE:", data);

      // 🔴 Validar token
      if (!data.token) {
        mostrarToast("No se recibió token de autenticación", "error");
        return;
      }

      // ✅ Guardar token
      localStorage.setItem("token", data.token);

      // ✅ Guardar rol
      localStorage.setItem("rol", data.rol);

      console.log("TOKEN:", data.token);
      console.log("ROL:", data.rol);

      // 🔥 REDIRECCIÓN INTELIGENTE
      const redirect = localStorage.getItem("redirectAfterLogin");

      if (redirect === "carrito") {
        window.location.href = "tienda.html";
      } else {
        if (data.rol === "ADMIN") {
          window.location.href = "dashboard.html";
        } else {
          window.location.href = "tienda.html";
        }
      }

      // ✅ SOLO UNA NOTIFICACIÓN
      mostrarToast("Login exitoso 🎉", "success");

      // 🔥 Redirección (CLAVE)
      setTimeout(() => {
        if (data.rol === "ADMIN") {
          window.location.href = "dashboard.html";
        } else {
          window.location.href = "tienda.html";
        }
      }, 1000);
    } catch (error) {
      console.error("Error al conectar con el servidor:", error);
      mostrarToast("No se pudo conectar con el servidor", "error");
    }
  });
});

// ------------------------------
// 🔔 TOAST (notificaciones)
// ------------------------------
function mostrarToast(mensaje, tipo = "info") {
  const container = document.getElementById("toast-container");
  if (!container) return;

  const toast = document.createElement("div");
  toast.classList.add("toast", tipo);
  toast.innerText = mensaje;
  container.appendChild(toast);

  setTimeout(() => toast.remove(), 3000);
}
