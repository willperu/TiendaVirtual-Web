const API = "http://localhost:8080/api";

const token = localStorage.getItem("token");

function esAdmin(token) {
  try {
    const payload = JSON.parse(atob(token.split(".")[1]));
    return payload.rol === "ADMIN";
  } catch {
    return false;
  }
}

if (!token || !esAdmin(token)) {
  window.location.href = "login.html";
}

let usuarioEditandoId = null;

function logout() {
  localStorage.removeItem("token");
  window.location.href = "login.html";
}

document.getElementById("logoutBtn").onclick = logout;

async function cargarUsuarios() {
  const response = await fetch(`${API}/usuarios`, {
    headers: { Authorization: "Bearer " + token },
  });

  const data = await response.json();

  const tabla = document.getElementById("tablaUsuarios");

  tabla.innerHTML = "";

  data.forEach((u) => {
    tabla.innerHTML += `
      <tr>
        <td>${u.id}</td>
        <td>${u.usuario}</td>
        <td>${u.email}</td>
        <td>${u.rol}</td>
        <td>
          <button onclick="editarUsuario(${u.id}, '${u.usuario}', '${u.email}', '${u.rol}')">Editar</button>
          <button onclick="eliminarUsuario(${u.id})">Eliminar</button>
        </td>
      </tr>
    `;
  });
}

function mostrarFormulario() {
  document.getElementById("nuevoUsuarioForm").style.display = "block";
}

async function guardarUsuario() {
  const email = document.getElementById("emailInput").value.trim();

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!emailRegex.test(email)) {
    alert("Email inválido");
    return;
  }

  const usuario = {
    usuario: document.getElementById("usuarioInput").value,
    password: document.getElementById("passwordInput").value,
    email: document.getElementById("emailInput").value,
    rol: document.getElementById("rol").value,
  };

  // 🔥 VALIDACIÓN AQUÍ
  if (!usuario.usuario || !usuario.password) {
    alert("Completa todos los campos");
    return;
  }

  let url = `${API}/usuarios`;
  let metodo = "POST";

  if (usuarioEditandoId) {
    url = `${API}/usuarios/${usuarioEditandoId}`;
    metodo = "PUT";
  }

  const response = await fetch(url, {
    method: metodo,
    headers: {
      "Content-Type": "application/json",
      Authorization: "Bearer " + token,
    },
    body: JSON.stringify(usuario),
  });

  // 🔥 LEER MENSAJE DEL BACKEND
  if (!response.ok) {
    const errorData = await response.json();

    alert(errorData.message);

    return;
  }

  usuarioEditandoId = null;

  document.getElementById("nuevoUsuarioForm").style.display = "none";

  document.getElementById("usuarioInput").value = "";
  document.getElementById("passwordInput").value = "";
  document.getElementById("emailInput").value = "";

  cargarUsuarios();
}

async function eliminarUsuario(id) {
  if (!confirm("¿Eliminar usuario?")) return;

  const res = await fetch(`${API}/usuarios/${id}`, {
    method: "DELETE",
    headers: {
      Authorization: "Bearer " + token,
    },
  });

  // 🔥 ERROR BACKEND
  if (!res.ok) {
    const msg = await res.text();

    alert(msg || "No se pudo eliminar el usuario");

    return;
  }

  alert("Usuario eliminado correctamente");

  cargarUsuarios();
}

function editarUsuario(id, usuario, email, rol) {
  usuarioEditandoId = id;

  document.getElementById("usuarioInput").value = usuario;
  document.getElementById("emailInput").value = email;
  document.getElementById("passwordInput").value = "";
  document.getElementById("rol").value = rol;

  document.getElementById("nuevoUsuarioForm").style.display = "block";
}

cargarUsuarios();
document.getElementById("nuevoUsuarioBtn").onclick = mostrarFormulario;
document.getElementById("guardarUsuarioBtn").onclick = guardarUsuario;

document.getElementById("cancelBtn").onclick = function () {
  document.getElementById("nuevoUsuarioForm").style.display = "none";
};
