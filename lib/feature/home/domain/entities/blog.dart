// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Blog {
  final String id;
  final String title;
  final String userId;
  final String imageUrl;
  final String content;
  final List<String> topics;
  final DateTime updatedAt;
  Blog(
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.userId,
    this.topics,
    this.updatedAt,
  );
}
