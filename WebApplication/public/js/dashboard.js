// js/dashboard.js
import { auth, db } from "./firebase-config.js";
import {
  onAuthStateChanged,
  signOut
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";

import {
  doc,
  getDoc
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

// Globals
let currentUser = null;
let userRole = "";
let userGNDivisions = [];

onAuthStateChanged(auth, async (user) => {
  if (user) {
    currentUser = user;
    const userRef = doc(db, "users", user.uid);
    const userSnap = await getDoc(userRef);

    if (userSnap.exists()) {
      const userData = userSnap.data();
      userRole = userData.role;
      userGNDivisions = userData.gnDivisions || [];

      console.log("✅ Logged in as:", userRole);
      console.log("📍 Assigned GN Divisions:", userGNDivisions);

      await loadTotalShops();


      // Next: Load dynamic dashboard data
    } else {
      console.error("❌ User document not found in Firestore");
    }
  } else {
    console.warn("⚠️ User not authenticated");
    window.location.href = "login.html";
  }
});

// 🔐 Logout handler
window.logoutUser = function (e) {
  e.preventDefault();
  signOut(auth)
    .then(() => {
      sessionStorage.clear();
      window.location.href = "login.html";
    })
    .catch((error) => {
      console.error("Logout failed:", error);
    });
};

// 📊 Daily Inspection Line Chart (Placeholder until replaced with real data)
function renderDailyInspectionChart(labels = ["01", "02", "03", "04", "05", "06", "07"], data = [45, 15, 80, 20, 10, 35, 30]) {
  const ctx = document.getElementById("dailyInspectionChart").getContext("2d");
  new Chart(ctx, {
    type: "line",
    data: {
      labels: labels,
      datasets: [{
        label: "Daily Inspection Rate",
        data: data,
        borderColor: "#2B50FF",
        backgroundColor: "rgba(43, 80, 255, 0.2)",
        borderWidth: 2,
        pointRadius: 5,
        pointBackgroundColor: "#85C1E9",
        tension: 0.4
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        x: {
          title: {
            display: true,
            text: "Day"
          },
          grid: {
            display: true,
            drawBorder: false
          }
        },
        y: {
          title: {
            display: true,
            text: "Inspection Rate"
          },
          beginAtZero: true,
          grid: {
            drawBorder: false
          }
        }
      },
      plugins: {
        legend: { display: false },
        tooltip: { enabled: true }
      }
    }
  });
}

// 🥧 Risk Levels Doughnut Chart (Placeholder)
function renderRiskLevelChart(data = [60, 20, 10, 10]) {
  const ctxPie = document.getElementById("riskLevelsChart").getContext("2d");
  new Chart(ctxPie, {
    type: "doughnut",
    data: {
      labels: ["Grade A", "Grade B", "Grade C", "Grade D"],
      datasets: [{
        data: data,
        backgroundColor: [
          "rgba(61, 185, 82, 1)",   // A - Green
          "rgba(241, 215, 48, 1)",  // B - Yellow
          "rgba(255, 133, 20, 1)",  // C - Orange
          "rgba(187, 31, 34, 1)"    // D - Red
        ],
        borderColor: [
          "rgba(61, 185, 82, 1)",
          "rgba(241, 215, 48, 1)",
          "rgba(255, 133, 20, 1)",
          "rgba(187, 31, 34, 1)"
        ],
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      cutout: "45%",
      plugins: {
        legend: {
          display: true,
          position: "bottom",
          labels: {
            usePointStyle: false,
            boxWidth: 15,
            padding: 15
          }
        },
        title: { display: true }
      }
    }
  });
}

// Example trigger (temporary)
document.addEventListener("DOMContentLoaded", () => {
  renderDailyInspectionChart(); // Sample values
  renderRiskLevelChart();       // Sample values
});


import {
    collection,
    getDocs,
    query,
    where
  } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";
  
  // 🔢 Step 2: Load total shops count
  async function loadTotalShops() {
    try {
      const shopsRef = collection(db, "shops");
  
      // Firestore doesn't support 'where in' with more than 10 items, so handle accordingly
      const batchPromises = [];
  
      // Split GN divisions into batches of 10
      const gnDivisionBatches = [];
      for (let i = 0; i < userGNDivisions.length; i += 10) {
        gnDivisionBatches.push(userGNDivisions.slice(i, i + 10));
      }
  
      gnDivisionBatches.forEach(batch => {
        const q = query(shopsRef, where("gnDivision", "in", batch));
        batchPromises.push(getDocs(q));
      });
  
      const snapshots = await Promise.all(batchPromises);
      let totalCount = 0;
      snapshots.forEach(snap => {
        totalCount += snap.size;
      });
  
      // Update the UI
      document.querySelectorAll(".stat-card h3")[0].textContent = totalCount;
    } catch (err) {
      console.error("❌ Error loading total shops:", err);
    }
  }
  