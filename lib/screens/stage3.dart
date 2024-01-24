import 'package:flutter/material.dart';

class Stage3Screen extends StatelessWidget {
  late final String cropName;
  late final String stage;

  Stage3Screen({required this.cropName, required this.stage});

  @override
  Widget build(BuildContext context) {
    String stageData = getStageData(cropName, stage);

    return Scaffold(
      appBar: AppBar(
        title: Text(stage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About $cropName - $stage",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              stageData,
              style: TextStyle(
                  fontSize: 16.0, color: Color.fromARGB(255, 13, 9, 9)),
            ),
          ],
        ),
      ),
    );
  }

  String getStageData(String cropName, String stage) {
    if (stage == 'Stage III: Plant Nutrition') {
      if (cropName == 'Tomato') {
        return 'Nitrogen and potassium uptake is initially slow but rapidly increases during the flowering stages. Potassium is peaking during fruit development, and nitrogen uptake occurs mainly after the formation of the first fruit.';
      } else if (cropName == 'Mango') {
        return 'Although there are at least 14 elements or nutrients that are required for plant growth, the 4 key nutrients for mango production are nitrogen (N), potassium (K), calcium (Ca) and boron (B). Understanding the interactions of these 4 nutrients is the key to good productivity and fruit quality in mangoes.';
      } else if (cropName == 'Cucumber') {
        return '''Cucumbers need moderate nitrogen and high phosphorus and potassium, so an organic plant food with the first number lower than the last two (like 3-4-6) is good. Keep plants well-watered to avoid bitter-tasting cucumbers.
Cucumbers require different levels of nutrients at different stages of growth:
  - Growth: Cucumbers need more nitrogen during this stage.
  - Flowering and setting fruit: Cucumbers need more potassium during this stage.

Some common nutrient disorders in cucumber plants include:
  - Potassium deficiency: This causes yellowing between the veins of the oldest leaves.
  - Boron deficiency: This causes yellow streaks and corky markings on the fruit.
      ''';
      }
    }

    // Default return if no matching crop or stage is found
    return 'No data available for $cropName - $stage';
  }
}
