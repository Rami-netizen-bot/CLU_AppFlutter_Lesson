class NewArticle {
  String title;
  String description;
  String? imageUrl;
  String Content;
  String? publishedAt; // Variable

  NewArticle({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.Content,
    this.publishedAt, // Parameter
  });

  factory NewArticle.fromJson(Map<String, dynamic> json) {
    return NewArticle(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      imageUrl: json['urlToImage'],
      Content: json['Content'] ?? "",
      publishedAt: json['publishedAt'], // get key from API
    );
  }
}


