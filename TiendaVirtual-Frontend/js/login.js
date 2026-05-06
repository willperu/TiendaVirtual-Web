// 🔒 FUNCIÓN GLOBAL
function esAdmin(token) {
  try {
    const payload = JSON.parse(atob(token.split(".")[1]));
    return (payload.rol || "").toUpperCase() === "ADMIN";
  } catch {
    return false;
  }
}

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

      // 🔴 Manejo de errores
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

      if (!data.token) {
        mostrarToast("No se recibió token", "error");
        return;
      }

      // 🔒 Guardar token
      localStorage.setItem("token", data.token);

      // 🔥 REDIRECCIÓN LIMPIA
      const redirect = localStorage.getItem("redirectAfterLogin");

      mostrarToast("Login exitoso 🎉", "success");

      setTimeout(() => {
        console.log("REDIRECT EJECUTANDO...");

        if (redirect) {
          console.log("REDIRECT A:", redirect);
          window.location.href = redirect;
          return;
        }

        console.log("TOKEN:", data.token);
        console.log("ES ADMIN:", esAdmin(data.token));

        if (esAdmin(data.token)) {
          console.log("IR A DASHBOARD");
          window.location.href = "dashboard.html";
        } else {
          console.log("IR A TIENDA");
          window.location.href = "tienda.html";
        }
      }, 800);
    } catch (error) {
      console.error("Error al conectar:", error);
      mostrarToast("No se pudo conectar con el servidor", "error");
    }
  });
});

// 🔔 TOAST
function mostrarToast(mensaje, tipo = "info") {
  const container = document.getElementById("toast-container");
  if (!container) return;

  const toast = document.createElement("div");
  toast.classList.add("toast", tipo);
  toast.innerText = mensaje;
  container.appendChild(toast);

  setTimeout(() => toast.remove(), 3000);
}
