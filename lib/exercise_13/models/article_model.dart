
class Article {
  final String title;
  final String description;
  final String sourceName;
  final String articleUrl;
  final String? imageUrl;
  final DateTime? publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.sourceName,
    required this.articleUrl,
    this.imageUrl,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateString) {
      if (dateString == null) return null;
      try {
        return DateTime.parse(dateString);
      } catch (e) {
        return null;
      }
    }

    return Article(
      title: json['title'] ?? 'Tiêu đề không có',
      description: json['description'] ?? 'Không có mô tả',
      sourceName: json['source']?['name'] ?? 'Nguồn không xác định',
      articleUrl: json['url'] ?? '#',
      imageUrl: json['urlToImage'],
      publishedAt: parseDate(json['publishedAt']),
    );
  }
}