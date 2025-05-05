import { db } from "./firebase-config.js";
import { doc, getDoc, collection, query, where, orderBy, limit, getDocs } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

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
            where("shopId", "==", shopRef)
        );
        const formSnaps = await getDocs(q);
        
        let inspections = [];
        formSnaps.forEach(doc => inspections.push(doc.data()));
        
        inspections.sort((a, b) => b.submittedAt.toDate() - a.submittedAt.toDate());
        
        inspections = inspections.slice(0, 3).reverse();

        renderInspectionTable(inspections); 


    } catch (err) {
        console.error("Error loading data:", err);
    }
});

const inspectionFields = [
    { part: "Part 1 - Location & Environment", label: "1.1 Suitability for the business", key: "suitabilityForBusiness" },
    { part: "Part 1 - Location & Environment", label: "1.2 General cleanliness & tidiness", key: "generalCleanliness" },
    { part: "Part 1 - Location & Environment", label: "1.3 Polluting conditions", key: "hasPollutingConditions" },
    { part: "Part 1 - Location & Environment", label: "1.4 Dogs/Cats/Other animals", key: "hasAnimals" },
    { part: "Part 1 - Location & Environment", label: "1.5 Smoke or other adverse effects", key: "hasSmokeOrAdverseEffects" },
  
    { part: "Part 2 - Building", label: "2.1 Nature of the building", key: "natureOfBuilding" },
    { part: "Part 2 - Building", label: "2.2 Space", key: "space" },
    { part: "Part 2 - Building", label: "2.3 Light and ventilation", key: "lightAndVentilation" },
    { part: "Part 2 - Building", label: "2.4 Condition of the floor", key: "conditionOfFloor" },
    { part: "Part 2 - Building", label: "2.5 Condition of the wall", key: "conditionOfWall" },
    { part: "Part 2 - Building", label: "2.6 Condition of the ceiling", key: "conditionOfCeiling" },
    { part: "Part 2 - Building", label: "2.7 Hazards to employees/customers", key: "hasHazards" },

    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.1 General cleanliness", key: "generalCleanlinessPart3" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.2 Safety measures for cleanliness", key: "safetyMeasuresForCleanliness" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.3 Flies", key: "hasFlies" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.4 Ants / Cockroaches / Rodents", key: "hasPests" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.5 Maintenance of floor", key: "hasFloor" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.6 Maintenance of walls", key: "maintenanceOfWalls" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.7 Maintenance of ceiling", key: "maintenanceOfCeilingPart3" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.8 Space in the working area", key: "spaceInWorkingArea" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.9 Daily cleaning", key: "dailyCleaning" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.10 Risk of contamination from toilets", key: "riskOfContaminationFromToilets" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.11 Adequate bins with lids", key: "adequateBins" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.12 Unnecessary items", key: "hasUnnecessaryItems" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.13 Availability of cleaning tools", key: "cleaningToolsAvailable" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.14 Objectionable odor", key: "hasObjectionableOdor" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.15 Open drains / stagnated wastewater", key: "hasOpenDrains" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.16 Area used for sleeping", key: "areaUsedForSleeping" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.17 Use of separate chopping boards", key: "separateChoppingBoards" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.18 Cleanliness of equipment", key: "cleanlinessOfEquipment" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.19 Suitability of layout", key: "suitabilityOfLayout" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.20 Light and ventilation", key: "lightAndVentilationPart3" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.21 Housekeeping", key: "houseKeeping" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.22 Suitable water supply", key: "waterSupplySuitable" },
    { part: "Part 3 - Area of Food Preparation / Serving / Display / Storage", label: "3.23 Safe food handling practices", key: "safeFoodHandling" },

    { part: "Part 4 - Equipment & Furniture", label: "4.1 Equipment/utensils for food handling", key: "equipmentForFoodHandling" },
    { part: "Part 4 - Equipment & Furniture", label: "4.2 Condition of the equipment/utensils", key: "conditionOfEquipment" },
    { part: "Part 4 - Equipment & Furniture", label: "4.3 Cleanliness of the equipment/utensils", key: "cleanOfEquipment" },
    { part: "Part 4 - Equipment & Furniture", label: "4.4 Availability of food tongs/spoons", key: "foodTongsAvailable" },
    { part: "Part 4 - Equipment & Furniture", label: "4.5 Storage facilities for cleaned equipment", key: "storageCleanEquip" },
    { part: "Part 4 - Equipment & Furniture", label: "4.6 Furniture – tables/chairs/cupboards", key: "furnitureCondition" },
    { part: "Part 4 - Equipment & Furniture", label: "4.7 Suitability and safety of furniture", key: "suitableSafetyofFurniture" },
    { part: "Part 4 - Equipment & Furniture", label: "4.8 Cleaning and maintenance of furniture", key: "cleaningAndMaintenanceOfFurniture" },
    { part: "Part 4 - Equipment & Furniture", label: "4.9 Temperature maintenance in refrigerators", key: "maintenanceOfRefrigerators" },
    { part: "Part 4 - Equipment & Furniture", label: "4.10 Cleanliness/maintenance of refrigerators", key: "cleanandMaintenanceOfRefrigerators" },

    { part: "Part 5 - Storage", label: "5.1 Storage facilities and housekeeping", key: "storageFacilities" },
    { part: "Part 5 - Storage", label: "5.2 Storage of raw materials", key: "storageOfRawMaterials" },
    { part: "Part 5 - Storage", label: "5.3 Storage of cooked / prepared food", key: "storageOfCookedFood" },
    { part: "Part 5 - Storage", label: "5.4 Food stored under suitable temperature", key: "foodStoredTemp" },
    { part: "Part 5 - Storage", label: "5.5 Storage of food in refrigerator / deep freezer", key: "storageInRefrigerator" },
    { part: "Part 5 - Storage", label: "5.6 Measures to prevent contamination", key: "measuresToPreventContamination" },

    { part: "Part 6 - Water Supply", label: "6.1 Water source", key: "waterSource" },
    { part: "Part 6 - Water Supply", label: "6.2 Water storage method", key: "waterStorageMethod" },
    { part: "Part 6 - Water Supply", label: "6.3 Water dispensed through taps", key: "waterDispensedThroughTaps" },
    { part: "Part 6 - Water Supply", label: "6.4 Safety of water certified by analytical reports", key: "waterSafetyCertified" },

    { part: "Part 7 - Waste Management", label: "7.1 Adequate number of bins with lids", key: "numberofBinswithLids" },
    { part: "Part 7 - Waste Management", label: "7.2 Lids of the bins closed", key: "lidsOfBinsClosed" },
    { part: "Part 7 - Waste Management", label: "7.3 Cleanliness and maintenance of waste bins", key: "cleanlinessOfWasteBins" },
    { part: "Part 7 - Waste Management", label: "7.4 Separation / Segregation of waste", key: "seperationofWaste" },
    { part: "Part 7 - Waste Management", label: "7.5 Final disposal of waste", key: "disposalOfWaste" },
    { part: "Part 7 - Waste Management", label: "7.6 Management of waste water", key: "managementofWasteWater" },
    { part: "Part 7 - Waste Management", label: "7.7 Adequate number of toilets and urinals", key: "adequateNumberOfToilets" },
    { part: "Part 7 - Waste Management", label: "7.8 Location of toilets and urinals", key: "locationOfToilets" },
    { part: "Part 7 - Waste Management", label: "7.9 Cleanliness and maintenance of toilets and urinals", key: "cleanlinessOfToilets" },
    { part: "Part 7 - Waste Management", label: "7.10 Septic tank / soakage pit condition", key: "septicTankCondition" },

    { part: "Part 8 - Condition, Standard & Cleanliness of Food", label: "8.1 Condition of food / raw materials", key: "conditionOfFood" },
    { part: "Part 8 - Condition, Standard & Cleanliness of Food", label: "8.2 Display / packaging for sale / delivery", key: "displayPackaging" },
    { part: "Part 8 - Condition, Standard & Cleanliness of Food", label: "8.3 Insect infested / outdated food unfit for consumption", key: "insectInfested" },
    { part: "Part 8 - Condition, Standard & Cleanliness of Food", label: "8.4 Violation of labeling regulations", key: "violationOfLabeling" },
    { part: "Part 8 - Condition, Standard & Cleanliness of Food", label: "8.5 Separation / storage of unwholesome food", key: "separationOfUnwholesomeFood" },

    { part: "Part 9 - Health Status and Training of Food Handlers", label: "9.1 Personal hygiene", key: "personalHygiene" },
    { part: "Part 9 - Health Status and Training of Food Handlers", label: "9.2 Wearing of protective clothing", key: "wearingProtectiveClothing" },
    { part: "Part 9 - Health Status and Training of Food Handlers", label: "9.3 Communicable diseases / skin diseases", key: "communicableDiseases" },
    { part: "Part 9 - Health Status and Training of Food Handlers", label: "9.4 Good health habits", key: "goodHealthHabits" },
    { part: "Part 9 - Health Status and Training of Food Handlers", label: "9.5 Maintenance of health records", key: "healthRecords" },
    { part: "Part 9 - Health Status and Training of Food Handlers", label: "9.6 Maintenance of training records", key: "trainingRecords" },

    { part: "Part 10 - Display of Health Instructions, Record Keeping & Certification", label: "10.1 Display of instruction and health messages", key: "displayHealthInstructions" },
    { part: "Part 10 - Display of Health Instructions, Record Keeping & Certification", label: "10.2 Entertains complaints and suggestions", key: "entertainsComplaints" },
    { part: "Part 10 - Display of Health Instructions, Record Keeping & Certification", label: "10.3 Prevent smoking within the premises", key: "preventSmoking" },
    { part: "Part 10 - Display of Health Instructions, Record Keeping & Certification", label: "10.4 Issuing bills and record keeping", key: "issuingBills" },
    { part: "Part 10 - Display of Health Instructions, Record Keeping & Certification", label: "10.5 Accredited certification on food safety", key: "foodSafetyCertification" },

  ];
  

function renderInspectionTable(forms) {
    const table = document.querySelector(".inspection-table");
  
    const thead = table.querySelector("thead tr");
    for (let form of forms) {
      const th = document.createElement("th");
      const date = form.submittedAt.toDate();
      th.textContent = date.toISOString().split("T")[0];
      thead.appendChild(th);
    }
  
    const tbody = table.querySelector("tbody");
    tbody.innerHTML = "";
  
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
  