import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String weatherDescription = '';
  String location = '';
  double temperature = 0.0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch weather data
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final apiKey = 'YOUR_API_KEY';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=Dehradun&appid=$apiKey';

    try {
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
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Take a photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImageFromCamera();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Access gallery'),
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
      // Process the image as needed.
    }
  }

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final imageTemporary = image.path;
      // Process the image as needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
                  'Hello user',
                  style: TextStyle(fontSize: 28.0),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.account_circle),
                ),
              ],
            ),
            SizedBox(height: 45.0),
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
                          Text(
                            weatherDescription,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
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
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '${temperature.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Detect Disease',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      Image.asset(
                        'images/overview3.png',
                        width: 120.0,
                        height: 120.0,
                      ),
                      SizedBox(height: 8.0),
                      Text('Scan infected crop'),
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
                      width: 130.0,
                      height: 130.0,
                    ),
                    SizedBox(height: 8.0),
                    Text('Get instant report'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50.0),
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
                    // Handle crop selection
                  },
                  child: _buildCropBox('Tomato', 'images/tomato.png'),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle crop selection
                  },
                  child: _buildCropBox('Mango', 'images/mango.png'),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle crop selection
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
        backgroundColor: Colors.green,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) {
              _showOptionsDialog();
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
                  Icon(Icons.camera),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 8.0,
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCropBox(String cropName, String imagePath) {
    return Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.green,
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
}
