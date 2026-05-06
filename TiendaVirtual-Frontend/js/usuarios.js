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
        <td>${u.rol}</td>
        <td>
          <button onclick="editarUsuario(${u.id}, '${u.usuario}', '${u.rol}')">Editar</button>
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
  const usuario = {
    usuario: document.getElementById("usuarioInput").value,
    password: document.getElementById("passwordInput").value,
    rol: document.getElementById("rol").value,
  };

  let url = `${API}/usuarios`;
  let metodo = "POST";

  if (usuarioEditandoId) {
    url = `${API}/usuarios/${usuarioEditandoId}`;
    metodo = "PUT";
  }

  await fetch(url, {
    method: metodo,
    headers: {
      "Content-Type": "application/json",
      Authorization: "Bearer " + token,
    },
    body: JSON.stringify(usuario),
  });

  location.reload();
}

async function eliminarUsuario(id) {
  if (!confirm("¿Eliminar usuario?")) return;

  await fetch(`${API}/usuarios/${id}`, {
    method: "DELETE",

    headers: { Authorization: "Bearer " + token },
  });

  cargarUsuarios();
}

function editarUsuario(id, usuario, rol) {
  usuarioEditandoId = id;

  document.getElementById("usuarioInput").value = usuario;
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
