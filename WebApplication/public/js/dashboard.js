// js/dashboard.js
import { auth, db } from "./firebase-config.js";
import {
  onAuthStateChanged,
  signOut
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";

import {
  doc,
  getDoc,
  collection,
  getDocs,
  query,
  where,
  Timestamp
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
      await loadMonthlyInspections();
      await loadUpcomingInspections();

      // TODO: Add remaining steps here...
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

// 📊 Daily Inspection Chart
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
          title: { display: true, text: "Day" },
          grid: { display: true, drawBorder: false }
        },
        y: {
          title: { display: true, text: "Inspection Rate" },
          beginAtZero: true,
          grid: { drawBorder: false }
        }
      },
      plugins: {
        legend: { display: false },
        tooltip: { enabled: true }
      }
    }
  });
}

// 🥧 Risk Level Doughnut Chart
function renderRiskLevelChart(data = [60, 20, 10, 10]) {
  const ctxPie = document.getElementById("riskLevelsChart").getContext("2d");
  new Chart(ctxPie, {
    type: "doughnut",
    data: {
      labels: ["Grade A", "Grade B", "Grade C", "Grade D"],
      datasets: [{
        data: data,
        backgroundColor: [
          "rgba(61, 185, 82, 1)",   // A
          "rgba(241, 215, 48, 1)",  // B
          "rgba(255, 133, 20, 1)",  // C
          "rgba(187, 31, 34, 1)"    // D
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
          labels: { usePointStyle: false, boxWidth: 15, padding: 15 }
        }
      }
    }
  });
}

document.addEventListener("DOMContentLoaded", () => {
  renderDailyInspectionChart(); // placeholder
  renderRiskLevelChart();       // placeholder
});

// 🔢 Load total shops
async function loadTotalShops() {
  try {
    const shopsRef = collection(db, "shops");
    const batchPromises = [];

    // Batch GN divisions (max 10 per 'in' clause)
    for (let i = 0; i < userGNDivisions.length; i += 10) {
      const batch = query(shopsRef, where("gnDivision", "in", userGNDivisions.slice(i, i + 10)));
      batchPromises.push(getDocs(batch));
    }

    const snapshots = await Promise.all(batchPromises);
    let totalCount = 0;
    snapshots.forEach(snap => totalCount += snap.size);

    document.querySelectorAll(".stat-card h3")[0].textContent = totalCount;
  } catch (err) {
    console.error("❌ Error loading total shops:", err);
  }
}

// 📆 Load inspections for current month
async function loadMonthlyInspections() {
    try {
      const formsRef = collection(db, "h800_forms");
      const firstOfMonth = Timestamp.fromDate(getStartOfMonthTimestamp());
  
      let inspectionCount = 0;
  
      if (userRole === "PHI") {
        const q = query(
          formsRef,
          where("phiId", "==", doc(db, "users", currentUser.uid))
        );
        const snapshot = await getDocs(q);
  
        // Filter by timestamp in JS
        const filtered = snapshot.docs.filter(doc => {
          const data = doc.data();
          return data.submittedAt?.toDate() >= firstOfMonth;
        });
  
        console.log("📄 Monthly Inspection Forms (PHI):", filtered);
        inspectionCount = filtered.length;
      }
  
      // (Optional) SPHI logic here if needed later
  
      // Update UI
      const h3s = document.querySelectorAll(".stat-card h3");
      if (h3s.length >= 2) {
        h3s[1].textContent = inspectionCount;
      }
    } catch (err) {
      console.error("❌ Error loading inspections:", err);
    }
  }
  

// 📅 Helper: Start of current month
function getStartOfMonthTimestamp() {
  const now = new Date();
  return new Date(now.getFullYear(), now.getMonth(), 1);
}


// 🕒 Step 3: Load Upcoming Inspections
async function loadUpcomingInspections() {
    try {
      const shopsRef = collection(db, "shops");
      const today = new Date();
  
      let upcomingCount = 0;
  
      // Handle batching for large GN division lists
      const batchPromises = [];
      for (let i = 0; i < userGNDivisions.length; i += 10) {
        const batch = query(shopsRef, where("gnDivision", "in", userGNDivisions.slice(i, i + 10)));
        batchPromises.push(getDocs(batch));
      }
  
      const snapshots = await Promise.all(batchPromises);
  
      snapshots.forEach(snap => {
        snap.forEach(doc => {
          const shop = doc.data();
          console.log("🏪 Shop:", shop.name || "Unnamed", "Upcoming:", shop.upcomingInspection);

          if (shop.upcomingInspection) {
            if (
                shop.upcomingInspection?.toDate &&
                shop.upcomingInspection.toDate() >= today
              ) {
                upcomingCount++;
              }
              
          }
        });
      });
  
      const h3s = document.querySelectorAll(".stat-card h3");
      if (h3s.length >= 3) {
        h3s[2].textContent = upcomingCount;
      }
  
    } catch (err) {
      console.error("❌ Error loading upcoming inspections:", err);
    }
  }
  