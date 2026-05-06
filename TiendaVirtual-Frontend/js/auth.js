export function getToken() {
  return localStorage.getItem("token");
}

export function logout() {
  localStorage.removeItem("token");
  window.location.href = "/login.html";
}

export function getPayload() {
  const token = getToken();
  if (!token) return null;

  try {
    return JSON.parse(atob(token.split(".")[1]));
  } catch {
    return null;
  }
}

export function isAdmin() {
  const payload = getPayload();
  return payload?.rol?.toUpperCase() === "ADMIN";
}

export function requireAuth() {
  const token = getToken();
  const payload = getPayload();

  if (!token || !payload) {
    logout();
    return false;
  }

  return true;
}
