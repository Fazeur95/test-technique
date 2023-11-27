class Image {
  final String title;
  final String thumbnailUrl;
  final String fullImageUrl;

  Image({required this.title, required this.thumbnailUrl, required this.fullImageUrl});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      title: json['tags'],
      thumbnailUrl: json['webformatURL'],
      fullImageUrl: json['largeImageURL'],
    );
  }
}
