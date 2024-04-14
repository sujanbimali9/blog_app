import 'package:blog_app/feature/home/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.userId,
      required super.topic,
      required super.updatedAt,
      required super.userName});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'user_id': userId,
      'image_url': imageUrl,
      'content': content,
      'topic': topic,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      title: map['title'] as String,
      userId: map['user_id'] as String,
      imageUrl: map['image_url'] as String,
      content: map['content'] as String,
      topic: List<String>.from((map['topic'] ?? [])),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
      userName: map['profiles']['name'],
    );
  }
}
