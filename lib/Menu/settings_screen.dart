import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rova_23/main.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;
  bool accessLocationEnabled = false;
  String selectedLanguage = 'English';
  changeAppLanguage(String Language) {
    switch (Language) {
      case "English":
        Get.updateLocale(Locale('en', 'US'));
        break;
      case "ಕನ್ನಡ":
        Get.updateLocale(Locale('kn', 'IN'));
        break;
      case "हिंदी":
        Get.updateLocale(Locale('hi', 'IN'));
        break;
      case "తెలుగు":
        Get.updateLocale(Locale('te', 'IN'));
        break;
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Language'),
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                    changeAppLanguage(selectedLanguage);
                  });
                },
                items: <String>['English', 'ಕನ್ನಡ', 'हिंदी', 'తెలుగు']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Access Location'),
              trailing: Switch(
                value: accessLocationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    accessLocationEnabled = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
