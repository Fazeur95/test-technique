import 'package:flutter_test/flutter_test.dart';
import 'package:searchimages/components/models/image_model.dart';

void main() {
  test('Image can be created from JSON', () {
    final json = {
      'tags': 'Example',
      'webformatURL': 'https://example.com/thumbnail.jpg',
      'largeImageURL': 'https://example.com/image.jpg',
    };
    final image = Image.fromJson(json);
    expect(image.title, equals('Example'));
    expect(image.thumbnailUrl, equals('https://example.com/thumbnail.jpg'));
    expect(image.fullImageUrl, equals('https://example.com/image.jpg'));
  });
}
