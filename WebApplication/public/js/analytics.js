// js/analytics.js
import { db, auth } from "./firebase-config.js";
import {
  collection,
  query,
  where,
  getDocs,
  doc,
  getDoc
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
      await loadHighRiskShops(user.uid);
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

  try {
    const formRef = collection(db, "h800_forms");
    const q = query(formRef, where("phiId", "==", phiUid));
    const querySnapshot = await getDocs(q);

    let totalCount = 0;

    querySnapshot.forEach(docSnap => {
      const data = docSnap.data();
      const date = data.submittedAt?.toDate?.();

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

// Loads high-risk shops (grade C or D in assigned GN Divisions)
async function loadHighRiskShops(phiUid) {
  try {
    const userDoc = await getDoc(doc(db, "users", phiUid));
    if (!userDoc.exists()) {
      console.warn("⚠️ PHI user document not found");
      return;
    }

    const gnDivisions = userDoc.data().gnDivisions || [];
    if (!Array.isArray(gnDivisions) || gnDivisions.length === 0) {
      console.warn("⚠️ No GN Divisions found for PHI");
      return;
    }

    const shopsRef = collection(db, "shops");
    const q = query(
      shopsRef,
      where("gnDivision", "in", gnDivisions),
      where("grade", "in", ["C", "D"])
    );

    const snapshot = await getDocs(q);
    const shopListContainer = document.querySelector("#High-Risk\\ Level\\ Shops .content-container");
    shopListContainer.innerHTML = "";

    snapshot.forEach((docSnap) => {
      const shop = docSnap.data();

      const lastInspections = shop.lastInspection || [];
      const latestInspectionDate = lastInspections.length > 0
        ? lastInspections[lastInspections.length - 1].toDate().toLocaleDateString()
        : "N/A";

      const upcoming = shop.upcomingInspection?.toDate?.().toLocaleDateString() || "N/A";

      const row = document.createElement("div");
      row.className = "content-row";

      row.innerHTML = `
        <p class="element-1">${shop.referenceNo || "-"}</p>
        <p class="element-2">${shop.name || "-"}</p>
        <p class="element-3">${shop.gnDivision || "-"}</p>
        <p class="element-4">${latestInspectionDate}</p>
        <p class="element-5">${upcoming}</p>
      `;

      shopListContainer.appendChild(row);
    });

  } catch (err) {
    console.error("❌ Failed to load high-risk shops:", err);
  }
}
