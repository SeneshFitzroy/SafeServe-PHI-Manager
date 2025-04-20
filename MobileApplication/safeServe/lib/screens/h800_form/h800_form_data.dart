class H800FormData {
  // Part 1: Location & Environment (5 Marks)
  String? suitabilityForBusiness;
  String? generalCleanliness;
  String? hasPollutingConditions;
  String? hasAnimals;
  String? hasSmokeOrAdverseEffects;

  // Part 2: Building (10 Marks)
  String? natureOfBuilding;
  String? space;
  String? lightAndVentilation;
  String? conditionOfFloor;
  String? conditionOfWall;
  String? conditionOfCeiling;
  String? hasHazards;

  // Part 3: Area of Food Preparation/Serving/Display/Storage (30 Marks)
  String? generalCleanlinessPart3;
  String? safetyMeasuresForCleanliness;
  String? hasFlies;
  String? hasPests;
  String? hasFloor;
  String? maintenanceOfWalls;
  String? maintenanceOfCeilingPart3;
  String? spaceInWorkingArea;
  String? dailyCleaning;
  String? riskOfContaminationFromToilets;
  String? adequateBins;
  String? hasUnnecessaryItems;
  String? cleaningToolsAvailable;
  String? hasObjectionableOdor;
  String? hasOpenDrains;
  String? areaUsedForSleeping;
  String? separateChoppingBoards;
  String? cleanlinessOfEquipment;
  String? suitabilityOfLayout;
  String? lightAndVentilationPart3;
  String? houseKeeping;
  String? waterSupplySuitable;
  String? safeFoodHandling;

  // Part 4: Equipment & Furniture (10 Marks)
  String? equipmentForFoodHandling;
  String? conditionOfEquipment;
  String? cleanOfEquipment;
  String? foodTongsAvailable;
  String? storageCleanEquip;
  String? suitableSafetyofFurniture;
  String? furnitureCondition;
  String? cleaningAndMaintenanceOfFurniture;
  String? maintenanceOfRefrigerators;
  String? cleanandMaintenanceOfRefrigerators;

  // Part 5: Storage (10 Marks)
  String? storageFacilities;
  String? storageOfRawMaterials;
  String? storageOfCookedFood;
  String? foodStoredTemp;
  String? storageInRefrigerator;
  String? measuresToPreventContamination;

  // Part 6: Water Supply (5 Marks)
  String? waterSource;
  String? waterStorageMethod;
  String? waterDispensedThroughTaps;
  String? waterSafetyCertified;

  // Part 7: Waste Management (10 Marks)
  String? numberofBinswithLids;
  String? lidsOfBinsClosed;
  String? cleanlinessOfWasteBins;
  String? seperationofWaste;
  String? disposalOfWaste;
  String? managementofWasteWater;
  String? adequateNumberOfToilets;
  String? locationOfToilets;
  String? cleanlinessOfToilets;
  String? septicTankCondition;

  // Part 8: Condition, Standard & Cleanliness of Food (5 Marks)
  String? conditionOfFood;
  String? displayPackaging;
  String? insectInfested;
  String? violationOfLabeling;
  String? separationOfUnwholesomeFood;

  // Part 9: Health Status and Training of Food Handlers (10 Marks)
  String? personalHygiene;
  String? wearingProtectiveClothing;
  String? communicableDiseases;
  String? goodHealthHabits;
  String? healthRecords;
  String? trainingRecords;

  // Part 10: Display of Health Instructions, Record Keeping & Certification (5 Marks)
  String? displayHealthInstructions;
  String? entertainsComplaints;
  String? preventSmoking;
  String? issuingBills;
  String? foodSafetyCertification;

  H800FormData({
    this.suitabilityForBusiness,
    this.generalCleanliness,
    this.hasPollutingConditions,
    this.hasAnimals,
    this.hasSmokeOrAdverseEffects,
    this.natureOfBuilding,
    this.space,
    this.lightAndVentilation,
    this.conditionOfFloor,
    this.conditionOfWall,
    this.conditionOfCeiling,
    this.hasHazards,
    this.generalCleanlinessPart3,
    this.safetyMeasuresForCleanliness,
    this.hasFlies,
    this.hasPests,
    this.hasFloor,
    this.maintenanceOfWalls,
    this.maintenanceOfCeilingPart3,
    this.spaceInWorkingArea,
    this.dailyCleaning,
    this.riskOfContaminationFromToilets,
    this.adequateBins,
    this.hasUnnecessaryItems,
    this.cleaningToolsAvailable,
    this.hasObjectionableOdor,
    this.hasOpenDrains,
    this.areaUsedForSleeping,
    this.separateChoppingBoards,
    this.cleanlinessOfEquipment,
    this.suitabilityOfLayout,
    this.lightAndVentilationPart3,
    this.houseKeeping,
    this.waterSupplySuitable,
    this.safeFoodHandling,
    this.equipmentForFoodHandling,
    this.conditionOfEquipment,
    this.cleanOfEquipment,
    this.foodTongsAvailable,
    this.storageCleanEquip,
    this.suitableSafetyofFurniture,//new
    this.furnitureCondition,
    this.cleaningAndMaintenanceOfFurniture,
    this.maintenanceOfRefrigerators,
    this.cleanandMaintenanceOfRefrigerators,//new 4.10
    this.storageFacilities,
    this.storageOfRawMaterials,
    this.storageOfCookedFood,
    this.foodStoredTemp,
    this.storageInRefrigerator,
    this.measuresToPreventContamination,
    this.waterSource,
    this.waterStorageMethod,
    this.waterDispensedThroughTaps,
    this.waterSafetyCertified,
    this.numberofBinswithLids, //7.1
    this.lidsOfBinsClosed,
    this.cleanlinessOfWasteBins,
    this.seperationofWaste,
    this.disposalOfWaste,
    this.managementofWasteWater,//7.6
    this.adequateNumberOfToilets,
    this.locationOfToilets,
    this.cleanlinessOfToilets,
    this.septicTankCondition,
    this.conditionOfFood,
    this.displayPackaging,
    this.insectInfested,
    this.violationOfLabeling,
    this.separationOfUnwholesomeFood,
    this.personalHygiene,//9.1
    this.wearingProtectiveClothing,
    this.communicableDiseases,
    this.goodHealthHabits,
    this.healthRecords,
    this.trainingRecords,
    this.displayHealthInstructions,
    this.entertainsComplaints,
    this.preventSmoking,
    this.issuingBills,
    this.foodSafetyCertification,
  });

  int calculateTotalScore() {
  int total = 0;

  // Part 1: Location & Environment (5 Marks)
  total += suitabilityForBusiness == 'Suitable' ? 1 : 0;
  total += generalCleanliness == 'Satisfactory' ? 1 : 0;
  total += hasPollutingConditions == 'Yes' ? 0 : 1;
  total += hasAnimals == 'Yes' ? 0 : 1;
  total += hasSmokeOrAdverseEffects == 'Yes' ? 0 : 1;

  // Part 2: Building (10 Marks)
  total += natureOfBuilding == 'Permanent' ? 1 : 0;
  total += space == 'Adequate' ? 1 : 0;
  total += lightAndVentilation == 'Adequate' ? 1 : 0;
  total += conditionOfFloor == 'Good' ? 2 : (conditionOfFloor == 'Satisfactory' ? 1 : 0);
  total += conditionOfWall == 'Good' ? 2 : (conditionOfWall == 'Satisfactory' ? 1 : 0);
  total += conditionOfCeiling == 'Good' ? 2 : (conditionOfCeiling == 'Satisfactory' ? 1 : 0);
  total += hasHazards == 'Yes' ? 0 : 1;

  // Part 3: Area of Food Preparation/Serving/Display/Storage (30 Marks)
  total += generalCleanlinessPart3 == 'Good' ? 2 : (generalCleanlinessPart3 == 'Satisfactory' ? 1 : 0);
  total += safetyMeasuresForCleanliness == 'Good' ? 2 : (safetyMeasuresForCleanliness == 'Satisfactory' ? 1 : 0);
  total += hasFlies == 'Yes' ? 0 : 1;
  total += hasPests == 'Yes' ? 0 : 1;
  total += hasFloor == 'Good' ? 2 : (hasFloor == 'Satisfactory' ? 1 : 0);
  total += maintenanceOfWalls == 'Good' ? 2 : (maintenanceOfWalls == 'Satisfactory' ? 1 : 0);
  total += maintenanceOfCeilingPart3 == 'Good' ? 2 : (maintenanceOfCeilingPart3 == 'Satisfactory' ? 1 : 0);
  total += spaceInWorkingArea == 'Adequate' ? 1 : 0;
  total += dailyCleaning == 'Yes' ? 1 : 0;//3.9
  total += riskOfContaminationFromToilets == 'Yes' ? 0 : 1;
  total += adequateBins == 'Yes' ? 1 : 0;//3.11
  total += hasUnnecessaryItems == 'Yes' ? 0 : 1; //3.12
  total += cleaningToolsAvailable == 'Yes' ? 1 : 0;//3.13
  total += hasObjectionableOdor == 'Yes' ? 0 : 1;//3.14
  total += hasOpenDrains == 'Yes' ? 0 : 1;//3.15
  total += areaUsedForSleeping == 'Yes' ? 0 : 1;//3.16
  total += separateChoppingBoards == 'Yes' ? 1 : 0;//3.17
  total += cleanlinessOfEquipment == 'Yes' ? 1 : 0;
  total += suitabilityOfLayout == 'Yes' ? 1 : 0;
  total += lightAndVentilationPart3 == 'Adequate' ? 1 : 0;
  total += houseKeeping =='Good' ? 2 : (houseKeeping == 'Satisfactory' ? 1 : 0);
  total += waterSupplySuitable == 'Yes' ? 1 :0;
  total += safeFoodHandling == 'Good' ? 2 : (safeFoodHandling == 'Satisfactory' ? 1 : 0);

  // Part 4: Equipment & Furniture (10 Marks)
  total += equipmentForFoodHandling == 'Adequate' ? 1 : 0;
  total += conditionOfEquipment == 'Satisfactory' ? 1 : 0;
  total += cleanOfEquipment == 'Satisfactory' ? 1 : 0;
  total += foodTongsAvailable == 'Yes' ? 1 : 0;
  total += storageCleanEquip == 'Yes' ? 1 : 0;
  total += suitableSafetyofFurniture == 'Satisfactory' ? 1 : 0;
  total += furnitureCondition == 'Adequate' ? 1 : 0;
  total += cleaningAndMaintenanceOfFurniture == 'Satisfactory' ? 1 : 0;
  total += maintenanceOfRefrigerators == 'Satisfactory' ? 1 : 0;
  total += cleanandMaintenanceOfRefrigerators == 'Satisfactory' ? 1 : 0;

  // Part 5: Storage (10 Marks)
  total += storageFacilities == 'Good' ? 2 : (storageFacilities == 'Satisfactory' ? 1 : 0);
  total += storageOfRawMaterials == 'Good' ? 2 : (storageOfRawMaterials == 'Satisfactory' ? 1 : 0);
  total += storageOfCookedFood == 'Good' ? 2 : (storageOfCookedFood == 'Satisfactory' ? 1 : 0);
  total += foodStoredTemp == 'Yes' ? 1 : 0;
  total += storageInRefrigerator == 'Satisfactory' ? 1 : 0;
  total += measuresToPreventContamination == 'Good' ? 2 : (measuresToPreventContamination == 'Satisfactory' ? 1 : 0);

  // Part 6: Water Supply (5 Marks)
  total += waterSource == 'Safe' ? 1 : 0;
  total += waterStorageMethod  == 'Satisfactory' ? 1 : 0;
  total += waterDispensedThroughTaps == 'Yes' ? 1 : 0;
  total += waterSafetyCertified == 'Yes' ? 2 : 0;

  // Part 7: Waste Management (10 Marks)
  total += numberofBinswithLids == 'Available'? 1 : 0;
  total += lidsOfBinsClosed == 'Yes' ? 1 : 0;
  total += cleanlinessOfWasteBins == 'Satisfactory' ? 1 : 0;
  total += seperationofWaste == 'Yes' ? 1 : 0;
  total += disposalOfWaste == 'Safe' ? 1 : 0;
  total += managementofWasteWater  == 'Safe' ? 1 : 0;
  total += adequateNumberOfToilets == 'Yes' ? 1 : 0;
  total += locationOfToilets == 'Safe' ? 1 : 0;
  total += cleanlinessOfToilets == 'Satisfactory' ? 1 : 0;
  total += septicTankCondition == 'Safe' ? 1 : 0;

  // Part 8: Condition, Standard & Cleanliness of Food (5 Marks)
  total += conditionOfFood == 'Satisfactory' ? 1 : 0;
  total += displayPackaging == 'Satisfactory' ? 1 : 0;
  total += insectInfested == 'Yes' ? 0 : 1;
  total += violationOfLabeling == 'Yes' ? 0 : 1;
  total += separationOfUnwholesomeFood == 'Yes' ? 1 : 0;

  // Part 9: Health Status and Training of Food Handlers (10 Marks)
  total += personalHygiene  == 'Good' ? 2 : (personalHygiene == 'Satisfactory' ? 1 : 0);
  total += wearingProtectiveClothing == 'Good' ? 2 : (wearingProtectiveClothing == 'Satisfactory' ? 1 : 0);
  total += communicableDiseases == 'Yes' ? 0 : 1;
  total += goodHealthHabits == 'Practiced' ? 1 : 0;
  total += healthRecords == 'Good' ? 2 : (healthRecords == 'Satisfactory' ? 1 : 0);
  total += trainingRecords == 'Good' ? 2 : (trainingRecords == 'Satisfactory' ? 1 : 0);

  // Part 10: Display of Health Instructions, Record Keeping & Certification (5 Marks)
  total += displayHealthInstructions == 'Yes' ? 1 : 0;
  total += entertainsComplaints == 'Yes' ? 1 : 0;
  total += preventSmoking == 'Yes' ? 1 : 0;
  total += issuingBills == 'Yes' ? 1 : 0;
  total += foodSafetyCertification == 'Yes' ? 1 : 0;


  return total;
}
}