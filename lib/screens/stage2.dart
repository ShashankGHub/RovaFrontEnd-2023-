import 'package:flutter/material.dart';

class Stage2Screen extends StatelessWidget {
  late final String cropName;
  late final String stage;

  Stage2Screen({required this.cropName, required this.stage});

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
    if (stage == 'Stage II: Fertilizer Suggestion') {
      if (cropName == 'Tomato') {
        return '''Tomato is a warm-season crop. The best fruit color and quality are obtained at a temperature range of 21-24°C. Temperatures above 32°C adversely affect the fruit set and development. The plants cannot withstand frost and high humidity. It requires low to medium rainfall. Bright sunshine at the time of fruit set helps develop dark red-colored fruits.
        ''';
      } else if (cropName == 'Mango') {
        return '''Mango (Mangifera Indica) is the most ancient among the tropical fruits and believed to have originated in the Indo-Burma region. India is the major mango-producing country in the world with an annual production of 8.50 million tons from an area of one million hectares. Mango is basically a tropical plant but endures a wide range of temperature. It grows well under tropical and sub-tropical conditions. It gives a profitable yield in semi-arid conditions, especially with irrigation.
        ''';
      } else if (cropName == 'Cucumber') {
        return '''In southern and central India, it is sown in October-November. In the plains of northeastern India, sowing time is from November to March when the weather is comparatively dry. In Maharashtra, it should be sown in January-February (summer crop) and June-July (rainy season crop). Generally, soaking of seeds in water or 0.1% Bavistin for a few hours before sowing enhances their germination. In India, furrow bed and pit (deep and shallow mounds) sowing methods are followed. In furrow sowing, furrows are made at 1.0-1.5m apart. Usually, sowing is done on the top of the sides of furrows, and vines are allowed to trail on the ground, especially in the summer season. The hills should be made at a distance of 0.5-0.75m. About 5-6 seeds are sown in a pit, and finally, two vines are retained.
        ''';
      }
    }

    // Default return if no matching crop or stage is found
    return 'No data available for $cropName - $stage';
  }
}
