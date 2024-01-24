// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:rova_23/screens/map-view-screen.dart';

// class AccessLocationScreen extends StatefulWidget {
//   final String? mode;

//   AccessLocationScreen({this.mode, required String data});

//   @override
//   State<AccessLocationScreen> createState() => _AccessLocationScreenState();
// }

// class _AccessLocationScreenState extends State<AccessLocationScreen> {
//   Position? _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentPosition();
//   }

//   Future<void> _getCurrentPosition() async {
//     try {
//       LocationPermission permission = await Geolocator.requestPermission();
//       final Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       print(position.latitude);
//       setState(() {
//         _currentPosition = position;
//       });
//       await _getAddressFromLatLng(_currentPosition!);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//     try {} catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: null,
//       body: _currentPosition == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               padding: const EdgeInsets.all(10),
//               color: Colors.white,
//               child: SafeArea(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 260,
//                         height: 260,
//                         margin: const EdgeInsets.only(top: 100),
//                         child: Image.asset(
//                           'images/location.png',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 20),
//                         child: Text(
//                           'Access Live Location',
//                           style: TextStyle(
//                             fontSize: 22,
//                             letterSpacing: 0.3,
//                             fontFamily: 'Poppins',
//                             color: Color(0xFF3D1766),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 0),
//                         child: Text(
//                           'Add your Location for Calculating Weather Data.',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 14,
//                             letterSpacing: 0.3,
//                             fontFamily: 'Poppins',
//                             color: Color(0xFF3D1766),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 335,
//                         height: 45,
//                         margin: const EdgeInsets.only(top: 60, bottom: 10),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => MapViewScreen(
//                                   latitude: _currentPosition!.latitude,
//                                   longitude: _currentPosition!.longitude,
//                                   currentAddress: "",
//                                 ),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             'ACCESS LOCATION',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'Poppins',
//                               letterSpacing: 0.4,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
