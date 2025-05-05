import 'package:cloud_firestore/cloud_firestore.dart';

class H800FormData {
  // ─────────────────────────────────────────── Part‑1 (5) ──────────────
  String? suitabilityForBusiness;
  String? generalCleanliness;
  String? hasPollutingConditions;
  String? hasAnimals;
  String? hasSmokeOrAdverseEffects;

  // ─────────────────────────────────────────── Part‑2 (10) ─────────────
  String? natureOfBuilding;
  String? space;
  String? lightAndVentilation;
  String? conditionOfFloor;
  String? conditionOfWall;
  String? conditionOfCeiling;
  String? hasHazards;

  // ─────────────────────────────────────────── Part‑3 (30) ─────────────
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

  // ─────────────────────────────────────────── Part‑4 (10) ─────────────
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

  // ─────────────────────────────────────────── Part‑5 (10) ─────────────
  String? storageFacilities;
  String? storageOfRawMaterials;
  String? storageOfCookedFood;
  String? foodStoredTemp;
  String? storageInRefrigerator;
  String? measuresToPreventContamination;

  // ─────────────────────────────────────────── Part‑6 (5) ──────────────
  String? waterSource;
  String? waterStorageMethod;
  String? waterDispensedThroughTaps;
  String? waterSafetyCertified;

  // ─────────────────────────────────────────── Part‑7 (10) ─────────────
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

  // ─────────────────────────────────────────── Part‑8 (5) ──────────────
  String? conditionOfFood;
  String? displayPackaging;
  String? insectInfested;
  String? violationOfLabeling;
  String? separationOfUnwholesomeFood;

  // ─────────────────────────────────────────── Part‑9 (10) ─────────────
  String? personalHygiene;
  String? wearingProtectiveClothing;
  String? communicableDiseases;
  String? goodHealthHabits;
  String? healthRecords;
  String? trainingRecords;

  // ─────────────────────────────────────────── Part‑10 (5) ─────────────
  String? displayHealthInstructions;
  String? entertainsComplaints;
  String? preventSmoking;
  String? issuingBills;
  String? foodSafetyCertification;

  // ─────────────────────────────────────────── Meta fields ─────────────
  String? shopId;          // will be turned into a reference on submit
  String? phiId;           // will be turned into a reference on submit

  H800FormData();

  // ──────────────────────────────── copyWith (optional) ────────────────
  H800FormData copyWith({
    String? suitabilityForBusiness,
    String? generalCleanliness,
    String? hasPollutingConditions,
    String? hasAnimals,
    String? hasSmokeOrAdverseEffects,
    String? natureOfBuilding,
    String? space,
    String? lightAndVentilation,
    String? conditionOfFloor,
    String? conditionOfWall,
    String? conditionOfCeiling,
    String? hasHazards,
    String? generalCleanlinessPart3,
    String? safetyMeasuresForCleanliness,
    String? hasFlies,
    String? hasPests,
    String? hasFloor,
    String? maintenanceOfWalls,
    String? maintenanceOfCeilingPart3,
    String? spaceInWorkingArea,
    String? dailyCleaning,
    String? riskOfContaminationFromToilets,
    String? adequateBins,
    String? hasUnnecessaryItems,
    String? cleaningToolsAvailable,
    String? hasObjectionableOdor,
    String? hasOpenDrains,
    String? areaUsedForSleeping,
    String? separateChoppingBoards,
    String? cleanlinessOfEquipment,
    String? suitabilityOfLayout,
    String? lightAndVentilationPart3,
    String? houseKeeping,
    String? waterSupplySuitable,
    String? safeFoodHandling,
    String? equipmentForFoodHandling,
    String? conditionOfEquipment,
    String? cleanOfEquipment,
    String? foodTongsAvailable,
    String? storageCleanEquip,
    String? suitableSafetyofFurniture,
    String? furnitureCondition,
    String? cleaningAndMaintenanceOfFurniture,
    String? maintenanceOfRefrigerators,
    String? cleanandMaintenanceOfRefrigerators,
    String? storageFacilities,
    String? storageOfRawMaterials,
    String? storageOfCookedFood,
    String? foodStoredTemp,
    String? storageInRefrigerator,
    String? measuresToPreventContamination,
    String? waterSource,
    String? waterStorageMethod,
    String? waterDispensedThroughTaps,
    String? waterSafetyCertified,
    String? numberofBinswithLids,
    String? lidsOfBinsClosed,
    String? cleanlinessOfWasteBins,
    String? seperationofWaste,
    String? disposalOfWaste,
    String? managementofWasteWater,
    String? adequateNumberOfToilets,
    String? locationOfToilets,
    String? cleanlinessOfToilets,
    String? septicTankCondition,
    String? conditionOfFood,
    String? displayPackaging,
    String? insectInfested,
    String? violationOfLabeling,
    String? separationOfUnwholesomeFood,
    String? personalHygiene,
    String? wearingProtectiveClothing,
    String? communicableDiseases,
    String? goodHealthHabits,
    String? healthRecords,
    String? trainingRecords,
    String? displayHealthInstructions,
    String? entertainsComplaints,
    String? preventSmoking,
    String? issuingBills,
    String? foodSafetyCertification,
    String? shopId,
    String? phiId,
  }) {
    final clone = H800FormData()
      ..suitabilityForBusiness        = suitabilityForBusiness        ?? this.suitabilityForBusiness
      ..generalCleanliness            = generalCleanliness            ?? this.generalCleanliness
      ..hasPollutingConditions        = hasPollutingConditions        ?? this.hasPollutingConditions
      ..hasAnimals                    = hasAnimals                    ?? this.hasAnimals
      ..hasSmokeOrAdverseEffects      = hasSmokeOrAdverseEffects      ?? this.hasSmokeOrAdverseEffects
      ..natureOfBuilding              = natureOfBuilding              ?? this.natureOfBuilding
      ..space                         = space                         ?? this.space
      ..lightAndVentilation           = lightAndVentilation           ?? this.lightAndVentilation
      ..conditionOfFloor              = conditionOfFloor              ?? this.conditionOfFloor
      ..conditionOfWall               = conditionOfWall               ?? this.conditionOfWall
      ..conditionOfCeiling            = conditionOfCeiling            ?? this.conditionOfCeiling
      ..hasHazards                    = hasHazards                    ?? this.hasHazards
      ..generalCleanlinessPart3       = generalCleanlinessPart3       ?? this.generalCleanlinessPart3
      ..safetyMeasuresForCleanliness  = safetyMeasuresForCleanliness  ?? this.safetyMeasuresForCleanliness
      ..hasFlies                      = hasFlies                      ?? this.hasFlies
      ..hasPests                      = hasPests                      ?? this.hasPests
      ..hasFloor                      = hasFloor                      ?? this.hasFloor
      ..maintenanceOfWalls            = maintenanceOfWalls            ?? this.maintenanceOfWalls
      ..maintenanceOfCeilingPart3     = maintenanceOfCeilingPart3     ?? this.maintenanceOfCeilingPart3
      ..spaceInWorkingArea            = spaceInWorkingArea            ?? this.spaceInWorkingArea
      ..dailyCleaning                 = dailyCleaning                 ?? this.dailyCleaning
      ..riskOfContaminationFromToilets=
          riskOfContaminationFromToilets ?? this.riskOfContaminationFromToilets
      ..adequateBins                  = adequateBins                  ?? this.adequateBins
      ..hasUnnecessaryItems           = hasUnnecessaryItems           ?? this.hasUnnecessaryItems
      ..cleaningToolsAvailable        = cleaningToolsAvailable        ?? this.cleaningToolsAvailable
      ..hasObjectionableOdor          = hasObjectionableOdor          ?? this.hasObjectionableOdor
      ..hasOpenDrains                 = hasOpenDrains                 ?? this.hasOpenDrains
      ..areaUsedForSleeping           = areaUsedForSleeping           ?? this.areaUsedForSleeping
      ..separateChoppingBoards        = separateChoppingBoards        ?? this.separateChoppingBoards
      ..cleanlinessOfEquipment        = cleanlinessOfEquipment        ?? this.cleanlinessOfEquipment
      ..suitabilityOfLayout           = suitabilityOfLayout           ?? this.suitabilityOfLayout
      ..lightAndVentilationPart3      = lightAndVentilationPart3      ?? this.lightAndVentilationPart3
      ..houseKeeping                  = houseKeeping                  ?? this.houseKeeping
      ..waterSupplySuitable           = waterSupplySuitable           ?? this.waterSupplySuitable
      ..safeFoodHandling              = safeFoodHandling              ?? this.safeFoodHandling
      ..equipmentForFoodHandling      = equipmentForFoodHandling      ?? this.equipmentForFoodHandling
      ..conditionOfEquipment          = conditionOfEquipment          ?? this.conditionOfEquipment
      ..cleanOfEquipment              = cleanOfEquipment              ?? this.cleanOfEquipment
      ..foodTongsAvailable            = foodTongsAvailable            ?? this.foodTongsAvailable
      ..storageCleanEquip             = storageCleanEquip             ?? this.storageCleanEquip
      ..suitableSafetyofFurniture     = suitableSafetyofFurniture     ?? this.suitableSafetyofFurniture
      ..furnitureCondition            = furnitureCondition            ?? this.furnitureCondition
      ..cleaningAndMaintenanceOfFurniture =
          cleaningAndMaintenanceOfFurniture ?? this.cleaningAndMaintenanceOfFurniture
      ..maintenanceOfRefrigerators    = maintenanceOfRefrigerators    ?? this.maintenanceOfRefrigerators
      ..cleanandMaintenanceOfRefrigerators =
          cleanandMaintenanceOfRefrigerators ?? this.cleanandMaintenanceOfRefrigerators
      ..storageFacilities             = storageFacilities             ?? this.storageFacilities
      ..storageOfRawMaterials         = storageOfRawMaterials         ?? this.storageOfRawMaterials
      ..storageOfCookedFood           = storageOfCookedFood           ?? this.storageOfCookedFood
      ..foodStoredTemp                = foodStoredTemp                ?? this.foodStoredTemp
      ..storageInRefrigerator         = storageInRefrigerator         ?? this.storageInRefrigerator
      ..measuresToPreventContamination=
          measuresToPreventContamination ?? this.measuresToPreventContamination
      ..waterSource                   = waterSource                   ?? this.waterSource
      ..waterStorageMethod            = waterStorageMethod            ?? this.waterStorageMethod
      ..waterDispensedThroughTaps     = waterDispensedThroughTaps     ?? this.waterDispensedThroughTaps
      ..waterSafetyCertified          = waterSafetyCertified          ?? this.waterSafetyCertified
      ..numberofBinswithLids          = numberofBinswithLids          ?? this.numberofBinswithLids
      ..lidsOfBinsClosed              = lidsOfBinsClosed              ?? this.lidsOfBinsClosed
      ..cleanlinessOfWasteBins        = cleanlinessOfWasteBins        ?? this.cleanlinessOfWasteBins
      ..seperationofWaste             = seperationofWaste             ?? this.seperationofWaste
      ..disposalOfWaste               = disposalOfWaste               ?? this.disposalOfWaste
      ..managementofWasteWater        = managementofWasteWater        ?? this.managementofWasteWater
      ..adequateNumberOfToilets       = adequateNumberOfToilets       ?? this.adequateNumberOfToilets
      ..locationOfToilets             = locationOfToilets             ?? this.locationOfToilets
      ..cleanlinessOfToilets          = cleanlinessOfToilets          ?? this.cleanlinessOfToilets
      ..septicTankCondition           = septicTankCondition           ?? this.septicTankCondition
      ..conditionOfFood               = conditionOfFood               ?? this.conditionOfFood
      ..displayPackaging              = displayPackaging              ?? this.displayPackaging
      ..insectInfested                = insectInfested                ?? this.insectInfested
      ..violationOfLabeling           = violationOfLabeling           ?? this.violationOfLabeling
      ..separationOfUnwholesomeFood   = separationOfUnwholesomeFood   ?? this.separationOfUnwholesomeFood
      ..personalHygiene               = personalHygiene               ?? this.personalHygiene
      ..wearingProtectiveClothing     = wearingProtectiveClothing     ?? this.wearingProtectiveClothing
      ..communicableDiseases          = communicableDiseases          ?? this.communicableDiseases
      ..goodHealthHabits              = goodHealthHabits              ?? this.goodHealthHabits
      ..healthRecords                 = healthRecords                 ?? this.healthRecords
      ..trainingRecords               = trainingRecords               ?? this.trainingRecords
      ..displayHealthInstructions     = displayHealthInstructions     ?? this.displayHealthInstructions
      ..entertainsComplaints          = entertainsComplaints          ?? this.entertainsComplaints
      ..preventSmoking                = preventSmoking                ?? this.preventSmoking
      ..issuingBills                  = issuingBills                  ?? this.issuingBills
      ..foodSafetyCertification       = foodSafetyCertification       ?? this.foodSafetyCertification
      ..shopId                        = shopId                        ?? this.shopId
      ..phiId                         = phiId                         ?? this.phiId;

    return clone;
  }

  // ──────────────────────────────── JSON helpers ───────────────────────
  Map<String, dynamic> toJson() => {
    // part‑1
    'suitabilityForBusiness'        : suitabilityForBusiness,
    'generalCleanliness'            : generalCleanliness,
    'hasPollutingConditions'        : hasPollutingConditions,
    'hasAnimals'                    : hasAnimals,
    'hasSmokeOrAdverseEffects'      : hasSmokeOrAdverseEffects,
    // part‑2
    'natureOfBuilding'              : natureOfBuilding,
    'space'                         : space,
    'lightAndVentilation'           : lightAndVentilation,
    'conditionOfFloor'              : conditionOfFloor,
    'conditionOfWall'               : conditionOfWall,
    'conditionOfCeiling'            : conditionOfCeiling,
    'hasHazards'                    : hasHazards,
    // part‑3
    'generalCleanlinessPart3'       : generalCleanlinessPart3,
    'safetyMeasuresForCleanliness'  : safetyMeasuresForCleanliness,
    'hasFlies'                      : hasFlies,
    'hasPests'                      : hasPests,
    'hasFloor'                      : hasFloor,
    'maintenanceOfWalls'            : maintenanceOfWalls,
    'maintenanceOfCeilingPart3'     : maintenanceOfCeilingPart3,
    'spaceInWorkingArea'            : spaceInWorkingArea,
    'dailyCleaning'                 : dailyCleaning,
    'riskOfContaminationFromToilets': riskOfContaminationFromToilets,
    'adequateBins'                  : adequateBins,
    'hasUnnecessaryItems'           : hasUnnecessaryItems,
    'cleaningToolsAvailable'        : cleaningToolsAvailable,
    'hasObjectionableOdor'          : hasObjectionableOdor,
    'hasOpenDrains'                 : hasOpenDrains,
    'areaUsedForSleeping'           : areaUsedForSleeping,
    'separateChoppingBoards'        : separateChoppingBoards,
    'cleanlinessOfEquipment'        : cleanlinessOfEquipment,
    'suitabilityOfLayout'           : suitabilityOfLayout,
    'lightAndVentilationPart3'      : lightAndVentilationPart3,
    'houseKeeping'                  : houseKeeping,
    'waterSupplySuitable'           : waterSupplySuitable,
    'safeFoodHandling'              : safeFoodHandling,
    // part‑4
    'equipmentForFoodHandling'      : equipmentForFoodHandling,
    'conditionOfEquipment'          : conditionOfEquipment,
    'cleanOfEquipment'              : cleanOfEquipment,
    'foodTongsAvailable'            : foodTongsAvailable,
    'storageCleanEquip'             : storageCleanEquip,
    'suitableSafetyofFurniture'     : suitableSafetyofFurniture,
    'furnitureCondition'            : furnitureCondition,
    'cleaningAndMaintenanceOfFurniture':
    cleaningAndMaintenanceOfFurniture,
    'maintenanceOfRefrigerators'    : maintenanceOfRefrigerators,
    'cleanandMaintenanceOfRefrigerators':
    cleanandMaintenanceOfRefrigerators,
    // part‑5
    'storageFacilities'             : storageFacilities,
    'storageOfRawMaterials'         : storageOfRawMaterials,
    'storageOfCookedFood'           : storageOfCookedFood,
    'foodStoredTemp'                : foodStoredTemp,
    'storageInRefrigerator'         : storageInRefrigerator,
    'measuresToPreventContamination': measuresToPreventContamination,
    // part‑6
    'waterSource'                   : waterSource,
    'waterStorageMethod'            : waterStorageMethod,
    'waterDispensedThroughTaps'     : waterDispensedThroughTaps,
    'waterSafetyCertified'          : waterSafetyCertified,
    // part‑7
    'numberofBinswithLids'          : numberofBinswithLids,
    'lidsOfBinsClosed'              : lidsOfBinsClosed,
    'cleanlinessOfWasteBins'        : cleanlinessOfWasteBins,
    'seperationofWaste'             : seperationofWaste,
    'disposalOfWaste'               : disposalOfWaste,
    'managementofWasteWater'        : managementofWasteWater,
    'adequateNumberOfToilets'       : adequateNumberOfToilets,
    'locationOfToilets'             : locationOfToilets,
    'cleanlinessOfToilets'          : cleanlinessOfToilets,
    'septicTankCondition'           : septicTankCondition,
    // part‑8
    'conditionOfFood'               : conditionOfFood,
    'displayPackaging'              : displayPackaging,
    'insectInfested'                : insectInfested,
    'violationOfLabeling'           : violationOfLabeling,
    'separationOfUnwholesomeFood'   : separationOfUnwholesomeFood,
    // part‑9
    'personalHygiene'               : personalHygiene,
    'wearingProtectiveClothing'     : wearingProtectiveClothing,
    'communicableDiseases'          : communicableDiseases,
    'goodHealthHabits'              : goodHealthHabits,
    'healthRecords'                 : healthRecords,
    'trainingRecords'               : trainingRecords,
    // part‑10
    'displayHealthInstructions'     : displayHealthInstructions,
    'entertainsComplaints'          : entertainsComplaints,
    'preventSmoking'                : preventSmoking,
    'issuingBills'                  : issuingBills,
    'foodSafetyCertification'       : foodSafetyCertification,
    // meta
    'shopId'                        : shopId,
    'phiId'                         : phiId,
    'timestamp'                     : FieldValue.serverTimestamp(),
  };

  /// Re‑hydrate from Firestore
  static H800FormData fromJson(Map<String, dynamic> json) => H800FormData()
    ..suitabilityForBusiness        = json['suitabilityForBusiness']
    ..generalCleanliness            = json['generalCleanliness']
    ..hasPollutingConditions        = json['hasPollutingConditions']
    ..hasAnimals                    = json['hasAnimals']
    ..hasSmokeOrAdverseEffects      = json['hasSmokeOrAdverseEffects']
    ..natureOfBuilding              = json['natureOfBuilding']
    ..space                         = json['space']
    ..lightAndVentilation           = json['lightAndVentilation']
    ..conditionOfFloor              = json['conditionOfFloor']
    ..conditionOfWall               = json['conditionOfWall']
    ..conditionOfCeiling            = json['conditionOfCeiling']
    ..hasHazards                    = json['hasHazards']
    ..generalCleanlinessPart3       = json['generalCleanlinessPart3']
    ..safetyMeasuresForCleanliness  = json['safetyMeasuresForCleanliness']
    ..hasFlies                      = json['hasFlies']
    ..hasPests                      = json['hasPests']
    ..hasFloor                      = json['hasFloor']
    ..maintenanceOfWalls            = json['maintenanceOfWalls']
    ..maintenanceOfCeilingPart3     = json['maintenanceOfCeilingPart3']
    ..spaceInWorkingArea            = json['spaceInWorkingArea']
    ..dailyCleaning                 = json['dailyCleaning']
    ..riskOfContaminationFromToilets=
    json['riskOfContaminationFromToilets']
    ..adequateBins                  = json['adequateBins']
    ..hasUnnecessaryItems           = json['hasUnnecessaryItems']
    ..cleaningToolsAvailable        = json['cleaningToolsAvailable']
    ..hasObjectionableOdor          = json['hasObjectionableOdor']
    ..hasOpenDrains                 = json['hasOpenDrains']
    ..areaUsedForSleeping           = json['areaUsedForSleeping']
    ..separateChoppingBoards        = json['separateChoppingBoards']
    ..cleanlinessOfEquipment        = json['cleanlinessOfEquipment']
    ..suitabilityOfLayout           = json['suitabilityOfLayout']
    ..lightAndVentilationPart3      = json['lightAndVentilationPart3']
    ..houseKeeping                  = json['houseKeeping']
    ..waterSupplySuitable           = json['waterSupplySuitable']
    ..safeFoodHandling              = json['safeFoodHandling']
    ..equipmentForFoodHandling      = json['equipmentForFoodHandling']
    ..conditionOfEquipment          = json['conditionOfEquipment']
    ..cleanOfEquipment              = json['cleanOfEquipment']
    ..foodTongsAvailable            = json['foodTongsAvailable']
    ..storageCleanEquip             = json['storageCleanEquip']
    ..suitableSafetyofFurniture     = json['suitableSafetyofFurniture']
    ..furnitureCondition            = json['furnitureCondition']
    ..cleaningAndMaintenanceOfFurniture =
    json['cleaningAndMaintenanceOfFurniture']
    ..maintenanceOfRefrigerators    = json['maintenanceOfRefrigerators']
    ..cleanandMaintenanceOfRefrigerators =
    json['cleanandMaintenanceOfRefrigerators']
    ..storageFacilities             = json['storageFacilities']
    ..storageOfRawMaterials         = json['storageOfRawMaterials']
    ..storageOfCookedFood           = json['storageOfCookedFood']
    ..foodStoredTemp                = json['foodStoredTemp']
    ..storageInRefrigerator         = json['storageInRefrigerator']
    ..measuresToPreventContamination=
    json['measuresToPreventContamination']
    ..waterSource                   = json['waterSource']
    ..waterStorageMethod            = json['waterStorageMethod']
    ..waterDispensedThroughTaps     = json['waterDispensedThroughTaps']
    ..waterSafetyCertified          = json['waterSafetyCertified']
    ..numberofBinswithLids          = json['numberofBinswithLids']
    ..lidsOfBinsClosed              = json['lidsOfBinsClosed']
    ..cleanlinessOfWasteBins        = json['cleanlinessOfWasteBins']
    ..seperationofWaste             = json['seperationofWaste']
    ..disposalOfWaste               = json['disposalOfWaste']
    ..managementofWasteWater        = json['managementofWasteWater']
    ..adequateNumberOfToilets       = json['adequateNumberOfToilets']
    ..locationOfToilets             = json['locationOfToilets']
    ..cleanlinessOfToilets          = json['cleanlinessOfToilets']
    ..septicTankCondition           = json['septicTankCondition']
    ..conditionOfFood               = json['conditionOfFood']
    ..displayPackaging              = json['displayPackaging']
    ..insectInfested                = json['insectInfested']
    ..violationOfLabeling           = json['violationOfLabeling']
    ..separationOfUnwholesomeFood   = json['separationOfUnwholesomeFood']
    ..personalHygiene               = json['personalHygiene']
    ..wearingProtectiveClothing     = json['wearingProtectiveClothing']
    ..communicableDiseases          = json['communicableDiseases']
    ..goodHealthHabits              = json['goodHealthHabits']
    ..healthRecords                 = json['healthRecords']
    ..trainingRecords               = json['trainingRecords']
    ..displayHealthInstructions     = json['displayHealthInstructions']
    ..entertainsComplaints          = json['entertainsComplaints']
    ..preventSmoking                = json['preventSmoking']
    ..issuingBills                  = json['issuingBills']
    ..foodSafetyCertification       = json['foodSafetyCertification']
    ..shopId                        = json['shopId']
    ..phiId                         = json['phiId'];

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
    total += conditionOfFloor == 'Good'
        ? 2
        : (conditionOfFloor == 'Satisfactory' ? 1 : 0);
    total += conditionOfWall == 'Good'
        ? 2
        : (conditionOfWall == 'Satisfactory' ? 1 : 0);
    total += conditionOfCeiling == 'Good'
        ? 2
        : (conditionOfCeiling == 'Satisfactory' ? 1 : 0);
    total += hasHazards == 'Yes' ? 0 : 1;

    // Part 3: Area of Food Preparation/Serving/Display/Storage (30 Marks)
    total += generalCleanlinessPart3 == 'Good'
        ? 2
        : (generalCleanlinessPart3 == 'Satisfactory' ? 1 : 0);
    total += safetyMeasuresForCleanliness == 'Good'
        ? 2
        : (safetyMeasuresForCleanliness == 'Satisfactory' ? 1 : 0);
    total += hasFlies == 'Yes' ? 0 : 1;
    total += hasPests == 'Yes' ? 0 : 1;
    total += hasFloor == 'Good' ? 2 : (hasFloor == 'Satisfactory' ? 1 : 0);
    total += maintenanceOfWalls == 'Good'
        ? 2
        : (maintenanceOfWalls == 'Satisfactory' ? 1 : 0);
    total += maintenanceOfCeilingPart3 == 'Good'
        ? 2
        : (maintenanceOfCeilingPart3 == 'Satisfactory' ? 1 : 0);
    total += spaceInWorkingArea == 'Adequate' ? 1 : 0;
    total += dailyCleaning == 'Yes' ? 1 : 0; //3.9
    total += riskOfContaminationFromToilets == 'Yes' ? 0 : 1;
    total += adequateBins == 'Yes' ? 1 : 0; //3.11
    total += hasUnnecessaryItems == 'Yes' ? 0 : 1; //3.12
    total += cleaningToolsAvailable == 'Yes' ? 1 : 0; //3.13
    total += hasObjectionableOdor == 'Yes' ? 0 : 1; //3.14
    total += hasOpenDrains == 'Yes' ? 0 : 1; //3.15
    total += areaUsedForSleeping == 'Yes' ? 0 : 1; //3.16
    total += separateChoppingBoards == 'Yes' ? 1 : 0; //3.17
    total += cleanlinessOfEquipment == 'Yes' ? 1 : 0;
    total += suitabilityOfLayout == 'Yes' ? 1 : 0;
    total += lightAndVentilationPart3 == 'Adequate' ? 1 : 0;
    total +=
    houseKeeping == 'Good' ? 2 : (houseKeeping == 'Satisfactory' ? 1 : 0);
    total += waterSupplySuitable == 'Yes' ? 1 : 0;
    total += safeFoodHandling == 'Good'
        ? 2
        : (safeFoodHandling == 'Satisfactory' ? 1 : 0);

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
    total += storageFacilities == 'Good'
        ? 2
        : (storageFacilities == 'Satisfactory' ? 1 : 0);
    total += storageOfRawMaterials == 'Good'
        ? 2
        : (storageOfRawMaterials == 'Satisfactory' ? 1 : 0);
    total += storageOfCookedFood == 'Good'
        ? 2
        : (storageOfCookedFood == 'Satisfactory' ? 1 : 0);
    total += foodStoredTemp == 'Yes' ? 1 : 0;
    total += storageInRefrigerator == 'Satisfactory' ? 1 : 0;
    total += measuresToPreventContamination == 'Good'
        ? 2
        : (measuresToPreventContamination == 'Satisfactory' ? 1 : 0);

    // Part 6: Water Supply (5 Marks)
    total += waterSource == 'Safe' ? 1 : 0;
    total += waterStorageMethod == 'Satisfactory' ? 1 : 0;
    total += waterDispensedThroughTaps == 'Yes' ? 1 : 0;
    total += waterSafetyCertified == 'Yes' ? 2 : 0;

    // Part 7: Waste Management (10 Marks)
    total += numberofBinswithLids == 'Available' ? 1 : 0;
    total += lidsOfBinsClosed == 'Yes' ? 1 : 0;
    total += cleanlinessOfWasteBins == 'Satisfactory' ? 1 : 0;
    total += seperationofWaste == 'Yes' ? 1 : 0;
    total += disposalOfWaste == 'Safe' ? 1 : 0;
    total += managementofWasteWater == 'Safe' ? 1 : 0;
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
    total += personalHygiene == 'Good'
        ? 2
        : (personalHygiene == 'Satisfactory' ? 1 : 0);
    total += wearingProtectiveClothing == 'Good'
        ? 2
        : (wearingProtectiveClothing == 'Satisfactory' ? 1 : 0);
    total += communicableDiseases == 'Yes' ? 0 : 1;
    total += goodHealthHabits == 'Practiced' ? 1 : 0;
    total +=
    healthRecords == 'Good' ? 2 : (healthRecords == 'Satisfactory' ? 1 : 0);
    total += trainingRecords == 'Good'
        ? 2
        : (trainingRecords == 'Satisfactory' ? 1 : 0);

    // Part 10: Display of Health Instructions, Record Keeping & Certification (5 Marks)
    total += displayHealthInstructions == 'Yes' ? 1 : 0;
    total += entertainsComplaints == 'Yes' ? 1 : 0;
    total += preventSmoking == 'Yes' ? 1 : 0;
    total += issuingBills == 'Yes' ? 1 : 0;
    total += foodSafetyCertification == 'Yes' ? 1 : 0;

    return total;
  }
}