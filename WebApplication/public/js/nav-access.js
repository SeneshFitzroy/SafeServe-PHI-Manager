document.addEventListener("DOMContentLoaded", () => {
    const role = sessionStorage.getItem("userRole");
  
    const access = {
      SPHI: ["Dashboard.html","Registration.html", "PHIinformation.html"],
      PHI: ["Dashboard.html", "Calendar.html", "InspectionLog.html", "Analytics.html", "PHIinformation.html"]
    };
  
    const allowedPages = access[role] || [];
  
    document.querySelectorAll("a[data-page]").forEach(link => {
      const page = link.getAttribute("data-page");
      const icon = link.getAttribute("data-icon");
      const img = link.querySelector("img");
  
      if (!allowedPages.includes(page)) {
        link.parentElement.removeChild(link); 
      }
    });
  });
  