import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:searchimages/components/pages/image_search_page.dart';

void main() {
  testWidgets('ImageSearchPage has a title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ImageSearchPage(),
    ));

    expect(find.text('Recherche d\'images'), findsOneWidget);
  });
}
