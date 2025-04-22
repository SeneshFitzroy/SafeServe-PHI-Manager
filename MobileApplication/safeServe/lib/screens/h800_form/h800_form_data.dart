// lib/screens/h800_form/h800_form_data.dart
class H800FormData {
  String? id;

  // Part 1: Location & Environment
  String suitabilityForBusiness = '';
  String generalCleanliness = '';
  bool hasPollutingConditions = false;
  bool hasAnimals = false;
  bool hasSmokeOrAdverseEffects = false;

  // Part 2: Building
  String natureOfBuilding = '';
  String space = '';
  String lightAndVentilation = '';
  String conditionOfFloor = '';
  String conditionOfWall = '';
  String conditionOfCeiling = '';
  bool hasHazards = false;

  // Part 3: Area of Food Preparation/Serving/Display/Storage
  String generalCleanlinessPart3 = '';
  String safetyMeasuresForCleanliness = '';
  bool hasFlies = false;
  bool hasPests = false;
  bool hasFloor = false;
  String maintenanceOfWalls = '';
  String maintenanceOfCeilingPart3 = '';
  String spaceInWorkingArea = '';
  String dailyCleaning = '';
  bool riskOfContaminationFromToilets = false;
  bool adequateBins = false;
  bool hasUnnecessaryItems = false;
  bool cleaningToolsAvailable = false;
  bool hasObjectionableOdor = false;
  bool hasOpenDrains = false;
  bool areaUsedForSleeping = false;
  bool separateChoppingBoards = false;
  bool cleanlinessOfEquipment = false;
  bool suitabilityOfLayout = false;
  String lightAndVentilationPart3 = '';
  bool houseKeeping = false;
  bool waterSupplySuitable = false;

  // Constructor (optional, for initializing with default values or from JSON)
  H800FormData({
    this.id,
    this.suitabilityForBusiness = '',
    this.generalCleanliness = '',
    this.hasPollutingConditions = false,
    this.hasAnimals = false,
    this.hasSmokeOrAdverseEffects = false,
    this.natureOfBuilding = '',
    this.space = '',
    this.lightAndVentilation = '',
    this.conditionOfFloor = '',
    this.conditionOfWall = '',
    this.conditionOfCeiling = '',
    this.hasHazards = false,
    this.generalCleanlinessPart3 = '',
    this.safetyMeasuresForCleanliness = '',
    this.hasFlies = false,
    this.hasPests = false,
    this.hasFloor = false,
    this.maintenanceOfWalls = '',
    this.maintenanceOfCeilingPart3 = '',
    this.spaceInWorkingArea = '',
    this.dailyCleaning = '',
    this.riskOfContaminationFromToilets = false,
    this.adequateBins = false,
    this.hasUnnecessaryItems = false,
    this.cleaningToolsAvailable = false,
    this.hasObjectionableOdor = false,
    this.hasOpenDrains = false,
    this.areaUsedForSleeping = false,
    this.separateChoppingBoards = false,
    this.cleanlinessOfEquipment = false,
    this.suitabilityOfLayout = false,
    this.lightAndVentilationPart3 = '',
    this.houseKeeping = false,
    this.waterSupplySuitable = false,
  });

  // Optional: Add methods for serialization if needed (e.g., to JSON)
  Map<String, dynamic> toJson() => {
        'id': id,
        'suitabilityForBusiness': suitabilityForBusiness,
        'generalCleanliness': generalCleanliness,
        'hasPollutingConditions': hasPollutingConditions,
        'hasAnimals': hasAnimals,
        'hasSmokeOrAdverseEffects': hasSmokeOrAdverseEffects,
        'natureOfBuilding': natureOfBuilding,
        'space': space,
        'lightAndVentilation': lightAndVentilation,
        'conditionOfFloor': conditionOfFloor,
        'conditionOfWall': conditionOfWall,
        'conditionOfCeiling': conditionOfCeiling,
        'hasHazards': hasHazards,
        'generalCleanlinessPart3': generalCleanlinessPart3,
        'safetyMeasuresForCleanliness': safetyMeasuresForCleanliness,
        'hasFlies': hasFlies,
        'hasPests': hasPests,
        'hasFloor': hasFloor,
        'maintenanceOfWalls': maintenanceOfWalls,
        'maintenanceOfCeilingPart3': maintenanceOfCeilingPart3,
        'spaceInWorkingArea': spaceInWorkingArea,
        'dailyCleaning': dailyCleaning,
        'riskOfContaminationFromToilets': riskOfContaminationFromToilets,
        'adequateBins': adequateBins,
        'hasUnnecessaryItems': hasUnnecessaryItems,
        'cleaningToolsAvailable': cleaningToolsAvailable,
        'hasObjectionableOdor': hasObjectionableOdor,
        'hasOpenDrains': hasOpenDrains,
        'areaUsedForSleeping': areaUsedForSleeping,
        'separateChoppingBoards': separateChoppingBoards,
        'cleanlinessOfEquipment': cleanlinessOfEquipment,
        'suitabilityOfLayout': suitabilityOfLayout,
        'lightAndVentilationPart3': lightAndVentilationPart3,
        'houseKeeping': houseKeeping,
        'waterSupplySuitable': waterSupplySuitable,
      };

  factory H800FormData.fromJson(Map<String, dynamic> json) => H800FormData(
        id: json['id'],
        suitabilityForBusiness: json['suitabilityForBusiness'] ?? '',
        generalCleanliness: json['generalCleanliness'] ?? '',
        hasPollutingConditions: json['hasPollutingConditions'] ?? false,
        hasAnimals: json['hasAnimals'] ?? false,
        hasSmokeOrAdverseEffects: json['hasSmokeOrAdverseEffects'] ?? false,
        natureOfBuilding: json['natureOfBuilding'] ?? '',
        space: json['space'] ?? '',
        lightAndVentilation: json['lightAndVentilation'] ?? '',
        conditionOfFloor: json['conditionOfFloor'] ?? '',
        conditionOfWall: json['conditionOfWall'] ?? '',
        conditionOfCeiling: json['conditionOfCeiling'] ?? '',
        hasHazards: json['hasHazards'] ?? false,
        generalCleanlinessPart3: json['generalCleanlinessPart3'] ?? '',
        safetyMeasuresForCleanliness: json['safetyMeasuresForCleanliness'] ?? '',
        hasFlies: json['hasFlies'] ?? false,
        hasPests: json['hasPests'] ?? false,
        hasFloor: json['hasFloor'] ?? false,
        maintenanceOfWalls: json['maintenanceOfWalls'] ?? '',
        maintenanceOfCeilingPart3: json['maintenanceOfCeilingPart3'] ?? '',
        spaceInWorkingArea: json['spaceInWorkingArea'] ?? '',
        dailyCleaning: json['dailyCleaning'] ?? '',
        riskOfContaminationFromToilets: json['riskOfContaminationFromToilets'] ?? false,
        adequateBins: json['adequateBins'] ?? false,
        hasUnnecessaryItems: json['hasUnnecessaryItems'] ?? false,
        cleaningToolsAvailable: json['cleaningToolsAvailable'] ?? false,
        hasObjectionableOdor: json['hasObjectionableOdor'] ?? false,
        hasOpenDrains: json['hasOpenDrains'] ?? false,
        areaUsedForSleeping: json['areaUsedForSleeping'] ?? false,
        separateChoppingBoards: json['separateChoppingBoards'] ?? false,
        cleanlinessOfEquipment: json['cleanlinessOfEquipment'] ?? false,
        suitabilityOfLayout: json['suitabilityOfLayout'] ?? false,
        lightAndVentilationPart3: json['lightAndVentilationPart3'] ?? '',
        houseKeeping: json['houseKeeping'] ?? false,
        waterSupplySuitable: json['waterSupplySuitable'] ?? false,
      );

  // Add this method inside the H800FormData class
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'suitabilityForBusiness': suitabilityForBusiness,
      'generalCleanliness': generalCleanliness,
      'hasPollutingConditions': hasPollutingConditions,
      'hasAnimals': hasAnimals,
      'hasSmokeOrAdverseEffects': hasSmokeOrAdverseEffects,
      'natureOfBuilding': natureOfBuilding,
      'space': space,
      'lightAndVentilation': lightAndVentilation,
      'conditionOfFloor': conditionOfFloor,
      'conditionOfWall': conditionOfWall,
      'conditionOfCeiling': conditionOfCeiling,
      'hasHazards': hasHazards,
      'generalCleanlinessPart3': generalCleanlinessPart3,
      'safetyMeasuresForCleanliness': safetyMeasuresForCleanliness,
      'hasFlies': hasFlies,
      'hasPests': hasPests,
      'hasFloor': hasFloor,
      'maintenanceOfWalls': maintenanceOfWalls,
      'maintenanceOfCeilingPart3': maintenanceOfCeilingPart3,
      'spaceInWorkingArea': spaceInWorkingArea,
      'dailyCleaning': dailyCleaning,
      'riskOfContaminationFromToilets': riskOfContaminationFromToilets,
      'adequateBins': adequateBins,
      'hasUnnecessaryItems': hasUnnecessaryItems,
      'cleaningToolsAvailable': cleaningToolsAvailable,
      'hasObjectionableOdor': hasObjectionableOdor,
      'hasOpenDrains': hasOpenDrains,
      'areaUsedForSleeping': areaUsedForSleeping,
      'separateChoppingBoards': separateChoppingBoards,
      'cleanlinessOfEquipment': cleanlinessOfEquipment,
      'suitabilityOfLayout': suitabilityOfLayout,
      'lightAndVentilationPart3': lightAndVentilationPart3,
      'houseKeeping': houseKeeping,
      'waterSupplySuitable': waterSupplySuitable,
    };
  }
}