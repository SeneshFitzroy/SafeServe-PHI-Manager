document.addEventListener("DOMContentLoaded", () => {
    const nameEl = document.querySelector(".user-name");
    const roleEl = document.querySelector(".user-role");
  
    const name = sessionStorage.getItem("userFullName");
    const role = sessionStorage.getItem("userRole");
  
    if (nameEl) nameEl.innerText = name || "Unknown User";
    if (roleEl) roleEl.innerText = role || "Unknown Role";
  });
  