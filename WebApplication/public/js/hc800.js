// js/hc800.js
import { db } from "./firebase-config.js";
import { doc, getDoc, collection, query, where, orderBy, limit, getDocs } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

// Utility: extract shopId from query string
function getShopIdFromURL() {
    const params = new URLSearchParams(window.location.search);
    return params.get("shopId");
}

document.addEventListener("DOMContentLoaded", async () => {
    const shopId = getShopIdFromURL();
    if (!shopId) {
        alert("No shop ID provided.");
        return;
    }

    try {
        const shopRef = doc(db, "shops", shopId);
        const shopSnap = await getDoc(shopRef);
        if (!shopSnap.exists()) throw new Error("Shop not found.");

        const shopName = shopSnap.data().name || "Unknown Shop";
        document.querySelector(".header").textContent = shopName;

        const formsRef = collection(db, "h800_forms");
        const q = query(
            formsRef,
            where("shopId", "==", shopRef),
            orderBy("submittedAt", "desc"),
            limit(3)
        );
        const formSnaps = await getDocs(q);

        const inspections = [];
        formSnaps.forEach(doc => inspections.push(doc.data()));
        inspections.reverse(); // show oldest on left

        renderInspectionTable(inspections);
    } catch (err) {
        console.error("Error loading data:", err);
    }
});

// Fixed inspection fields mapping
const inspectionFields = [
    { label: "1.1 Suitability for the business", key: "suitabilityForBusiness" },
    { label: "1.2 General cleanliness & tidiness", key: "generalCleanliness" },
    { label: "1.3 Polluting conditions", key: "hasPollutingConditions" },
    { label: "1.4 Dogs/Cats/Other animals", key: "hasAnimals" },
    { label: "1.5 Smoke or other adverse effects", key: "hasSmokeOrAdverseEffects" },
    { label: "2.1 Nature of the building", key: "natureOfBuilding" },
    { label: "2.2 Space", key: "space" },
    { label: "2.3 Light and ventilation", key: "lightAndVentilation" },
    { label: "2.4 Condition of the floor", key: "conditionOfFloor" },
    { label: "2.5 Condition of the wall", key: "conditionOfWall" },
    { label: "2.6 Condition of the ceiling", key: "conditionOfCeiling" },
    { label: "2.7 Hazards to employees/customers", key: "hasHazards" },
];

function renderInspectionTable(forms) {
    const table = document.querySelector(".inspection-table");
  
    // Set column headers
    const thead = table.querySelector("thead tr");
    for (let form of forms) {
      const th = document.createElement("th");
      const date = form.submittedAt.toDate();
      th.textContent = date.toISOString().split("T")[0];
      thead.appendChild(th);
    }
  
    // Clear tbody
    const tbody = table.querySelector("tbody");
    tbody.innerHTML = "";
  
    // Group questions by part
    let currentPart = "";
    for (let field of inspectionFields) {
      if (field.part !== currentPart) {
        currentPart = field.part;
        const headerRow = document.createElement("tr");
        headerRow.classList.add("section-header");
        const headerCell = document.createElement("td");
        headerCell.colSpan = 4;
        headerCell.textContent = currentPart;
        headerRow.appendChild(headerCell);
        tbody.appendChild(headerRow);
      }
  
      const row = document.createElement("tr");
      const labelCell = document.createElement("td");
      labelCell.textContent = field.label;
      row.appendChild(labelCell);
  
      for (let form of forms) {
        const td = document.createElement("td");
        td.textContent = form[field.key] || "N/A";
        row.appendChild(td);
      }
  
      tbody.appendChild(row);
    }
  }
  