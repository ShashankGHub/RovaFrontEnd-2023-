import 'package:flutter/material.dart';
import 'stage1.dart';
import 'stage2.dart';
import 'stage3.dart';
import 'stage4.dart';

class CropDetailsScreen extends StatelessWidget {
  final String cropName;
  final String cropImagePath;

  CropDetailsScreen({required this.cropName, required this.cropImagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cropName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              cropImagePath,
              width: 100.0,
              height: 100.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'Growth Tips by Stages',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            _buildGrowthStages(context),
          ],
        ),
      ),
    );
  }

  void _navigateToStageDetails(BuildContext context, String stage) {
    switch (stage) {
      case 'Stage I: About The Crop':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Stage1Screen(cropName: cropName, stage: stage),
          ),
        );
        break;
      case 'Stage II: Fertilizer Suggestion':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Stage2Screen(cropName: cropName, stage: stage),
          ),
        );
        break;
      case 'Stage III: Plant Nutrition':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Stage3Screen(cropName: cropName, stage: stage),
          ),
        );
        break;
      case 'Stage IV: Fertilizer Suggestion':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Stage4Screen(cropName: cropName, stage: stage),
          ),
        );
        break;
      default:
    }
  }

  Widget _buildGrowthStage(
      BuildContext context, String imagePath, String stage, String details) {
    return GestureDetector(
      onTap: () {
        _navigateToStageDetails(context, stage);
      },
      child: Container(
        height: 180.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.asset(
                imagePath,
                width: 80.0,
                height: 80.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              stage,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              details,
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthStages(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildGrowthStage(
                context,
                'images/img1.png',
                'Stage I: About The Crop',
                'Keep the soil moist during.',
              ),
            ),
            Expanded(
              child: _buildGrowthStage(
                context,
                'images/img2.png',
                'Stage II: Fertilizer Suggestion',
                'Provide adequate sunlight.',
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildGrowthStage(
                context,
                'images/img3.png',
                'Stage III: Plant Nutrition',
                'Watch for pests and provide nutrients.',
              ),
            ),
            Expanded(
              child: _buildGrowthStage(
                context,
                'images/img4.png',
                'Stage IV: Fertilizer Suggestion',
                'Harvest the fruits.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
