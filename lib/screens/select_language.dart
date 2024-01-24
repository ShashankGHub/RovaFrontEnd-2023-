// import 'package:flutter/material.dart';
// import 'package:rova_23/screens/overview_screen.dart';

// class LanguageModel {
//   String name;
//   String nativeName;
//   bool isSelected;

//   LanguageModel(this.name, this.nativeName, {this.isSelected = false});
// }

// class LanguageSelectionScreen extends StatefulWidget {
//   @override
//   _LanguageSelectionScreenState createState() =>
//       _LanguageSelectionScreenState();
// }

// class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
//   late LanguageModel _selectedLanguage;

//   @override
//   void initState() {
//     super.initState();

//     _selectedLanguage = _languages[0][0];
//     _languages[0][0].isSelected = true;
//   }

//   List<List<LanguageModel>> _languages = [
//     [LanguageModel('English', ''), LanguageModel('Hindi', 'हिन्दी')],
//     [LanguageModel('Kannada', 'ಕನ್ನಡ'), LanguageModel('Tamil', 'தமிழ்')],
//     [LanguageModel('Telugu', 'తెలుగు'), LanguageModel('Malayalam', 'മലയാളം')],
//   ];

//   void _handleLanguageSelection(LanguageModel selectedLanguage) {
//     setState(() {
//       _selectedLanguage.isSelected = false;
//       selectedLanguage.isSelected = true;
//       _selectedLanguage = selectedLanguage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isButtonEnabled = _selectedLanguage.isSelected;

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: Text(
//                 'Choose Your Language',
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 20),
//             Column(
//               children: [
//                 for (int i = 0; i < _languages.length; i++)
//                   Column(
//                     children: [
//                       if (i > 0) SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           for (var language in _languages[i])
//                             GestureDetector(
//                               onTap: () {
//                                 _handleLanguageSelection(language);
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 10),
//                                 child: Container(
//                                   width: 140, // Reduce the width of the card
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                     color: language.isSelected
//                                         ? Colors.green.withOpacity(0.2)
//                                         : Colors.white,
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     border: Border.all(
//                                       color: Colors.black87,
//                                       width: 2.0,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         offset: Offset(0, 2),
//                                         blurRadius: 4.0,
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         language.name,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Text(
//                                         language.nativeName,
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           SizedBox(width: 10),
//                         ],
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isButtonEnabled
//                   ? () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => OverviewScreen(),
//                         ),
//                       );
//                     }
//                   : null,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Text('Next', style: TextStyle(fontSize: 20)),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF0886ED),
//                 foregroundColor: Color(0xFFE8F0EF),
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
