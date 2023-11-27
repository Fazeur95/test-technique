import 'package:flutter_test/flutter_test.dart';
import 'package:searchimages/components/pages/image_search_page.dart';

void main() {
  testWidgets('ImageSearchPage builds without error', (tester) async {
    await tester.pumpWidget(ImageSearchPage());
  });
}
