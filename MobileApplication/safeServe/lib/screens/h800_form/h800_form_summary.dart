import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safeserve/screens/h800_form/photo_upload_screen.dart';
import '../../widgets/safe_serve_appbar.dart';
import '../register_shop/screen_one/widgets/register_shop_header.dart';
import 'h800_form_data.dart';
import 'widgets/h800_form_button.dart';

class H800FormSummary extends StatelessWidget {
  final H800FormData formData;
  final String shopId;
  final String phiId;

  const H800FormSummary({
    super.key,
    required this.formData,
    required this.shopId,
    required this.phiId,
  });

  // Helper method to calculate scores for each part
  Map<String, int> calculatePartScores() {
    int part1 = 0;
    int part2 = 0;
    int part3 = 0;
    int part4 = 0;
    int part5 = 0;
    int part6 = 0;
    int part7 = 0;
    int part8 = 0;
    int part9 = 0;
    int part10 = 0;

    // Part 1: Location & Environment (5 Marks)
    part1 += formData.suitabilityForBusiness == 'Suitable' ? 1 : 0;
    part1 += formData.generalCleanliness == 'Satisfactory' ? 1 : 0;
    part1 += formData.hasPollutingConditions == 'Yes' ? 0 : 1;
    part1 += formData.hasAnimals == 'Yes' ? 0 : 1;
    part1 += formData.hasSmokeOrAdverseEffects == 'Yes' ? 0 : 1;

    // Part 2: Building (10 Marks)
    part2 += formData.natureOfBuilding == 'Permanent' ? 1 : 0;
    part2 += formData.space == 'Adequate' ? 1 : 0;
    part2 += formData.lightAndVentilation == 'Adequate' ? 1 : 0;
    part2 += formData.conditionOfFloor == 'Good'
        ? 2
        : (formData.conditionOfFloor == 'Satisfactory' ? 1 : 0);
    part2 += formData.conditionOfWall == 'Good'
        ? 2
        : (formData.conditionOfWall == 'Satisfactory' ? 1 : 0);
    part2 += formData.conditionOfCeiling == 'Good'
        ? 2
        : (formData.conditionOfCeiling == 'Satisfactory' ? 1 : 0);
    part2 += formData.hasHazards == 'Yes' ? 0 : 1;

    // Part 3: Area of Food Preparation/Serving/Display/Storage (30 Marks)
    part3 += formData.generalCleanlinessPart3 == 'Good'
        ? 2
        : (formData.generalCleanlinessPart3 == 'Satisfactory' ? 1 : 0);
    part3 += formData.safetyMeasuresForCleanliness == 'Good'
        ? 2
        : (formData.safetyMeasuresForCleanliness == 'Satisfactory' ? 1 : 0);
    part3 += formData.hasFlies == 'Yes' ? 0 : 1;
    part3 += formData.hasPests == 'Yes' ? 0 : 1;
    part3 += formData.hasFloor == 'Good'
        ? 2
        : (formData.hasFloor == 'Satisfactory' ? 1 : 0);
    part3 += formData.maintenanceOfWalls == 'Good'
        ? 2
        : (formData.maintenanceOfWalls == 'Satisfactory' ? 1 : 0);
    part3 += formData.maintenanceOfCeilingPart3 == 'Good'
        ? 2
        : (formData.maintenanceOfCeilingPart3 == 'Satisfactory' ? 1 : 0);
    part3 += formData.spaceInWorkingArea == 'Adequate' ? 1 : 0;
    part3 += formData.dailyCleaning == 'Yes' ? 1 : 0;
    part3 += formData.riskOfContaminationFromToilets == 'Yes' ? 0 : 1;
    part3 += formData.adequateBins == 'Yes' ? 1 : 0;
    part3 += formData.hasUnnecessaryItems == 'Yes' ? 0 : 1;
    part3 += formData.cleaningToolsAvailable == 'Yes' ? 1 : 0;
    part3 += formData.hasObjectionableOdor == 'Yes' ? 0 : 1;
    part3 += formData.hasOpenDrains == 'Yes' ? 0 : 1;
    part3 += formData.areaUsedForSleeping == 'Yes' ? 0 : 1;
    part3 += formData.separateChoppingBoards == 'Yes' ? 1 : 0;
    part3 += formData.cleanlinessOfEquipment == 'Yes' ? 1 : 0;
    part3 += formData.suitabilityOfLayout == 'Yes' ? 1 : 0;
    part3 += formData.lightAndVentilationPart3 == 'Adequate' ? 1 : 0;
    part3 += formData.houseKeeping == 'Good'
        ? 2
        : (formData.houseKeeping == 'Satisfactory' ? 1 : 0);
    part3 += formData.waterSupplySuitable == 'Yes' ? 1 : 0;
    part3 += formData.safeFoodHandling == 'Good'
        ? 2
        : (formData.safeFoodHandling == 'Satisfactory' ? 1 : 0);

    // Part 4: Equipment & Furniture (10 Marks)
    part4 += formData.equipmentForFoodHandling == 'Adequate' ? 1 : 0;
    part4 += formData.conditionOfEquipment == 'Satisfactory' ? 1 : 0;
    part4 += formData.cleanOfEquipment == 'Satisfactory' ? 1 : 0;
    part4 += formData.foodTongsAvailable == 'Yes' ? 1 : 0;
    part4 += formData.storageCleanEquip == 'Yes' ? 1 : 0;
    part4 += formData.suitableSafetyofFurniture == 'Satisfactory' ? 1 : 0;
    part4 += formData.furnitureCondition == 'Adequate' ? 1 : 0;
    part4 +=
        formData.cleaningAndMaintenanceOfFurniture == 'Satisfactory' ? 1 : 0;
    part4 += formData.maintenanceOfRefrigerators == 'Satisfactory' ? 1 : 0;
    part4 +=
        formData.cleanandMaintenanceOfRefrigerators == 'Satisfactory' ? 1 : 0;

    // Part 5: Storage (10 Marks)
    part5 += formData.storageFacilities == 'Good'
        ? 2
        : (formData.storageFacilities == 'Satisfactory' ? 1 : 0);
    part5 += formData.storageOfRawMaterials == 'Good'
        ? 2
        : (formData.storageOfRawMaterials == 'Satisfactory' ? 1 : 0);
    part5 += formData.storageOfCookedFood == 'Good'
        ? 2
        : (formData.storageOfCookedFood == 'Satisfactory' ? 1 : 0);
    part5 += formData.foodStoredTemp == 'Yes' ? 1 : 0;
    part5 += formData.storageInRefrigerator == 'Satisfactory' ? 1 : 0;
    part5 += formData.measuresToPreventContamination == 'Good'
        ? 2
        : (formData.measuresToPreventContamination == 'Satisfactory' ? 1 : 0);

    // Part 6: Water Supply (5 Marks)
    part6 += formData.waterSource == 'Safe' ? 1 : 0;
    part6 += formData.waterStorageMethod == 'Satisfactory' ? 1 : 0;
    part6 += formData.waterDispensedThroughTaps == 'Yes' ? 1 : 0;
    part6 += formData.waterSafetyCertified == 'Yes' ? 2 : 0;

    // Part 7: Waste Management (10 Marks)
    part7 += formData.numberofBinswithLids == 'Available' ? 1 : 0;
    part7 += formData.lidsOfBinsClosed == 'Yes' ? 1 : 0;
    part7 += formData.cleanlinessOfWasteBins == 'Satisfactory' ? 1 : 0;
    part7 += formData.seperationofWaste == 'Yes' ? 1 : 0;
    part7 += formData.disposalOfWaste == 'Safe' ? 1 : 0;
    part7 += formData.managementofWasteWater == 'Safe' ? 1 : 0;
    part7 += formData.adequateNumberOfToilets == 'Yes' ? 1 : 0;
    part7 += formData.locationOfToilets == 'Safe' ? 1 : 0;
    part7 += formData.cleanlinessOfToilets == 'Satisfactory' ? 1 : 0;
    part7 += formData.septicTankCondition == 'Safe' ? 1 : 0;

    // Part 8: Condition, Standard & Cleanliness of Food (5 Marks)
    part8 += formData.conditionOfFood == 'Satisfactory' ? 1 : 0;
    part8 += formData.displayPackaging == 'Satisfactory' ? 1 : 0;
    part8 += formData.insectInfested == 'Yes' ? 0 : 1;
    part8 += formData.violationOfLabeling == 'Yes' ? 0 : 1;
    part8 += formData.separationOfUnwholesomeFood == 'Yes' ? 1 : 0;

    // Part 9: Health Status and Training of Food Handlers (10 Marks)
    part9 += formData.personalHygiene == 'Good'
        ? 2
        : (formData.personalHygiene == 'Satisfactory' ? 1 : 0);
    part9 += formData.wearingProtectiveClothing == 'Good'
        ? 2
        : (formData.wearingProtectiveClothing == 'Satisfactory' ? 1 : 0);
    part9 += formData.communicableDiseases == 'Yes' ? 0 : 1;
    part9 += formData.goodHealthHabits == 'Practiced' ? 1 : 0;
    part9 += formData.healthRecords == 'Good'
        ? 2
        : (formData.healthRecords == 'Satisfactory' ? 1 : 0);
    part9 += formData.trainingRecords == 'Good'
        ? 2
        : (formData.trainingRecords == 'Satisfactory' ? 1 : 0);

    // Part 10: Display of Health Instructions, Record Keeping & Certification (5 Marks)
    part10 += formData.displayHealthInstructions == 'Yes' ? 1 : 0;
    part10 += formData.entertainsComplaints == 'Yes' ? 1 : 0;
    part10 += formData.preventSmoking == 'Yes' ? 1 : 0;
    part10 += formData.issuingBills == 'Yes' ? 1 : 0;
    part10 += formData.foodSafetyCertification == 'Yes' ? 1 : 0;

    return {
      'Part 1': part1,
      'Part 2': part2,
      'Part 3': part3,
      'Part 4': part4,
      'Part 5': part5,
      'Part 6': part6,
      'Part 7': part7,
      'Part 8': part8,
      'Part 9': part9,
      'Part 10': part10,
    };
  }



  @override
  Widget build(BuildContext context) {
    final partScores = calculatePartScores();
    final totalScore = formData.calculateTotalScore();
    const totalPossibleScore = 100;

    return Scaffold(
      appBar: SafeServeAppBar(
        height: 70,
        onMenuPressed: () {},
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                RegisterShopHeader(
                  title: 'H800 Form Summary',
                  onArrowPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Score Breakdown',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ...[
                              _buildScoreRow('Part 1: Location & Environment',
                                  partScores['Part 1']!, 5),
                              _buildScoreRow('Part 2: Building',
                                  partScores['Part 2']!, 10),
                              _buildScoreRow(
                                  'Part 3: Area of Food Preparation/Serving/Display/Storage',
                                  partScores['Part 3']!,
                                  30),
                              _buildScoreRow('Part 4: Equipment & Furniture',
                                  partScores['Part 4']!, 10),
                              _buildScoreRow(
                                  'Part 5: Storage', partScores['Part 5']!, 10),
                              _buildScoreRow('Part 6: Water Supply',
                                  partScores['Part 6']!, 5),
                              _buildScoreRow('Part 7: Waste Management',
                                  partScores['Part 7']!, 10),
                              _buildScoreRow(
                                  'Part 8: Condition, Standard & Cleanliness of Food',
                                  partScores['Part 8']!,
                                  5),
                              _buildScoreRow(
                                  'Part 9: Health Status and Training of Food Handlers',
                                  partScores['Part 9']!,
                                  10),
                              _buildScoreRow(
                                  'Part 10: Display of Health Instructions, Record Keeping & Certification',
                                  partScores['Part 10']!,
                                  5),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Divider(),
                            const SizedBox(height: 10),
                            _buildTotalScoreContainer(
                                totalScore, totalPossibleScore),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          H800FormButton(
                            label: 'Back',
                            onPressed: () => Navigator.pop(context),
                          ),
                          H800FormButton(
                            label: 'Submit',
                            onPressed: () {
                              // go to photo‑upload screen instead of direct DB write
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => H800PhotoUploadScreen(
                                    formData: formData,
                                    shopId: shopId,
                                    phiId: phiId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE6F5FE), Color(0xFFF5ECF9)],
        ),
      ),
    );
  }

  Widget _buildScoreRow(String title, int score, int maxScore) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            '$score / $maxScore',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalScoreContainer(int score, int maxScore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Score',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          '$score / $maxScore',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
