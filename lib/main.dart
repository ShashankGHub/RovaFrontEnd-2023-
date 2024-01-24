import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rova_23/screens/Home_page_rova.dart';
import 'package:rova_23/screens/access_location.dart';
import 'package:rova_23/screens/select_crops_screen.dart';
import 'package:rova_23/screens/splash_screen.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      //supportedLocales: ,
      debugShowCheckedModeBanner: false,
      title: 'Rova-23',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => //HomeScreen(),
            SplashScreen(),
        '/queryScreen': (context) => const SelectCropsScreen(
              data: '',
            ),
        // '/accessLocationScreen': (context) => AccessLocationScreen(
        //       data: '',
        //     ),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
