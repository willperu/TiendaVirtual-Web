const API = "http://localhost:8080/api/usuarios";

const form = document.getElementById("registroForm");

/* ================= REGISTRO ================= */

form.addEventListener("submit", async (e) => {
  e.preventDefault();

  const data = {
    usuario: document.getElementById("usuario").value,
    password: document.getElementById("password").value,
    email: document.getElementById("email").value,
    rol: "CLIENTE",
  };

  try {
    const res = await fetch(API, {
      method: "POST",

      headers: {
        "Content-Type": "application/json",
      },

      body: JSON.stringify(data),
    });

    if (!res.ok) {
      throw new Error("Error registrando usuario");
    }

    alert("Usuario creado correctamente ✅");

    window.location.href = "login.html";
  } catch (err) {
    console.error(err);

    alert("No se pudo registrar usuario");
  }
});

/* ================= CANCELAR ================= */

document.getElementById("btnCancelar")?.addEventListener("click", () => {
  window.location.href = "login.html";
});
