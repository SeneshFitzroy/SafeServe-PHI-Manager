document.addEventListener("DOMContentLoaded", () => {
    const role = sessionStorage.getItem("userRole");
  
    const access = {
      SPHI: ["Registration.html", "PHIinformation.html"],
      PHI: ["Dashboard.html", "Calendar.html", "InspectionLog.html", "Analytics.html", "PHIinformation.html"]
    };
  
    const allowedPages = access[role] || [];
  
    document.querySelectorAll("a[data-page]").forEach(link => {
      const page = link.getAttribute("data-page");
      const icon = link.getAttribute("data-icon");
      const img = link.querySelector("img");
  
      if (!allowedPages.includes(page)) {
        // 1. Prevent click
        link.addEventListener("click", (e) => e.preventDefault());
  
        // 2. Add visual style
        link.style.pointerEvents = "none";
        link.style.opacity = "0.6";
  
        
      }
    });
  });
  