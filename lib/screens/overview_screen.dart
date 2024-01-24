// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:rova_23/screens/access_location.dart';
// import 'package:rova_23/screens/select_crops_screen.dart';

// class OverviewScreen extends StatefulWidget {
//   @override
//   _OverviewScreenState createState() => _OverviewScreenState();
// }

// class _OverviewScreenState extends State<OverviewScreen> {
//   int _currentIndex = 0;
//   CarouselController _carouselController = CarouselController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CarouselSlider(
//                 items: [
//                   buildCarouselItem(
//                     'The perfect doctor for your plant',
//                     'images/overview1.png',
//                   ),
//                   buildCarouselItem(
//                     'Scan your plant',
//                     'images/overview3.png',
//                   ),
//                   buildCarouselItem(
//                     'Get an instant report',
//                     'images/overview2.png',
//                   ),
//                 ],
//                 carouselController: _carouselController,
//                 options: CarouselOptions(
//                   height: 400,
//                   aspectRatio: 16 / 9,
//                   viewportFraction: 0.8,
//                   initialPage: 0,
//                   enableInfiniteScroll: false,
//                   enlargeCenterPage: true,
//                   scrollDirection: Axis.horizontal,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       _currentIndex = index;
//                     });
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   for (int i = 0; i < 3; i++)
//                     _buildDot(
//                       isActive: i == _currentIndex,
//                     ),
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: 20.0,
//             left: 20.0,
//             right: 20.0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AccessLocationScreen(
//                           data: '',
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text('Skip'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_currentIndex < 2) {
//                       _carouselController.nextPage();
//                     } else {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AccessLocationScreen(
//                             data: '',
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text('Next'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCarouselItem(String title, String imagePath) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           imagePath,
//           width: 200,
//           height: 200,
//         ),
//         SizedBox(height: 20),
//         Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget _buildDot({bool isActive = false}) {
//     return Container(
//       width: 8.0,
//       height: 8.0,
//       margin: EdgeInsets.symmetric(horizontal: 4.0),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: isActive ? Colors.blue : Colors.grey,
//       ),
//     );
//   }
// }
