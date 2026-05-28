const form = document.getElementById("resetPasswordForm");
const mensaje = document.getElementById("mensaje");

// Obtener token desde la URL
const params = new URLSearchParams(window.location.search);
const token = params.get("token");

form.addEventListener("submit", async (e) => {
  e.preventDefault();

  const newPassword = document.getElementById("newPassword").value;
  const verificationCode = document.getElementById("verificationCode").value;
  const confirmPassword = document.getElementById("confirmPassword").value;

  // Validar coincidencia
  if (newPassword !== confirmPassword) {
    mensaje.style.color = "red";
    mensaje.innerText = "Las contraseñas no coinciden.";

    return;
  }

  try {
    const response = await fetch(
      "http://localhost:8080/api/auth/reset-password",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },

        body: JSON.stringify({
          token: token,
          verificationCode: verificationCode,
          newPassword: newPassword,
        }),
      },
    );

    const data = await response.text();
    if (response.ok) {
      mensaje.style.color = "green";
      mensaje.innerHTML = `
        ✅ Contraseña actualizada correctamente.<br>
        Redirigiendo al login...
      `;

      form.reset();

      setTimeout(() => {
        window.location.href = "login.html";
      }, 3500);
    } else {
      mensaje.style.color = "red";
      mensaje.innerText = data;
    }
  } catch (error) {
    mensaje.style.color = "red";
    mensaje.innerText = "Error al conectar con el servidor.";

    console.error(error);
  }
});
