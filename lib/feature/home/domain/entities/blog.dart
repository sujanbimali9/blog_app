class Blog {
  final String id;
  final String title;
  final String userId;
  final String imageUrl;
  final String content;
  final List<String> topic;
  final DateTime updatedAt;
  final String? userName;
  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.userId,
    required this.topic,
    required this.updatedAt,
    required this.userName,
  });
}
