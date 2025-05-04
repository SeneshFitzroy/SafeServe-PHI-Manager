import { db, auth } from "./firebase-config.js";
import {
  collection,
  query,
  where,
  getDocs,
  doc
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

import {
  onAuthStateChanged
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";

document.addEventListener("DOMContentLoaded", () => {
  setupTabs();

  onAuthStateChanged(auth, async (user) => {
    if (user) {
      console.log("✅ Logged in UID:", user.uid);
      await loadYearlyInspectionData(user.uid);
    } else {
      console.warn("⚠️ User not authenticated.");
    }
  });
});

// Handles tab switching between reports
function setupTabs() {
  const navButtons = document.querySelectorAll(".report-nav button");
  const slides = document.querySelectorAll(".report-slide");

  navButtons.forEach((button) => {
    button.addEventListener("click", () => {
      const targetId = button.getAttribute("data-target");

      navButtons.forEach((btn) => btn.classList.remove("active"));
      button.classList.add("active");

      slides.forEach((slide) => {
        slide.classList.remove("active");
        if (slide.id === targetId) {
          slide.classList.add("active");
        }
      });
    });
  });
}

// Loads total inspections this year and updates chart
async function loadYearlyInspectionData(phiUid) {
    const currentYear = new Date().getFullYear();
    const monthlyCounts = Array(12).fill(0);
    const phiRef = doc(db, "users", phiUid); // Still correct
  
    try {
      const formRef = collection(db, "h800_forms");
      const q = query(formRef, where("userId", "==", phiRef)); // 👈 updated here
      const querySnapshot = await getDocs(q);
  
      let totalCount = 0;
  
      querySnapshot.forEach(docSnap => {
        const data = docSnap.data();
        console.log("📄 Form data:", data);
        console.log("All keys:", Object.keys(data));
  
        const date = data.Inspectiondate?.toDate?.();
        console.log("📅 Parsed Inspectiondate:", date);
  
        if (date && date.getFullYear() === currentYear) {
          totalCount++;
          const month = date.getMonth();
          monthlyCounts[month]++;
        }
      });
  
      updateChart(totalCount, monthlyCounts);
    } catch (error) {
      console.error("❌ Error loading inspections:", error);
    }
  }
  

// Updates total inspections text and bar chart
function updateChart(total, monthlyData) {
  const totalText = document.querySelector(".red-text");
  if (totalText) totalText.textContent = total;

  if (window.monthlyInspectionsChart) {
    window.monthlyInspectionsChart.data.datasets[0].data = monthlyData;
    window.monthlyInspectionsChart.update();
  }
}

// Init Chart.js bar chart with placeholder data
const ctx = document.getElementById('YearlyInspections').getContext('2d');
window.monthlyInspectionsChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ],
    datasets: [{
      label: 'Inspections',
      data: Array(12).fill(0), // default until loaded
      backgroundColor: '#007bff',
      borderRadius: 5,
      barPercentage: 0.6,
      categoryPercentage: 0.8
    }]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          precision: 0
        },
        grid: {
          display: false
        }
      },
      x: {
        grid: {
          display: false
        }
      }
    },
    plugins: {
      legend: {
        display: false
      }
    }
  }
});
