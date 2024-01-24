import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rova_23/controllers/CropDiseaseResultController.dart';

// import 'package:rova_23/controllers/crop_info_controller.dart';
//import 'package:rova_23/controllers/crop_info_controller1.dart';
import 'package:rova_23/models/CropInfoModel.dart';

//import 'package:rova_23/models/crop_info_model12.dart';

class ResultScreen extends StatefulWidget {
  final String data;
  final CropInfoModel cropInfoModel;

  ResultScreen({
    Key? key,
    required this.cropInfoModel,
    required this.data,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  CropDiseaseResultController _controllerDiseaseResultController =
      CropDiseaseResultController();
  bool showLoader = true;

  @override
  void initState() {
    super.initState();

    if (widget.cropInfoModel.accuracy! > 85)
      _controllerDiseaseResultController
          .fetchCropDiseaseInfo(widget.cropInfoModel.type!);
    print("widget :${widget.cropInfoModel.accuracy!} ");
    // _fetchCropInfo();
  }

  List<String> symptoms = [
    "Water-soaked black lesions on leaves and stems",
    "Lesions expand rapidly and the entire leaf becomes necrotic.",
    "White sporulation (sporangia and sporangiophores) on leaves."
  ];

  // Future<void> _fetchCropInfo() async {
  //   try {
  //     await _cropInfoController.fetchCropInfo(widget.cropInfoModel!.type!);
  //     await _fetchCropDetails();
  //     setState(() {
  //       showLoader = false;
  //     });
  //   } catch (error) {
  //     // Handle error
  //     print("Error fetching crop information: $error");
  //     setState(() {
  //       showLoader = false;
  //     });
  //   }
  // }

  // Future<void> _fetchCropDetails() async {
  //   try {
  //     await _cropInfoController1.fetchCropdetails(
  //         _cropInfoController1.cropInfoModel12.modelName ?? "");
  //   } catch (error) {
  //     // Handle error
  //     print("Error fetching crop details: $error");
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     body: ValueListenableBuilder<bool>(
  //       valueListenable: _controllerDiseaseResultController.isLoadingState,
  //       builder: (BuildContext context, bool value, child) {
  //         return _controllerDiseaseResultController.isLoadingState.value
  //             ? Center(
  //                 child: CircularProgressIndicator(
  //                   color: Colors.green,
  //                 ),
  //               )
  //             : SafeArea(
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       Center(
  //                         child: Container(
  //                           width: 350,
  //                           height: 200,
  //                           margin: const EdgeInsets.only(top: 15),
  //                           child: CircleAvatar(
  //                             backgroundImage: FileImage(File(widget.data)),
  //                             radius: 0.0,
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 350,
  //                         margin: const EdgeInsets.only(top: 10),
  //                         child: Text(
  //                           'type: ${widget.cropInfoModel.type ?? ""}',
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 350,
  //                         margin: const EdgeInsets.only(top: 10),
  //                         child: Text(
  //                           'Accuracy: ${widget.cropInfoModel.accuracy ?? ""}',
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       // Display crop details
  //                       Container(
  //                         width: 350,
  //                         margin: const EdgeInsets.only(top: 10),
  //                         child: Text(
  //                           'Crop Name:',
  //                           //   ${widget.cropInfoModel12.cropName ?? ""}',
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 350,
  //                         margin: const EdgeInsets.only(top: 10),
  //                         child: Text(
  //                           'Crop Disease Name:',
  //                           //   ${widget.cropInfoModel12.diseaseName ?? ""}',
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 350,
  //                         margin: const EdgeInsets.only(top: 10),
  //                         child: Text(
  //                           'Symptoms:',
  //                           // ${widget.cropInfoModel12.symptoms?.join(", ") ?? ""}',
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 350,
  //                         margin: const EdgeInsets.only(top: 10),
  //                         child: Text(
  //                           'Solutions:',
  //                           //    ${widget.cropInfoModel12.solutions?.join(", ") ?? ""}',
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 350,
  //                         margin: const EdgeInsets.only(top: 10),
  //                         child: Text(
  //                           'Model Name:',
  //                           textAlign: TextAlign.left,
  //                           style: TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<bool>(
          valueListenable: _controllerDiseaseResultController.isLoadingState,
          builder: (BuildContext context, bool value, child) {
            return _controllerDiseaseResultController.isLoadingState.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back),
                        ),

                        // Container(
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width,
                        //     height: MediaQuery.of(context).size.height * 0.4,
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: FileImage(File(widget.data)),
                        //         fit: BoxFit.fill,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Image.file(
                          File(widget.data),
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),

                        widget.cropInfoModel.accuracy! > 85
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                width: MediaQuery.of(context).size.width,
                                //   height: MediaQuery.of(context).size.height * 0.6,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(26),
                                      topRight: Radius.circular(26),
                                    ),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      blurRadius: 16,
                                      offset: Offset(0, -6),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Hurray, we identified the Disease',
                                            style: TextStyle(
                                              color: Color(0xFF6EA646),
                                              fontSize: 16,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        _controllerDiseaseResultController
                                                .cropDiseaseResultModel
                                                .data!
                                                .cropDiseaseName ??
                                            "",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 30,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Symptoms',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 22,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          var item =
                                              _controllerDiseaseResultController
                                                      .cropDiseaseResultModel
                                                      .data!
                                                      .symptoms ??
                                                  [];
                                          return Text(
                                            '${item[index]}',
                                            style: TextStyle(
                                              color: Color(0xFF011928),
                                              fontSize: 17,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          );
                                        },
                                        itemCount:
                                            _controllerDiseaseResultController
                                                    .cropDiseaseResultModel
                                                    .data!
                                                    .symptoms!
                                                    .length ??
                                                0,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 10,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Solutions',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 22,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          var item =
                                              _controllerDiseaseResultController
                                                      .cropDiseaseResultModel
                                                      .data!
                                                      .solutions ??
                                                  [];

                                          return Text(
                                            '${item[index]}',
                                            style: TextStyle(
                                              color: Color(0xFF011928),
                                              fontSize: 17,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          );
                                        },
                                        itemCount: symptoms.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 10,
                                        ),
                                      ),
                                    ]))
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(26),
                                      topRight: Radius.circular(26),
                                    ),
                                  ),
                                  shadows: [
                                    // BoxShadow(
                                    //   color: Color(0x26000000),
                                    //   blurRadius: 16,
                                    //   offset: Offset(0, -6),
                                    //   spreadRadius: 0,
                                    // )
                                  ],
                                ),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.max,
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: Center(
                                        child: Text(
                                          "We are unable to get the solution for your disease. For improved results, please click a picture with the appropriate angle.",
                                          style: TextStyle(
                                            color: Color(0xFF011928),
                                            fontSize: 18,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  );
          },
        ),
        bottomNavigationBar: widget.cropInfoModel.accuracy! > 85
            ? Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                width: MediaQuery.of(context).size.width,
                decoration: ShapeDecoration(
                  color: Color(0xFF6EA646),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    backgroundColor: Color(0xFF6EA646),
                  ),
                  child: Text(
                    'Search nearby stores',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {},
                ),
              )
            : SizedBox());
  }
}
