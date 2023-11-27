import 'package:flutter/material.dart';
import 'components/pages/image_search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recherche d\'images',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageSearchPage(),
    );
  }
}
