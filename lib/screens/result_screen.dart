import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rova_23/controllers/crop_info_controller.dart';
import 'package:rova_23/controllers/crop_info_controller1.dart';
import 'package:rova_23/models/CropInfoModel.dart';
import 'package:rova_23/models/crop_info_model12.dart';

class ResultScreen extends StatefulWidget {
  final String data;
  final CropInfoModel cropInfoModel; // Type and accuracy model
  final CropInfoModel12 cropInfoModel12; // Crop details model

  const ResultScreen({
    Key? key,
    required this.data,
    required this.cropInfoModel,
    required this.cropInfoModel12,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  CropInfoController _cropInfoController = CropInfoController();
  CropInfoController1 _cropInfoController1 = CropInfoController1();
  bool showLoader = true;

  @override
  void initState() {
    super.initState();
    _fetchCropInfo();
  }

  Future<void> _fetchCropInfo() async {
    try {
      await _cropInfoController.fetchCropInfo(widget.data);
      await _fetchCropDetails();
      setState(() {
        showLoader = false;
      });
    } catch (error) {
      // Handle error
      print("Error fetching crop information: $error");
      setState(() {
        showLoader = false;
      });
    }
  }

  Future<void> _fetchCropDetails() async {
    try {
      await _cropInfoController1.fetchCropdetails(
          _cropInfoController1.cropInfoModel12.modelName ?? "");
    } catch (error) {
      // Handle error
      print("Error fetching crop details: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: showLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 350,
                        height: 200,
                        margin: const EdgeInsets.only(top: 15),
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(widget.data)),
                          radius: 0.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'type: ${widget.cropInfoModel.type ?? ""}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Accuracy: ${widget.cropInfoModel.accuracy ?? ""}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Display crop details
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Crop Name: ${widget.cropInfoModel12.cropName ?? ""}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Crop Disease Name: ${widget.cropInfoModel12.diseaseName ?? ""}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Symptoms: ${widget.cropInfoModel12.symptoms?.join(", ") ?? ""}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Solutions: ${widget.cropInfoModel12.solutions?.join(", ") ?? ""}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Model Name: ${widget.cropInfoModel12.modelName ?? ""}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
