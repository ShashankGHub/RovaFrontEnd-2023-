import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rova_23/controllers/crop_info_controller.dart';
import 'package:rova_23/controllers/crop_info_controller1.dart';
import 'package:rova_23/models/CropInfoModel.dart';
import 'package:rova_23/models/crop_info_model12.dart';
import 'package:rova_23/screens/result_screen.dart';

class SelectCropModel {
  final String crop_name;
  final String crop_image;

  SelectCropModel(this.crop_name, this.crop_image);
}

class SelectCropsScreen extends StatefulWidget {
  final String data;

  const SelectCropsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<SelectCropsScreen> createState() => _SelectCropsScreenState();
}

class _SelectCropsScreenState extends State<SelectCropsScreen> {
  CropInfoController _controller = CropInfoController();
  CropInfoController1 _controller1 = CropInfoController1();

  bool showLoader = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.isLoadingState.dispose();
  }

  List<int> selectedItems = [];

  static List<SelectCropModel> mainSelectCropList = [
    SelectCropModel('Mango', 'images/mango.png'),
    SelectCropModel('Tomato', 'images/tomato.png'),
    SelectCropModel('Cucumber', 'images/cucumber.png'),
    SelectCropModel('Sunflower', 'images/sunflower.png'),
    SelectCropModel('Cotton', 'images/cotton.png'),
    SelectCropModel('Groundnut', 'images/groundnut.png'),
    SelectCropModel('Potato', 'images/potato.png'),
    // SelectCropModel('Banana', 'images/banana.png'),
    // SelectCropModel('Bean', 'images/beans.png'),
    // SelectCropModel('Brinjal', 'images/brinjal.png'),
    // SelectCropModel('Cabbage', 'images/cabbage.png'),
    // SelectCropModel('Capsicum', 'images/capsicum.png'),
    // SelectCropModel('Chickpea', 'images/chickpea.png'),
    // //SelectCropModel('Cotton', 'images/cotton.png'),
    // SelectCropModel('Ginger', 'images/ginger.png'),
  ];

  List<SelectCropModel> displaySelectCropList = List.from(mainSelectCropList);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF1F1F1),
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<bool>(
        valueListenable: _controller.isLoadingState,
        builder: (BuildContext context, bool value, child) {
          return _controller.isLoadingState.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: SafeArea(
                      left: true,
                      top: true,
                      right: true,
                      bottom: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: const Color(0xFFF1F1F1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Select crops',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.3,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Select up to multiple crops you are interested in',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.1,
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${selectedItems.length}/${mainSelectCropList.length}',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.2,
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: const Text(
                                      'You can always change it later',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.1,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 220,
                              child: CustomScrollView(
                                slivers: [
                                  SliverGrid(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 10,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        final isSelected =
                                            selectedItems.contains(index);
                                        return InkWell(
                                          onTap: () {
                                            if (isSelected) {
                                              selectedItems.remove(index);
                                            } else {
                                              selectedItems.add(index);
                                            }
                                            print(selectedItems);
                                            setState(() {});
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 120,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? const Color
                                                              .fromARGB(
                                                              255,
                                                              1,
                                                              39,
                                                              70,
                                                            )
                                                          : Colors.white,
                                                      width: 1,
                                                    ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 2,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(40),
                                                    ),
                                                  ),
                                                  child: Image.asset(
                                                    '${displaySelectCropList[index].crop_image}',
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 100,
                                                  margin: const EdgeInsets.only(
                                                      top: 5),
                                                  child: Text(
                                                    '${displaySelectCropList[index].crop_name}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Color(0xFF3D1766),
                                                      fontSize: 16,
                                                      letterSpacing: 0.3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: displaySelectCropList.length,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0.4,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () async {
                                  _controller.isLoadingState.value = true;
                                  _controller.isLoadingState.notifyListeners();

                                  // Fetch crop info
                                  var res = await _controller
                                      .fetchCropInfo(widget.data);

                                  // Fetch crop details
                                  try {
                                    await _controller1.fetchCropdetails(
                                        _controller1
                                                .cropInfoModel12.modelName ??
                                            "");
                                  } catch (error) {
                                    // Handle error fetching crop details
                                    print(
                                        "Error fetching crop details: $error");
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                        data: widget.data,
                                        cropInfoModel:
                                            _controller.cropInfoModel,
                                        cropInfoModel12:
                                            _controller1.cropInfoModel12,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0.4,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
