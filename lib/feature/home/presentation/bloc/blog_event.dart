part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String userId;
  final String title;
  final String content;
  final File file;
  final List<String> topics;

  BlogUpload(
      {required this.userId,
      required this.title,
      required this.content,
      required this.file,
      required this.topics});
}

final class AllBlog extends BlogEvent {}
