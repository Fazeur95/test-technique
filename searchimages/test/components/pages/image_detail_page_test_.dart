import 'package:flutter_test/flutter_test.dart';
import 'package:searchimages/components/pages/image_detail_page.dart';

void main() {
  testWidgets('ImageDetailPage builds without error', (tester) async {
    await tester.pumpWidget(ImageDetailPage(imageUrl: 'https://example.com/image.jpg'));
  });
}
