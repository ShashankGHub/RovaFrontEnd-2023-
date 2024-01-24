import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rova_23/controllers/crop_info_controller.dart';
import 'package:rova_23/screens/crop_details_screen.dart';
import 'package:rova_23/Menu/settings_screen.dart';
import 'package:rova_23/screens/screens/storeScreen.dart';
import 'package:rova_23/screens/select_crops_screen.dart';
import 'package:rova_23/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CropInfoController _controller = CropInfoController();
  String weatherDescription = '';
  String location = '';
  double temperature = 0.0;
  int _currentIndex = 0;
  XFile? selectedImage;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final apiKey = 'YOUR_API_KEY';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=Dehradun&appid=$apiKey';

    try {
      var http;
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherDescription = data['weather'][0]['main'];
          location = data['name'];
          temperature = (data['main']['temp'] - 273.15); // Convert to Celsius
        });
      } else {
        print('Error fetching weather data: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  Future<void> _showOptionsDialog() async {
    return showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                    child: Text('Take a photo'),
                    onTap: () async {
                      await _getImageFromCamera();
                      Navigator.pop(context);

                      if (selectedImage != null)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectCropsScreen(
                              data: selectedImage!.path ?? "",
                            ),
                          ),
                        );
                    }),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Access gallery'),
                  onTap: () async {
                    await _getImageFromGallery();
                    Navigator.pop(context);
                    if (selectedImage != null)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectCropsScreen(
                            data: selectedImage!.path ?? "",
                          ),
                        ),
                      );
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
    selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 256,
      maxHeight: 256,
    );
    setState(() {
      selectedImage;
    });
    if (selectedImage != null) {
      // Process the image as needed.
    }
  }

  Future<void> _getImageFromCamera() async {
    selectedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 256,
      maxHeight: 256,
    );
    setState(() {
      selectedImage;
    });
    if (selectedImage != null) {
      // Process the image as needed.
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

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Add form fields to edit profile information
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                // Add more fields as needed
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
                // Add logic to save updated profile information
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.remove('token');
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage())); // Close the dialog
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
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
                      'ROVA',
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
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
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
                        'Partly Cloudy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Text(
                        '22°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'Dehradun',
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
                ),
                SizedBox(height: 20.0),
                Text(
                  'Detect disease',
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
                          Text('Scan infected crop'),
                        ],
                      ),
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
                        Text('Get instant report'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  'My Crops',
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
                      child: _buildCropBox('Tomato', 'images/tomato.png'),
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
                      child: _buildCropBox('Mango', 'images/mango.png'),
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
                      child: _buildCropBox('Cucumber', 'images/cucumber.png'),
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
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Center(
                  child: Stack(
                    children: [
                      Icon(Icons.qr_code_2_outlined),
                    ],
                  ),
                ),
                label: 'Scan',
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
                          'Acelucid',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail: Text(
                          '12345678999',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://example.com/path-to-your-image.jpg',
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 144, 152, 145),
                        ),
                      ),
                      _buildDrawerItem(Icons.edit, 'Edit Profile',
                          onPressed: _showEditProfileDialog),
                      _buildExpansionTile(Icons.settings, 'Settings',
                          onPressed: () {}),
                      _buildExpansionTile(Icons.support, 'Support',
                          onPressed: () {}),
                      _buildExpansionTile(Icons.logout, 'Logout',
                          onPressed: _showLogoutDialog),
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
        ));
  }

  Future<bool> _onBackPressed() async {
    print("Back button pressed");
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  print("Yes pressed");
                  exit(0);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false; // Provide a default value of 'false' if null is returned
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

  Widget _buildExpansionTile(IconData icon, String label,
      {required void Function() onPressed}) {
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
              _showLogoutDialog();
            },
          ),
        ];
      default:
        return [];
    }
  }
}
