import 'package:flutter/material.dart';

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;
  final String title; 

  ImageDetailPage({Key? key, required this.imageUrl, required this.title}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
  
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
