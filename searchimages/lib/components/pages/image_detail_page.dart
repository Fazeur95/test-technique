import 'package:flutter/material.dart';
class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  ImageDetailPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détail de l\'image'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}

