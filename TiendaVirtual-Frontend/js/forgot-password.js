const form = document.getElementById("forgotPasswordForm");
const mensaje = document.getElementById("mensaje");

form.addEventListener("submit", async (e) => {
  e.preventDefault();

  const email = document.getElementById("email").value;

  try {
    const response = await fetch(
      "http://localhost:8080/api/auth/forgot-password",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          email: email,
        }),
      },
    );

    const data = await response.text();

    // 🔴 SI HAY ERROR
    if (!response.ok) {
      mensaje.style.color = "red";
      mensaje.innerText = data;
      return;
    }
    // ✅ ÉXITO
    if (response.ok) {
      mensaje.style.color = "green";
      mensaje.innerText =
        "Solicitud enviada. Revisa tu correo o la consola del backend.";

      form.reset();
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
