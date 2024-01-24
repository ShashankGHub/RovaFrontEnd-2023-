import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rova_23/screens/crop_details_screen.dart';
import 'package:rova_23/Menu/settings_screen.dart';
import 'package:rova_23/screens/screens/storeScreen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = '';
  int _currentIndex = 0;
  String userName = ''; // Initial name

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
  }

  Future<void> _showOptionsDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('chooseOption'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('takePhoto'.tr),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImageFromCamera();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('accessGallery'.tr),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImageFromGallery();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageTemporary = image.path;
    }
  }

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageTemporary = image.path;
    }
  }

  Widget _buildCropBox(String cropName, String imagePath) {
    return Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green), // Set border color
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 70.0,
              height: 70.0,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(cropName),
      ],
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _showEditProfileDialog() async {
    String? newName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('editProfile'.tr),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    setState(() {
                      userName = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context,
                    userName); // Close the dialog and return the new name
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    // Update the name even if the user clicks outside the dialog to dismiss it
    if (newName != null) {
      setState(() {
        userName = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rova'.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: _openDrawer,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.cloud,
                                      color: Colors.lightBlueAccent,
                                      size: 50.0,
                                    ),
                                    Icon(
                                      Icons.wb_sunny,
                                      color: Colors.yellow,
                                      size: 50.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  location,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'partlyCloudy'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '22°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'Tumkur',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'detectDisease'.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto Slab',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      Image.asset(
                        'images/overview3.png',
                        width: 100.0,
                        height: 100.0,
                      ),
                      SizedBox(height: 8.0),
                      Text('scanInfectedCrop'.tr),
                    ],
                  ),
                  onTap: () {
                    _showOptionsDialog();
                  },
                ),
                Column(
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.green,
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'images/overview2.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    SizedBox(height: 8.0),
                    Text('getInstantReport'.tr),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'myCrops'.tr,
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 35.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CropDetailsScreen(
                          cropImagePath: 'images/tomato.png',
                          cropName: 'Tomato',
                        ),
                      ),
                    );
                  },
                  child: _buildCropBox('tomato'.tr, 'images/tomato.png'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CropDetailsScreen(
                          cropImagePath: 'images/mango.png',
                          cropName: 'Mango',
                        ),
                      ),
                    );
                  },
                  child: _buildCropBox('mango'.tr, 'images/mango.png'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CropDetailsScreen(
                          cropImagePath: 'images/cucumber.png',
                          cropName: 'Cucumber',
                        ),
                      ),
                    );
                  },
                  child: _buildCropBox('cucumber'.tr, 'images/cucumber.png'),
                ),
              ],
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFEEEEEE),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) {
              _showOptionsDialog();
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreScreen(),
                ),
              );
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Stack(
                children: [
                  Icon(Icons.qr_code_2_outlined),
                ],
              ),
            ),
            label: 'scan'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Store',
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              width: 307,
              color: Color.fromARGB(255, 232, 239, 232),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      userName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      '+1234567890', // Replace with the user's phone number
                      style: TextStyle(fontSize: 14.0),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://example.com/path-to-your-image.jpg',
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 144, 152, 145),
                    ),
                    otherAccountsPictures: [
                      Positioned(
                        right: 16.0,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: _showEditProfileDialog,
                        ),
                      ),
                    ],
                  ),
                  _buildExpansionTile(Icons.settings, 'Settings'),
                  _buildExpansionTile(Icons.call, 'Support'),
                  _buildExpansionTile(Icons.logout, 'Logout'),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Color.fromARGB(255, 236, 243, 236),
                        thickness: 1.0,
                      ),
                      SizedBox(height: 8.0),
                      _buildDrawerItem(Icons.star, 'Rate app'),
                      _buildDrawerItem(
                          Icons.description, 'Terms and conditions'),
                      _buildDrawerItem(Icons.contact_mail, 'Contact us'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label,
      {VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Color.fromARGB(255, 95, 173, 43),
          ),
          SizedBox(width: 10.0),
          InkWell(
            onTap: onPressed,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                color: Color.fromARGB(255, 12, 11, 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(IconData icon, String label) {
    return ExpansionTile(
      leading: Icon(
        icon,
        color: Color.fromARGB(255, 95, 173, 43),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 18.0,
          color: Color.fromARGB(255, 16, 16, 16),
        ),
      ),
      children: _buildExpansionTileChildren(label),
    );
  }

  List<Widget> _buildExpansionTileChildren(String label) {
    switch (label) {
      case 'Settings':
        return [
          ListTile(
            title: Text('General'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
        ];
      case 'Support':
        return [
          ListTile(
            title: Text('Contact Support'),
            onTap: () {
              // Add functionality to contact support
            },
          ),
        ];

      case 'Edit Profile':
        return [
          ListTile(
            title: Text('Update Profile'),
            onTap: () {
              // Add functionality to update user profile
              Navigator.pop(context); // Close the drawer
              _showEditProfileDialog();
            },
          ),
        ];
      case 'Logout':
        return [
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context); // Close the drawer

              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ];
      default:
        return [];
    }
  }
}
