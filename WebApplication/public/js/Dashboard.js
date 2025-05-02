
// Handles dashboard functionality and chart data

import { auth } from "./firebase-config.js";
import { onAuthStateChanged } from "https://www.gstatic.com/firebasejs/9.22.0/firebase-auth.js";
import { 
  collection, 
  query, 
  where, 
  getDocs,
  Timestamp 
} from "https://www.gstatic.com/firebasejs/9.22.0/firebase-firestore.js";
import { db } from "./firebase-config.js";

document.addEventListener("DOMContentLoaded", async function() {
  // Initialize dashboard components
  initializeDashboard();
});

async function initializeDashboard() {
  try {
    // Load dashboard data
    await loadDashboardStats();
    
    // Initialize charts
    initDailyInspectionChart();
    initRiskLevelsChart();
  } catch (error) {
    console.error("Error initializing dashboard:", error);
  }
}

async function loadDashboardStats() {
  try {
    // Get dashboard stats elements
    const totalShopsElement = document.querySelector('.stat-card:nth-child(1) h3');
    const totalInspectionsElement = document.querySelector('.stat-card:nth-child(2) h3');
    const pendingInspectionsElement = document.querySelector('.stat-card:nth-child(3) h3');
    const highRiskShopsElement = document.querySelector('.stat-card:nth-child(4) h3');
    
    // Get the current month date range
    const now = new Date();
    const firstDay = new Date(now.getFullYear(), now.getMonth(), 1);
    const lastDay = new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59);
    
    // Total shops count
    const shopsQuery = query(collection(db, "shops"));
    const shopsSnapshot = await getDocs(shopsQuery);
    if (totalShopsElement) {
      totalShopsElement.textContent = shopsSnapshot.size;
    }
    
    // Total inspections this month
    const inspectionsQuery = query(
      collection(db, "inspections"),
      where("inspectionDate", ">=", Timestamp.fromDate(firstDay)),
      where("inspectionDate", "<=", Timestamp.fromDate(lastDay))
    );
    const inspectionsSnapshot = await getDocs(inspectionsQuery);
    if (totalInspectionsElement) {
      totalInspectionsElement.textContent = inspectionsSnapshot.size;
    }
    
    // Pending inspections this month
    const pendingQuery = query(
      collection(db, "inspections"),
      where("status", "==", "pending"),
      where("inspectionDate", ">=", Timestamp.fromDate(firstDay)),
      where("inspectionDate", "<=", Timestamp.fromDate(lastDay))
    );
    const pendingSnapshot = await getDocs(pendingQuery);
    if (pendingInspectionsElement) {
      pendingInspectionsElement.textContent = pendingSnapshot.size;
    }
    
    // High risk shops (Grade D)
    const highRiskQuery = query(
      collection(db, "shops"),
      where("riskGrade", "==", "D")
    );
    const highRiskSnapshot = await getDocs(highRiskQuery);
    if (highRiskShopsElement) {
      highRiskShopsElement.textContent = highRiskSnapshot.size;
    }
  } catch (error) {
    console.error("Error loading dashboard stats:", error);
  }
}

function initDailyInspectionChart() {
  const ctx = document.getElementById("dailyInspectionChart");
  if (!ctx) return;
  
  // Sample data for the chart (replace with real data from Firestore)
  const labels = ["01", "02", "03", "04", "05", "06", "07"];
  const data = [45, 15, 80, 20, 10, 35, 30];
  
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
        legend: {
          display: false
        },
        tooltip: {
          enabled: true
        }
      }
    }
  });
}

function initRiskLevelsChart() {
  const ctx = document.getElementById("riskLevelsChart");
  if (!ctx) return;
  
  // Sample data for the chart (replace with real data from Firestore)
  const labels = ["Grade A", "Grade B", "Grade C", "Grade D"];
  const data = [60, 20, 10, 10];
  
  new Chart(ctx, {
    type: "doughnut",
    data: {
      labels: labels,
      datasets: [{
        data: data,
        backgroundColor: [
          'rgba(61, 185, 82, 1)',   // Green (A)
          'rgba(241, 215, 48, 1)',  // Yellow (B)
          'rgba(255, 133, 20, 1)',  // Orange (C)
          'rgba(187, 31, 34, 1)',   // Red (D)
        ],
        borderColor: [
          'rgba(61, 185, 82, 1)',
          'rgba(241, 215, 48, 1)',
          'rgba(255, 133, 20, 1)',
          'rgba(187, 31, 34, 1)',
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
        title: {
          display: true
        }
      }
    }
  });
}