import 'dart:convert';

import 'package:blog_app/feature/home/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
    super.id,
    super.title,
    super.content,
    super.imageUrl,
    super.userId,
    super.topics,
    super.updatedAt,
  );
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'user_id': userId,
      'image_url': imageUrl,
      'content': content,
      'topics': topics,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      map['id'] as String,
      map['title'] as String,
      map['user_id'] as String,
      map['image_url'] as String,
      map['content'] as String,
      List<String>.from((map['topics'] ?? [])),
      map['updated_at'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }
}
