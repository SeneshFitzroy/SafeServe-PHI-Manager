const role = sessionStorage.getItem("userRole");
const path = window.location.pathname.split("/").pop();

if (!role) {
  window.location.href = "login.html"; // Only guard after login
} else {
  const SPHI_ALLOWED = ["Dashboard.html", "Registration.html", "PHIinformation.html"];
  const PHI_BLOCKED = ["Registration.html"];

  if (role === "SPHI" && !SPHI_ALLOWED.includes(path)) {
    window.location.href = "Dashboard.html";
  }

  if (role === "PHI" && PHI_BLOCKED.includes(path)) {
    window.location.href = "Dashboard.html";
  }
}
