import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  final String stage;

  BlankPage({required this.stage});

  @override
  Widget build(BuildContext context) {
    String tomatoData = '''
      Tomato (Solanum lycopersicum), a flowering plant of the nightshade family (Solanaceae), cultivated extensively for its edible fruits.
      Labelled as a vegetable for nutritional purposes, tomatoes are a good source of vitamin C and the phytochemical lycopene.
      The fruits are commonly eaten raw in salads, served as a cooked vegetable, used as an ingredient in various prepared dishes, and pickled.
      Additionally, a large percentage of the world's tomato crop is processed; products include canned tomatoes, tomato juice, ketchup, puree, paste, and "sun-dried" tomatoes or dehydrated pulp.
    ''';

    return Scaffold(
      appBar: AppBar(
        title: Text(stage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add your text data for $stage here.',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              tomatoData,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
