class Blog {
  final String id;
  final String title;
  final String userId;
  final String imageUrl;
  final String content;
  final List<String> topics;
  final DateTime updatedAt;
  final String? userName;
  Blog(
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.userId,
    this.topics,
    this.updatedAt,
    this.userName,
  );
}
