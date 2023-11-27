class Image {
  // Définition des propriétés de la classe
  final String title;
  final String thumbnailUrl;
  final String fullImageUrl;

  // Constructeur de la classe
  Image({
    required this.title,
    required this.thumbnailUrl,
    required this.fullImageUrl,
  });

  // Méthode pour créer une instance de la classe à partir d'un JSON
  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      title: json['tags'], // Titre de l'image
      thumbnailUrl: json['webformatURL'], // URL de l'image en format web
      fullImageUrl: json['largeImageURL'], // URL de l'image en grand format
    );
  }
}
