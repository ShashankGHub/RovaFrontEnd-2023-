import 'package:flutter/material.dart';

class Stage1Screen extends StatelessWidget {
  final String cropName;
  final String stage;

  Stage1Screen({required this.cropName, required this.stage});

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
    if (stage == 'Stage I: About The Crop') {
      if (cropName == 'Tomato') {
        return '''Tomato, (Solanum lycopersicum), a flowering plant of the nightshade family (Solanaceae), cultivated extensively for its edible fruits.
Labelled as a vegetable for nutritional purposes, tomatoes are a good source of vitamin C and the phytochemical lycopene.
The fruits are commonly eaten raw in salads, served as a cooked vegetable, used as an ingredient in various prepared dishes, and pickled.
Additionally, a large percentage of the world's tomato crop is processed; products include canned tomatoes, tomato juice, ketchup, puree, paste, and "sun-dried" tomatoes or dehydrated pulp.
        ''';
      } else if (cropName == 'Mango') {
        return '''Mango (Mangifera Indica) is the most ancient among the tropical fruits and is believed to have originated in the Indo-Burma region.
India is the major mango-producing country in the world with an annual production of 8.50 million tonnes from an area of one million hectares.
Mango is basically a tropical plant but endures a wide range of temperatures. It grows well under tropical and sub-tropical conditions.
It gives a profitable yield in semi-arid conditions, especially with irrigation.
        ''';
      } else if (cropName == 'Cucumber') {
        return '''Cucumber(Cucumis sativus) is cultivated for fresh consumption or as pickling cucumber for preservation, marinated with vinegar, salt, dill, or other spices.
It is an important salad crop cultivated both in the north and south and on lower and higher hills in India.
Fruits varying in shape, size, and colour contain 0.4% protein, 2.5% carbohydrates, 1.5mg iron, and 2mg of vitamin C in 100 gm of fresh weight.
Fruits are good for people suffering from constipation, jaundice, and indigestion.
        ''';
      }
    }

    return 'No data available for $cropName - $stage';
  }
}
