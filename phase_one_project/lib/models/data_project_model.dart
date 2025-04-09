class CardData {
  final String id;
  final String title;
  final String description;
  final String urlImage;

  CardData({
    required this.id,
    required this.title,
    required this.description,
    required this.urlImage,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      urlImage: json['url_image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'url_image': urlImage,
      };
}
