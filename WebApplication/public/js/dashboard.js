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


let currentUser = null;
let userRole = "";
let userGNDivisions = [];
let dailyChartInstance = null;


onAuthStateChanged(auth, async (user) => {
  if (user) {
    currentUser = user;
    const userRef = doc(db, "users", user.uid);
    const userSnap = await getDoc(userRef);

    if (userSnap.exists()) {
      const userData = userSnap.data();
      userRole = userData.role;
      userGNDivisions = userData.gnDivisions || [];

      // Run core dashboard functions in parallel
      await Promise.all([
        loadTotalShops(),
        loadMonthlyInspections(),
        loadUpcomingInspections(),
        loadHighRiskShops()
      ]);

      // Delay heavy chart rendering slightly for UX smoothness
      setTimeout(() => {
        loadRiskLevelChart();
        loadWeeklyInspectionData();
      }, 200); // Adjust delay if needed 

    } else {
      console.error("User document not found in Firestore");
    }
  } else {
    console.warn("User not authenticated");
    window.location.href = "login.html";
  }
});

// Logout handling
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


// Daily Inspection Chart
function renderDailyInspectionChart(labels = [], data = []) {
    const ctx = document.getElementById("dailyInspectionChart").getContext("2d");
  
    if (dailyChartInstance) {
      dailyChartInstance.destroy();
    }
  
    dailyChartInstance = new Chart(ctx, {
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
  


// Risk Level Doughnut Chart
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
  renderDailyInspectionChart();
});




// Load total shops
async function loadTotalShops() {
  try {
    const shopsRef = collection(db, "shops");
    const batchPromises = [];

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




// Load inspections for current month
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
  
        const filtered = snapshot.docs.filter(doc => {
          const data = doc.data();
          return data.submittedAt?.toDate() >= firstOfMonth;
        });
  
        inspectionCount = filtered.length;
  
      } else if (userRole === "SPHI") {
        const usersRef = collection(db, "users");
        const phiBatchPromises = [];
  
        for (let i = 0; i < userGNDivisions.length; i += 10) {
          const batch = query(
            usersRef,
            where("gnDivisions", "array-contains-any", userGNDivisions.slice(i, i + 10)),
            where("role", "==", "PHI")
          );
          phiBatchPromises.push(getDocs(batch));
        }
  
        const phiSnapshots = await Promise.all(phiBatchPromises);
        const phiRefs = phiSnapshots.flatMap(snap => snap.docs.map(doc => doc.ref));
  
        const formBatchPromises = [];
        for (let i = 0; i < phiRefs.length; i += 10) {
          const batch = query(
            formsRef,
            where("phiId", "in", phiRefs.slice(i, i + 10))
          );
          formBatchPromises.push(getDocs(batch));
        }
  
        const formSnapshots = await Promise.all(formBatchPromises);
        const allForms = formSnapshots.flatMap(snap => snap.docs);
  
        const filtered = allForms.filter(doc => {
          const data = doc.data();
          return data.submittedAt?.toDate() >= firstOfMonth;
        });
  
        inspectionCount = filtered.length;
      }
  
      const h3s = document.querySelectorAll(".stat-card h3");
      if (h3s.length >= 2) {
        h3s[1].textContent = inspectionCount;
      }
    } catch (err) {
      console.error("Error loading monthly inspections:", err);
    }
  }
  

// Start of current month
function getStartOfMonthTimestamp() {
  const now = new Date();
  return new Date(now.getFullYear(), now.getMonth(), 1);
}




// Load Upcoming Inspections
async function loadUpcomingInspections() {
    try {
      const shopsRef = collection(db, "shops");
      const today = new Date();
  
      let upcomingCount = 0;
  
      const batchPromises = [];
      for (let i = 0; i < userGNDivisions.length; i += 10) {
        const batch = query(shopsRef, where("gnDivision", "in", userGNDivisions.slice(i, i + 10)));
        batchPromises.push(getDocs(batch));
      }
  
      const snapshots = await Promise.all(batchPromises);
  
      snapshots.forEach(snap => {
        snap.forEach(doc => {
          const shop = doc.data();

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
  



  async function loadHighRiskShops() {
    try {
      const shopsRef = collection(db, "shops");
      let highRiskCount = 0;
  
      const batchPromises = [];
      for (let i = 0; i < userGNDivisions.length; i += 10) {
        const batch = query(
          shopsRef,
          where("gnDivision", "in", userGNDivisions.slice(i, i + 10))
        );
        batchPromises.push(getDocs(batch));
      }
  
      const snapshots = await Promise.all(batchPromises);
      snapshots.forEach(snap => {
        snap.forEach(doc => {
          const grade = doc.data().grade?.toUpperCase();
          if (grade === "C" || grade === "D") {
            highRiskCount++;
          }
        });
      });
  
  
      const h3s = document.querySelectorAll(".stat-card h3");
      if (h3s.length >= 4) {
        h3s[3].textContent = highRiskCount;
      }
    } catch (err) {
      console.error("❌ Error loading high-risk shops:", err);
    }
  }
  



  async function loadRiskLevelChart() {
  try {
    const shopsRef = collection(db, "shops");
    let gradeCounts = { A: 0, B: 0, C: 0, D: 0 };

    const batchPromises = [];
    for (let i = 0; i < userGNDivisions.length; i += 10) {
      const batch = query(
        shopsRef,
        where("gnDivision", "in", userGNDivisions.slice(i, i + 10))
      );
      batchPromises.push(getDocs(batch));
    }

    const snapshots = await Promise.all(batchPromises);
    snapshots.forEach(snap => {
      snap.forEach(doc => {
        const grade = doc.data().grade?.toUpperCase();
        if (gradeCounts.hasOwnProperty(grade)) {
          gradeCounts[grade]++;
        }
      });
    });

    const chartData = [
      gradeCounts["A"],
      gradeCounts["B"],
      gradeCounts["C"],
      gradeCounts["D"]
    ];

    renderRiskLevelChart(chartData);
  } catch (err) {
    console.error("❌ Error loading risk level chart:", err);
  }
}




async function loadWeeklyInspectionData() {
    try {
      const formsRef = collection(db, "h800_forms");
      const startOfWeek = getStartOfWeekTimestamp();
      const endOfToday = new Date();
  
      let snapshot;
  
      if (userRole === "PHI") {
        const q = query(
          formsRef,
          where("phiId", "==", doc(db, "users", currentUser.uid))
        );
        snapshot = await getDocs(q);
      } else if (userRole === "SPHI") {
        const usersRef = collection(db, "users");
        const batchPromises = [];
        for (let i = 0; i < userGNDivisions.length; i += 10) {
          const batch = query(
            usersRef,
            where("gnDivisions", "array-contains-any", userGNDivisions.slice(i, i + 10)),
            where("role", "==", "PHI")
          );
          batchPromises.push(getDocs(batch));
        }
  
        const userSnapshots = await Promise.all(batchPromises);
        const phiRefs = userSnapshots.flatMap(snap => snap.docs.map(doc => doc.ref));
  
        if (phiRefs.length === 0) {
          renderDailyInspectionChart(); 
          return;
        }
  
        const formBatches = [];
        for (let i = 0; i < phiRefs.length; i += 10) {
          const batch = query(
            formsRef,
            where("phiId", "in", phiRefs.slice(i, i + 10))
          );
          formBatches.push(getDocs(batch));
        }
  
        const formSnapshots = await Promise.all(formBatches);
        snapshot = {
          docs: formSnapshots.flatMap(snap => snap.docs)
        };
      }
  
      const dayCounts = Array(7).fill(0);
  
      snapshot.docs.forEach(doc => {
        const data = doc.data();
        const submittedDate = data.submittedAt?.toDate();
  
        if (submittedDate && submittedDate >= startOfWeek && submittedDate <= endOfToday) {
          const dayIndex = submittedDate.getDay();
          dayCounts[dayIndex]++;
        }
      });
  
      const weekLabels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
      renderDailyInspectionChart(weekLabels, dayCounts);
    } catch (err) {
      console.error("❌ Error loading weekly inspections:", err);
    }
  }
  
function getStartOfWeekTimestamp() {
    const now = new Date();
    const dayOfWeek = now.getDay(); 
    return new Date(now.getFullYear(), now.getMonth(), now.getDate() - dayOfWeek);
  }
  