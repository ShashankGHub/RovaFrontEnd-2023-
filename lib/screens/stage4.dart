import 'package:flutter/material.dart';

class Stage4Screen extends StatelessWidget {
  late final String cropName;
  late final String stage;

  Stage4Screen({required this.cropName, required this.stage});

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
    if (stage == 'Stage IV: Fertilizer Suggestion') {
      if (cropName == 'Tomato') {
        return '''The fertilizer dose depends upon the fertility of the soil and the amount of organic manure applied to the crop. For a good yield, 15-20 tonnes of well-decomposed FYM is incorporated into the soil.

Generally, the application of 120 kg N, 80 kg P205, and 50 kg K20 per hectare is recommended for getting optimum yield. Half the dose of N and the full dose of P and K are given at the time of planting. The balance half of N is given as top dressing 30 days after transplanting.

For hybrid varieties, the recommended dose per hectare is 180 kg N, 100 kg P2O5, and 60 kg K2O. Sixty kg N and half of P & K are given at the time of transplanting. Remaining quantities of P & K and 60 kg N are top-dressed 30 days after transplanting. A third dose of 60 kg N is applied 50 days after transplanting.

Spray 1.25 ppm (625 ml in 500 litres of water) Triacontanol/BIOMAXX/HORTICULTURE SPECIAL 400-50OML/ACRE at 15 days after transplanting and at the full bloom stage to increase the yield.
      ''';
      } else if (cropName == 'Mango') {
        return '''A young orchard should be supplied with 10 kg FYM + 100 Kg Nitrogen (N) + 50 g Phosphorus (P205) + 100 g Potassium (K2O) per tree in the first year, and it should be increased with age.

The 10-year-old tree should get FYM + 1 Kg N + 500 g P205 + 1000 g K20. If irrigation is available, an additional dose of 500 g N should be given in the month of February - March.

Apply Criyagen DNP 50-150g/pit.

Foliar spray: Criyagen zyme - 3ml/liter + All 19 @ 5gm/liter for plant development (1st - 20 days after planting, 2nd- 30 days after 1st spray). Drench Criyagen Bio-Humate 5 ml/litre 3-4 times per year with a gap of 30-40 days.
      ''';
      } else if (cropName == 'Cucumber') {
        return '''
Manures and Fertilizers:
  40 to 50 cartloads well decomposed FarmYard Manure (FYM) should be added at the time of soil preparation.

At the time of land preparation apply fertilizer dose of Nitrogen @ 40 kg (Urea @ 90kg), Phosphorus @ 20 kg (Single phosphate @ 125 kg) and Potassium @ 20 kg (Muriate of potash @ 35 kg) as a basal dose. At the time of sowing, apply one-third of the Nitrogen dose along with Potassium and Single superphosphate. At the early stage of vein production i.e. one month of sowing apply the rest of the dose.

Some fertilizers that can be used for cucumbers include:
  - Organic plant food: With the first number lower than the last two.
  - Potassium nitrate: Such as Multi-K™.
  - Calcium nitrate: Such as Haifa Cal™.
  - Ammonium nitrate: Such as 33-0-0.
      ''';
      }
    }

    // Default return if no matching crop or stage is found
    return 'No data available for $cropName - $stage';
  }
}
