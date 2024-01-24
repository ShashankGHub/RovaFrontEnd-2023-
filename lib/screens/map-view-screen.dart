// import 'dart:async';
// //import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator_platform_interface/src/models/position.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:rova_23/screens/Home_page_rova.dart';
// //import 'package:rova_23/screens/imagechooser.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// // ignore: must_be_immutable
// class MapViewScreen extends StatefulWidget {
//   final double? latitude, longitude;
//   late final String? currentAddress;
//   String? mode;
//   MapViewScreen(
//       {required this.latitude,
//       required this.longitude,
//       required this.currentAddress,
//       this.mode,
//       Position? currentPosition});

//   @override
//   State<MapViewScreen> createState() => _MapViewScreenState();
// }

// class _MapViewScreenState extends State<MapViewScreen> {
//   Completer<GoogleMapController> _controller = Completer();
//   final Set<Marker> markers = new Set();
//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }

//   Set<Marker> getmarkers() {
//     setState(() {
//       markers.add(Marker(
//         markerId: MarkerId(widget.currentAddress.toString()),
//         position: LatLng(widget.latitude!, widget.longitude!),
//         infoWindow: InfoWindow(
//           title: 'Your Current Address',
//           snippet: widget.currentAddress.toString(),
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ));
//     });
//     return markers;
//   }

//   _saveLocation() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('location', widget.currentAddress.toString());
//   }

//   void _onCameraMove(CameraPosition position) {
//     widget.currentAddress = position.target as String?;
//   }

//   bool showLoder = true;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         showLoder = false;
//       });
//     });
//     return Scaffold(
//         appBar: null,
//         body: showLoder == true
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : SafeArea(
//                 left: true,
//                 top: true,
//                 right: true,
//                 bottom: true,
//                 child: Stack(
//                   children: <Widget>[
//                     GoogleMap(
//                       onMapCreated: _onMapCreated,
//                       myLocationEnabled: true,
//                       indoorViewEnabled: true,
//                       trafficEnabled: true,
//                       markers: getmarkers(),
//                       onCameraMove: _onCameraMove,
//                       initialCameraPosition: CameraPosition(
//                         target: LatLng(widget.latitude!, widget.longitude!),
//                         zoom: 17.0,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Container(
//                               width: 200,
//                               height: 45,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     _saveLocation();
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => HomeScreen(),
//                                       ),
//                                     );
//                                   },
//                                   child: Text(
//                                     'NEXT',
//                                     style: TextStyle(fontSize: 18),
//                                   )))),
//                     ),
//                   ],
//                 ),
//               ));
//   }
// }
